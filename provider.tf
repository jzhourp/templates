##############################################################################################
// Terraform provider setup
##############################################################################################
# Use the provider congifuration blocks for declaring version controls 
# Comment out the "cloud" block until the IAM role has been instantiated
# Uncomment before making PR to prod
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
