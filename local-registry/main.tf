provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
}

resource "kubernetes_config_map" "config_01" {
  metadata {
    name      = "local-registry-hosting"
    namespace = "kube-public"
  }

  data = {
    "localRegistryHosting.v1" = <<-EOF
      host = "localhost:${var.registry_port}"
      help = "https://kind.sigs.k8s.io/docs/user/local-registry/"
    EOF
  }
}
