terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "solution-bucket3"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}


provider "aws" {
  region = var.region
}