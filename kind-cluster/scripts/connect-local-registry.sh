#!/bin/bash

REGISTRY_NAME=$1

printf "\nWaiting for the local registry ($REGISTRY_NAME) to connect with cluster...\n"

docker network connect "kind" "${REGISTRY_NAME}" || true

printf "\nLocal registry successfully connect to cluster\n"