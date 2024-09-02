resource "aws_iam_role" "glue_role" {
  name = "glue-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_role_policy" {
  role = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

data "aws_iam_policy_document" "glue_s3_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.athena_bucket.arn,
      "${aws_s3_bucket.athena_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "glue_s3_access_policy" {
  name   = "GlueS3AccessPolicy"
  role   = aws_iam_role.glue_role.id
  policy = data.aws_iam_policy_document.glue_s3_access.json
}
