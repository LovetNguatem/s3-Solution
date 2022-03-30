variable "region" {
  type        = string
  description = "region for provider"

}

variable "dynamodb_table" {
  type        = string
  description = "holds value for table name"
}

variable "bucket_name" {
  type        = string
  description = "holds value for bucket name"
}
