resource "kubernetes_ingress_v1" "notes-app-ingress" {
  metadata {
    name = "notes-app-ingress"
    labels = {
      name = "notes-app-ingress"
    }
    annotations = {
    "kubernetes.io/ingress.class" = "nginx"
  }
  }

  spec {
    rule {
      host = "notes-app.tuyojr.me"
      http {
        path {
          backend {
            service {
              name = "notes-app-deployment"
              port {
                number = 80
              }
            }
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
            service {
              name = "front-end"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}