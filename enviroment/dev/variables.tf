variable "api_core" {
  default = "users"
}

variable "api_core_booking" {
  default = "api_core_booking"
}

variable "api_endpoints_register" {
  default =   "register"
}

variable "api_endpoints_login" {
  default =   "login"
}

variable "api_booking" {
  default =   "booking"
}

variable "api_endpoints_create_booking" {
  default =   "create_booking"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "enviroment" {
  default = "dev"
}

variable "jwt_secret" {
  default = "anVuZ2xlIHh5bG9waG9uZSB1bWJyZWxsYSBkb2xwaGluIHVtYnJlbGxhIHF1aWx0IG5hcndoYWwgYWlycGxhbmUgbW91bnRhaW4geHlsb3Bob25l"
  
}

variable "tags" {
  default = {
    BU            = "AYO-001"
    Environment   = "dev"
    Name          = "serveless-resources"
    Department    = "eng software"
    Owner         = "kidboo squard"
    Workload      = "booking-system"
  }
}