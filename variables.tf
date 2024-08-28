variable "region" {
  default = "us-east-1"
}




variable "s3_data_prefix" {
  type = string
  default = "result/"
  
}
variable "glue_catalog_db" {
  type = string
  default = "terra_athena_database"
}

variable "glue_catalog_table" {
  type = string
  default = "terra_athena_table"
}

variable "athena_query" {
  type = string
  default = "SELECT * from terra_anthena_table LIMIT 10;"
  
}
