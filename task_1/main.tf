provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

# Configure the Terraform backend to use the created S3 bucket and DynamoDB table
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket                   = "rsschool-devops-course-task1-tf-state-bucket"
    key                      = "env/dev/terraform.tfstate"
    region                   = "us-east-1"
    encrypt                  = true
    dynamodb_table           = "rsschool-devops-course-task1-terraform-lock"
    shared_credentials_files = ["~/.aws/credentials"]
  }
}




