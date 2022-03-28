#########################################
#create S3 bucket
#########################################
/*
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = var.region
}
*/

module "s3_backend_bucket" {
  source         = "/Users/lovetnguatem/Documents/s3-Solution/s3-bucket-backend/s3Module/"
  bucket_name    = var.bucket_name
  dynamodb_table = var.dynamodb_table
  region         = var.region


}
