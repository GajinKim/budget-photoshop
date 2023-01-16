terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Configure aws provider
provider "aws" {
  region = "us-east-1"
}

# Static Website module
module "s3" {
        source = "./modules/s3"
        bucket_name = var.bucket_name
}