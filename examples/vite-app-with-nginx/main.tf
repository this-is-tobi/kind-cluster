provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
}


#--------------------------#
# Setup up nginx container #
#--------------------------#
resource "kubernetes_pod" "pod_01" {
  metadata {
    name = "webserver"
    labels = {
      App = "nginx-vite"
    }
    namespace = "default"
  }

  spec {
    container {
      image = "localhost:5000/vite:latest"
      name  = "myviteapp"
      port {
        container_port = 80
      }
    }
  }
}


#------------------------#
# Setup up nginx service #
#------------------------#
resource "kubernetes_service" "service_01" {
  metadata {
    name = "webserver-service"
  }

  spec {
    selector = {
      App = kubernetes_pod.pod_01.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }

  depends_on = [
    kubernetes_pod.pod_01
  ]
}


#------------------------------#
# Setup up nginx ingress rules #
#------------------------------#
resource "kubernetes_ingress" "ingress_01" {
  metadata {
    name = "webserver-ingress"
  }

  spec {
    backend {
      service_name = "webserver"
      service_port = 80
    }

    rule {
      http {
        path {
          backend {
            service_name = "webserver-service"
            service_port = 80
          }

          path = "/"
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }

  depends_on = [
    kubernetes_service.service_01
  ]
}
