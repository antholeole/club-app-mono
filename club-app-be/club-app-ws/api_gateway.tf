terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key_id
}


resource "aws_apigatewayv2_api" "clubappgateway" {
  name                       = "club-app-ws-gateway"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.route"
}


#connect route
resource "aws_apigatewayv2_route" "clubappgateway" {
  api_id    = aws_apigatewayv2_api.clubappgateway.id
  route_key = "$connect"

  target = "integrations/${aws_apigatewayv2_integration.connect.id}"
}

resource "aws_apigatewayv2_integration" "connect" {
  api_id           = aws_apigatewayv2_api.clubappgateway.id
  integration_type = "HTTP"
  integration_method = "GET"
  integration_uri = "https://getclub.app/gateway/connect"
}