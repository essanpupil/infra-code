terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket = "platform-dev-terraform-state"
    key    = "dev/singapore/eks/pos-cluster/terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
