# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {

/*
  cloud {
    workspaces {
      name = "learn-terraform-eks"
    }
  }
*/

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.6.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.3"
}

