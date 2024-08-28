provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "athena_bucket" {
  bucket = "terra-athena-bucket"
}

resource "aws_s3_object" "data_folder" {
  bucket = aws_s3_bucket.athena_bucket.bucket
  key    = var.s3_data_prefix
}

resource "aws_glue_catalog_database" "athena_database" {
  name = "terra_athena_database"
}

resource "aws_glue_catalog_table" "athena_table" {
  name          = var.glue_catalog_table
  database_name = aws_glue_catalog_database.athena_database.name

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
