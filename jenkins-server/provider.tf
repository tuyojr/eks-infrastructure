terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}