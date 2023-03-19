data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../aws/terraform.tfstate"
  }
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

resource "time_sleep" "wait_for_kubernetes" {

    depends_on = [data.aws_eks_cluster.cluster]

    create_duration = "20s"
}

resource "kubernetes_namespace" "namespace" {

  depends_on = [time_sleep.wait_for_kubernetes]
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  depends_on = [kubernetes_namespace.namespace, time_sleep.wait_for_kubernetes]
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.namespace
  create_namespace = true
  version    = "45.7.1"
  values = [
    file("values.yaml")
  ]
  timeout = 2000
  

set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  # You can provide a map of value using yamlencode. Don't forget to escape the last element after point in the name
  set {
    name = "server\\.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}
  