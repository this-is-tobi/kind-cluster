#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'


# Get project directories
PROJECT_DIR="$(pwd)"
KIND_DIR="$PROJECT_DIR/kind-cluster"
REGISTRY_DIR="$PROJECT_DIR/local-registry"
INGRESS_DIR="$PROJECT_DIR/nginx-ingress"


printf "\n${red}I.${no_color} Deploy kind cluster\n"
cd $KIND_DIR
terraform init
terraform apply -auto-approve


printf "\n${red}II.${no_color} Add configmap for local registry into kind cluster\n"
cd $REGISTRY_DIR
terraform init
terraform apply -auto-approve


printf "\n${red}III.${no_color} Deploy nginx ingress controller\n"
cd $INGRESS_DIR
terraform init
terraform apply -auto-approve
