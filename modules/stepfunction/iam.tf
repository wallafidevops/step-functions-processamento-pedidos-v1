
resource "aws_iam_role" "step_function_role" {
  name = var.step_function_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "states.${var.aws_region}.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "step_function_policy" {
  name = "${var.step_function_role_name}-policy"
  role = aws_iam_role.step_function_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      { Effect = "Allow", Action = ["lambda:InvokeFunction"], Resource = [var.lambda_valida_arn, var.lambda_estoque_arn] },
      { Effect = "Allow", Action = ["sqs:SendMessage"], Resource = var.sqs_queue_arn },
      { Effect = "Allow", Action = ["dynamodb:PutItem"], Resource = var.dynamodb_table_arn }
    ]
  })
}

output "step_function_role_arn" {
  value = aws_iam_role.step_function_role.arn
}
