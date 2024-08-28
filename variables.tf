variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  type        = string
  default     = "terra-athena-bucket"
}

variable "s3_data_prefix" {
  type        = string
  default     = "data/"
}

variable "athena_database_name" {
  type        = string
  default     = "terra_athena_database"
}

variable "athena_table_name" {
  type        = string
  default     = "terra_athena_table"
}

variable "athena_query" {
  type        = string
  default     = "SELECT * FROM terra_athena_table LIMIT 10;"
}
