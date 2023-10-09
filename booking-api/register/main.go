package main

import (
	"context"
	"encoding/json"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

const (
	MinCost     int = 4  // the minimum allowable cost as passed in to GenerateFromPassword
	MaxCost     int = 31 // the maximum allowable cost as passed in to GenerateFromPassword
	DefaultCost int = 10 // the cost that will actually be set if a cost below MinCost is passed into GenerateFromPassword
)

func registerUser(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var user User
	if err := json.Unmarshal([]byte(request.Body), &user); err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Body:       "Invalid request body",
		}, nil
	}

	sess := session.Must(session.NewSession())
	svc := dynamodb.New(sess)

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.MinCost)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 500,
			Body:       "Error hashing password",
		}, err
	}
	user.ID = uuid.New().String()

	item := map[string]*dynamodb.AttributeValue{
		"id": {
			S: aws.String(user.ID),
		},
		"name": {
			S: aws.String(user.Name),
		},
		"email": {
			S: aws.String(user.Email),
		},
		"password": {
			S: aws.String(string(hashedPassword)),
		},
	}

	_, err = svc.PutItemWithContext(ctx, &dynamodb.PutItemInput{
		TableName: aws.String(os.Getenv("DYNAMODB_USERS_TABLE")),
		Item:      item,
	})
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 500,
			Body:       "Error inserting user into DynamoDB",
		}, err
	}

	responseBody := map[string]string{"message": "Usuário inserido com sucesso!"}
	responseJSON, _ := json.Marshal(responseBody)

	return events.APIGatewayProxyResponse{
		StatusCode: 201,
		Body:       string(responseJSON),
	}, nil
}

func main() {
	lambda.Start(registerUser)
}
