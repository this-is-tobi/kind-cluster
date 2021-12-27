output "nginx_ingress_started" {
  value = true
  depends_on = [
    null_resource.wait_for_ingress_nginx
  ]
}
