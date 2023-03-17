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