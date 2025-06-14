

provider "aws" {
  region = var.aws_region
}


terraform {
  backend "s3" {
    bucket         = "rm-state-6189"
    key            = "step-functions/processamento-pedido/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "terraform-lock-table"
  }
}