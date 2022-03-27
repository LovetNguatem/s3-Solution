#########################################
#create S3 bucket
#########################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
  access_key = "AKIA4AUO6GOUE2DHFNPY"
  secret_key = "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"
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "solution_bucket" {
  bucket = "solution_bucket3"

}
 /*
  versioning {
    enabled = true
  }
*/

resource "aws_s3_bucket_versioning" "versioning_solution_bucket" {
  bucket = aws_s3_bucket.solution_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  bucket = aws_s3_bucket.solution_bucket.id
 
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }


################################################
#Dynamodb to lock terraform state
################################################
resource "aws_dynamodb_table" "terraform-lock" {
  name             = "terraform-lock"
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }


}