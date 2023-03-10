terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  # remote state bucket
    backend "s3" {
    bucket = "gajin-tf-state-bucket"
    key    = "gajin-terraform-ec2-in-depth-exercise"
    region = "us-east-1"
  }
}

# Configure aws provider
provider "aws" {
  region = "us-east-1"
}

# Static Website module
module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "rds" {
  source                  = "./modules/rds"
  mysql_security_group_id = module.security.mysql_security_group_id
}

module "security" {
  source = "./modules/security"
}

module "ec2" {
  source                    = "./modules/ec2"
  website_security_group_id = module.security.website_security_group_id
  website_vpc_id            = var.default_vpc_id
}
