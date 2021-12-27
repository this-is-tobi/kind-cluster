#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'


# Get project directories
PROJECT_DIR="$(pwd)"
KIND_DIR="$PROJECT_DIR/kind-cluster"
REGISTRY_DIR="$PROJECT_DIR/local-registry"
INGRESS_DIR="$PROJECT_DIR/nginx-ingress"


printf "\n${red}I.${no_color} Destroy nginx ingress controller\n"
cd $INGRESS_DIR
terraform destroy -auto-approve
rm -rf .terraform
rm -rf .terraform.lock.hcl
rm -rf terraform.tfstate*


printf "\n${red}II.${no_color} Destroy local registry configmap\n"
cd $REGISTRY_DIR
terraform destroy -auto-approve
rm -rf .terraform
rm -rf .terraform.lock.hcl
rm -rf terraform.tfstate*


printf "\n${red}III.${no_color} Destroy kind cluster\n"
cd $KIND_DIR
terraform destroy -auto-approve
rm -rf .terraform
rm -rf .terraform.lock.hcl
rm -rf terraform.tfstate*


printf "\n${red}II.${no_color} Remove local docker registry\n"
docker rm -vf local-registry
