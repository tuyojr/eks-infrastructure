# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "tuyojr-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "tuyojr-vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.19.0"
  name            = "tuyojr-vpc"
  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                  = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"         = 1
  }
}

module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "${local.cluster_name}"
    cluster_version = "1.24"

    cluster_endpoint_public_access  = true

    vpc_id = module.tuyojr-vpc.vpc_id
    subnet_ids = module.tuyojr-vpc.private_subnets

    tags = {
      
    }

    eks_managed_node_groups = {
    one = {
      name = "worker-node-1"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }

    two = {
      name = "worker-node-2"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }

    three = {
      name = "worker-node-3"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}

# make sure you have the latest version of kubectl on your lcoal machine
# on your local machine, run the following command to install the aws-iam-authenticator
# curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
# chmod +x ./aws-iam-authenticator
# mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
# echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
# aws-iam-authenticator help
# aws-iam-authenticator version
# next, configure kubectl to connect to your cluster
# aws eks --region us-east-1 update-kubeconfig --name <cluster name created>
# install the weave-net CNI plugin
# kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

