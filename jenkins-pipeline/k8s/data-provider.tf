data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../aws/terraform.tfstate"
  }
}

# Retrieve EKS cluster information
provider "aws" {
  region = data.terraform_remote_state.eks.outputs.region
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

# data "aws_eks_node_group" "node_group" {
#   cluster_name = "${data.aws_eks_cluster.cluster.name}"
#   for_each = data.terraform_remote_state.eks.output.eks_managed_node_groups
#   node_group_name = each.value.name
# }

provider "kubernetes" {
  # host                   = data.aws_eks_cluster.cluster.endpoint
  # cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   args = [
  #     "eks",
  #     "get-token",
  #     "--cluster-name",
  #     data.aws_eks_cluster.cluster.name
  #   ]
  # }
  config_path = "~/.kube/config"
}

# provider "acme" {
#   # server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
#   server_url = "https://acme-v02.api.letsencrypt.org/directory"
# }

provider "helm" {
  kubernetes {
    # host                   = data.aws_eks_cluster.cluster.endpoint
    # cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   command     = "aws"
    #   args = [
    #     "eks",
    #     "get-token",
    #     "--cluster-name",
    #     data.aws_eks_cluster.cluster.name
    #   ]
    # }
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  load_config_file = false
  host             = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token           = data.aws_eks_cluster_auth.cluster.token
  config_path = "~/.kube/config"
}