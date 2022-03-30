
# remote backend. 



module "s3_backend_bucket" {
  source         = "/Users/lovetnguatem/Documents/s3-Solution/s3-bucket-backend/s3Module/"
  bucket_name    = var.bucket_name
  dynamodb_table = var.dynamodb_table
  region         = var.region


}
