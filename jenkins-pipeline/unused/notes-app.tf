resource "kubernetes_deployment" "notes-app" {
  metadata {
    name = "notes-app-deployment"
    labels = {
      name = "notes-app"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        name = "notes-app"
      }
    }

    template {
      metadata {
        labels = {
          name = "notes-app"
        }
      }
      spec {
        container {
          name  = "notes-app-deployment"
          image = "tuyojr/notes-app:stable"

          port {
            container_port = 3000
          }

          resources {
            requests = {
              cpu = "100m"
            }
          }
          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}

resource "kubernetes_service" "notes-app" {
  metadata {
    name = "notes-app-service"
  }
  spec {
    selector = {
      name = "notes-app"
    }
    port {
      port        = 8080
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

output "lb_ip_notes-app" {
  value = kubernetes_service.notes-app.status.0.load_balancer.0.ingress[0].ip
}