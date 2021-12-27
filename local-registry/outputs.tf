output "registry_connected" {
  value = true
  depends_on = [
    kubernetes_config_map.config_01
  ]
}
