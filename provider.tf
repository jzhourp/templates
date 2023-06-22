terraform {
  required_version = ">= 1.4.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
  cloud {
    organization = "RealPage-CloudOps"
    workspaces {
      tags = ["ACC"] // Use tags when mapping workspaces to git branches
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
