resource "aws_lambda_function" "valida_pedido" {
  function_name    = var.lambda_valida_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = var.lambda_runtime
  filename         = "${path.module}/valida_pedido.zip"
  source_code_hash = filebase64sha256("${path.module}/valida_pedido.zip")


}

resource "aws_lambda_function" "verifica_estoque" {
  function_name    = var.lambda_estoque_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = var.lambda_runtime
  filename         = "${path.module}/verifica_estoque.zip"
  source_code_hash = filebase64sha256("${path.module}/verifica_estoque.zip")

}

