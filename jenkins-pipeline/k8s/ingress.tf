resource "kubernetes_ingress_v1" "notes-app-ingress" {
  metadata {
    name = "notes-app-ingress"
    labels = {
      name = "notes-app-ingress"
    }
  }
  annotations = {
    "kubernetes.io/ingress.class" = "nginx"
  }

  spec {
    rule {
      host = "notes-app.tuyojr.me"
      http {
        path {
          backend {
            service_name = "notes-app-deployment"
            service_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "sock-shop-ingress" {
  metadata {
    name      = "sock-shop-ingress"
    namespace = "sock-shop"
    labels = {
      name = "front-end"
    }
  }
  spec {
    rule {
      host = "sock-shop.tuyojr.me"
      http {
        path {
          backend {
            service_name = "front-end"
            service_port = 80
          }
        }
      }
    }
  }
}