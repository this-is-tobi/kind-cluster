resource "null_resource" "start_kind_registry" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = "/bin/sh ./scripts/start-local-registry.sh -n $REGISTRY_NAME -p $REGISTRY_PORT"
    environment = {
      REGISTRY_NAME = var.registry_name
      REGISTRY_PORT = var.registry_port
    }
  }
}

resource "kind_cluster" "default" {
  name            = var.kind_cluster_name
  kubeconfig_path = pathexpand(var.kind_cluster_config_path)
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    containerd_config_patches = [
      <<-TOML
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${var.registry_port}"]
        endpoint = ["http://${var.registry_name}:${var.registry_port}"]
      TOML
    ]

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    node {
      role = "worker"
    }
  }

  depends_on = [
    null_resource.start_kind_registry
  ]
}

resource "null_resource" "connect_to_kind_registry" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = "/bin/sh ./scripts/connect-local-registry.sh $REGISTRY_NAME"
    environment = {
      REGISTRY_NAME = var.registry_name
    }
  }

  depends_on = [
    kind_cluster.default
  ]
}

