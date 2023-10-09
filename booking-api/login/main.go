package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
	"github.com/dgrijalva/jwt-go"
	"golang.org/x/crypto/bcrypt"
)

var (
	dynamoDBClient *dynamodb.DynamoDB
	awsRegion      string
	tableName      string
	emailGSI       string
	jwtSecret      string
)

func init() {
	// Configure AWS SDK
	awsRegion = os.Getenv("AWS_REGION")
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String(awsRegion),
	})
	if err != nil {
		fmt.Printf("Error creating AWS session: %v\n", err)
		os.Exit(1)
	}

	dynamoDBClient = dynamodb.New(sess)
	tableName = os.Getenv("DYNAMODB_USERS_TABLE")
	emailGSI = os.Getenv("EMAIL_GSI")
	jwtSecret = os.Getenv("JWT_SECRET")
}

func main() {
	lambda.Start(handler)
}

type User struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type Response struct {
	Token string `json:"token"`
}

func handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var user User

	err := json.Unmarshal([]byte(request.Body), &user)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: http.StatusBadRequest,
			Body:       "Bad Request",
		}, err
	}

	// Query DynamoDB for user with the given email
	queryInput := &dynamodb.QueryInput{
		TableName:              aws.String(tableName),
		IndexName:              aws.String(emailGSI),
		KeyConditionExpression: aws.String("email = :email"),
		ExpressionAttributeValues: map[string]*dynamodb.AttributeValue{
			":email": {
				S: aws.String(user.Email),
			},
		},
	}

	queryOutput, err := dynamoDBClient.QueryWithContext(ctx, queryInput)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: http.StatusInternalServerError,
			Body:       "Internal Server Error",
		}, err
	}

	// Check if user exists
	if len(queryOutput.Items) == 0 {
		return events.APIGatewayProxyResponse{
			StatusCode: http.StatusUnauthorized,
			Body:       "Forbidden User Exist",
		}, nil
	}

	dbUser := User{}
	err = dynamodbattribute.UnmarshalMap(queryOutput.Items[0], &dbUser)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: http.StatusInternalServerError,
			Body:       "Internal Server Error",
		}, err
	}
	fmt.Print(dbUser)

	// Compare passwords
	hashedPassword := dbUser.Password
	userPassword := user.Password
	err := bcrypt.CompareHashAndPassword([]byte(userPassword), []byte(hashedPassword))
	if err != nil {
		// Se err for diferente de nil, a senha não corresponde
		fmt.Println("Senha incorreta")
	} else {
		// Senha correta
		fmt.Println("Senha correta")
	}
	fmt.Printf("ta aki oh" + user.Password)

	// Generate JWT token
	token, err := generateJWTToken(dbUser)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: http.StatusInternalServerError,
			Body:       "Internal Server Error",
		}, err
	}

	response := Response{Token: token}
	responseJSON, _ := json.Marshal(response)

	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Body:       string(responseJSON),
	}, nil
}

func comparePasswords(inputPassword, hashedPassword string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(inputPassword))
	return err == nil
}

func generateJWTToken(user User) (string, error) {
	claims := jwt.MapClaims{
		"email": user.Email,
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString([]byte(jwtSecret))
	if err != nil {
		return "", err
	}

	return tokenString, nil
}
