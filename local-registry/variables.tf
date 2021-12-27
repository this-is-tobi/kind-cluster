variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "~/.kube/config"
}

variable "registry_name" {
  type        = string
  description = "The name of the local registry to pull local docker images."
  default     = "local-registry"
}

variable "registry_port" {
  type        = string
  description = "The port of the local registry to pull local docker images."
  default     = "5000"
}
