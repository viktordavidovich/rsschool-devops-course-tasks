provider "aws" {
  region = var.aws_region
  profile = "default"
  shared_credentials_files = ["~/.aws/credentials"]
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
    bucket         = "rsschool-devops-course-task1-tf-state-bucket"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "rsschool-devops-course-task1-terraform-lock"
    shared_credentials_files = ["~/.aws/credentials"]
  }
}

resource "aws_s3_bucket" "temp_bucket" {
  bucket = "my-temp-terraform-state-bucket"
}


