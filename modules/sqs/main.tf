
resource "aws_sqs_queue" "this" {
  name = var.sqs_queue_name
}
