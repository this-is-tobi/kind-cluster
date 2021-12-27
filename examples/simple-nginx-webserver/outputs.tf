output "app_deployed" {
  value = true
  depends_on = [
    kubernetes_ingress.ingress_01
  ]
}
