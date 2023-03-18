resource "time_sleep" "wait_for_kubernetes" {
  create_duration = "30s"
  depends_on = [data.aws_eks_cluster.cluster]
}

resource "kubernetes_namespace" "nginx-ingress" {
  depends_on = [time_sleep.wait_for_kubernetes]
  metadata {
    name = "nginx-ingress"
  }
}

resource "helm_release" "nginx-ingress" {
  depends_on = [kubernetes_namespace.nginx-ingress, time_sleep.wait_for_kubernetes]
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.nginx-ingress.metadata[0].name
  version    = "4.5.20"
  values = [file("nginx-ingress-values.yml")]
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name = "podSecurityPolicy.enabled"
    value = true
  }
  set {
    name = "server.persistentVolume.enabled"
    value = false
  }
}

resource "kubernetes_namespace" "monitoring" {
  depends_on = [time_sleep.wait_for_kubernetes]
    metadata {
        name = "prometheus"
    }
}

resource "helm_release" "prometheus" {
  depends_on = [kubernetes_namespace.monitoring, time_sleep.wait_for_kubernetes]
  name = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  namespace = kubernetes_namespace.monitoring.metadata[0].name
  create_namespace = true
  version = "45.7.1"
  values = [file("prometheus-values.yml")]

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }
}

# resource "helm_release" "prometheus" {
#     name       = "prometheus"
#     repository = "https://prometheus-community.github.io/helm-charts"
#     chart      = "prometheus"
#     namespace  = "monitoring"

#     set {
#       name  = "server.service.type"
#       value = "NodePort"
#     }
# }

# resource "helm_release" "grafana" {
#     name       = "grafana"
#     repository = "https://grafana.github.io/helm-charts"
#     chart      = "grafana"
#     namespace  = "monitoring"

#     set {
#       name  = "service.type"
#       value = "NodePort"
#     }
# }