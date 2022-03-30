

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "solution_bucket" {
  bucket = var.bucket_name

}


#versioning of s3 bucket 


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
  name             = var.dynamodb_table
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }


}