resource "kubernetes_ingress" "notes-app-ingress" {
  metadata {
    name = "notes-app-ingress"
  }

  spec {
    tls {
      hosts       = ["notes-app.tuyojr.me"]
      secret_name = module.acm.arn
    }

    rule {
      host = "notes-app.tuyojr.me"

      http {
        path {
          backend {
            service_name = kubernetes_service.notes-app.metadata[0].name
            service_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress" "sock-shop-ingress" {
  metadata {
    name      = "sock-shop-ingress"
    namespace = kubernetes_namespace.sock-shop.metadata[0].name
  }
  spec {
    tls {
      hosts       = ["sock-shop.tuyojr.me"]
      secret_name = module.acm.arn
    }
    rule {
      host = "sock-shop.tuyojr.me"
      http {
        path {
          backend {
            service_name = kubernetes_service.front-end.metadata[0].name
            service_port = 80
          }
        }
      }
    }
  }
}