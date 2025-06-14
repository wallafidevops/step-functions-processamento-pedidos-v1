
variable "aws_region" { default = "us-east-1" }
variable "sqs_queue_name" {}
variable "dynamodb_table_name" {}
variable "lambda_role_name" {}
variable "lambda_valida_name" {}
variable "lambda_estoque_name" {}
variable "lambda_runtime" { default = "python3.12" }
variable "step_function_name" {}
variable "step_function_role_name" {}
