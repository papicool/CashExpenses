terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

module "cashExpenses" {
  source = "./modules/expenses"
  public_path =  var.expenses.public_path
  user_uuid= "pmf"
} 