provider "aws" {
  region = "eu-west-2"
}

locals {
  ingress = [
    {
      port        = 443
      description = "Allow HTTPS from my local machine"
      protocol    = "tcp"
    },
    {
      port        = 22
      description = "Allow SSH from my local machine"
      protocol    = "tcp"
    },
    {
      port        = 80
      description = "Allow HTTP from my local machine"
      protocol    = "tcp"
    }
  ]
}