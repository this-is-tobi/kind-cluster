output "cluster_deployed" {
  value = true
  depends_on = [
    null_resource.connect_to_kind_registry
  ]
}
