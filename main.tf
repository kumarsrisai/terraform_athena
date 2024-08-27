provider "aws" {
  region = "us-east-1" 
}


resource "aws_s3_bucket" "athena_bucket" {
  bucket = "terra-athena-bucket" 
}
resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket = aws_s3_bucket.athena_bucket.bucket
    acl = "private"
  
}
resource "aws_s3_object" "data_folder" {
  bucket = aws_s3_bucket.athena_bucket.bucket
  key    = "athena/" 
}


resource "aws_glue_catalog_table" "athena_table" {
  name          = "terra_athena_table"
  database_name = "terra_athena_database"

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.athena_bucket.bucket}/${aws_s3_object.data_folder.key}"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }

    columns {
      name = "id"
      type = "int"
    }

    columns {
      name = "name"
      type = "string"
    }

    columns {
      name = "email"
      type = "string"
    }

    columns {
      name = "created_at"
      type = "timestamp"
    }

    columns {
      name = "status"
      type = "boolean"
    }
  }
}
