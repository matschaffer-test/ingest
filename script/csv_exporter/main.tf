provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "lambda_role" {
  name = "aws-lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "csv_exporter_lambda" {
  filename = "package.zip"
  function_name = "csv_exporter"
  role = "${aws_iam_role.lambda_role.arn}"
  handler = "index.handler"
  source_code_hash = "${base64sha256(file("package.zip"))}"
  runtime = "nodejs4.3"
  timeout = 5
}
