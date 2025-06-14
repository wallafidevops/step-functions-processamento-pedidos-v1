

module "sqs" {
  source = "./modules/sqs"
  sqs_queue_name = var.sqs_queue_name
}

module "dynamodb" {
  source = "./modules/dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}



module "lambda" {
  source = "./modules/lambda"
  lambda_role_name = var.lambda_role_name
  lambda_valida_name = var.lambda_valida_name
  lambda_estoque_name = var.lambda_estoque_name
  lambda_runtime = var.lambda_runtime

}

module "stepfunction" {
  source = "./modules/stepfunction"
  aws_region = var.aws_region
  step_function_name = var.step_function_name
  step_function_role_name = var.step_function_role_name
  lambda_valida_arn = module.lambda.valida_pedido_arn
  lambda_estoque_arn = module.lambda.verifica_estoque_arn
  dynamodb_table_name = module.dynamodb.table_name
  dynamodb_table_arn = module.dynamodb.table_arn
  sqs_queue_url = module.sqs.queue_url
  sqs_queue_arn = module.sqs.queue_arn
}
