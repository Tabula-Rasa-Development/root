terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.12"
    }
  }
  required_version = ">= 1.2.0"

  cloud {
    organization = "tabula-rasa-development"
    workspaces {
      name = "root-iam"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}
