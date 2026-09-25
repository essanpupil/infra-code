terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket = "platform-dev-terraform-state"
    key    = "github/repo/infra-repo/terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.github_owner
}
