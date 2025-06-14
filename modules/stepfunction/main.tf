
resource "aws_sfn_state_machine" "this" {
  name = var.step_function_name
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    StartAt = "ValidaPedido",
    States = {
      ValidaPedido = {
        Type = "Task",
        Resource = var.lambda_valida_arn,
        Next = "VerificaEstoque"
      },
      VerificaEstoque = {
        Type = "Task",
        Resource = var.lambda_estoque_arn,
        Next = "ChecaEstoque"
      },
      ChecaEstoque = {
        Type = "Choice",
        Choices = [
          { Variable = "$.tem_estoque", BooleanEquals = true, Next = "GravaPedidoConfirmado" }
        ],
        Default = "NotificarEstoque"
      },
      GravaPedidoConfirmado = {
        Type = "Task",
        Resource = "arn:aws:states:::dynamodb:putItem",
        Parameters = {
          TableName = var.dynamodb_table_name,
          Item = { id = { "S" = "$$.Execution.Id" }, status = { "S" = "Pedido Confirmado" } }
        },
        Next = "Fim"
      },
      NotificarEstoque = {
        Type = "Task",
        Resource = "arn:aws:states:::sqs:sendMessage",
        Parameters = {
          QueueUrl = var.sqs_queue_url,
          MessageBody = { aviso = "Falta de estoque detectada", pedido = "$$.Execution.Id" }
        },
        Next = "Fim"
      },
      Fim = { Type = "Pass", End = true }
    }
  })
}
