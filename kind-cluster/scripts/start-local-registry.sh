#!/bin/bash

# Grab flags
while getopts n:p: flag
do
  case "${flag}" in
    n) REGISTRY_NAME=${OPTARG};;
    p) REGISTRY_PORT=${OPTARG};;
  esac
done

echo "registry name: $REGISTRY_NAME"
echo "registry port: $REGISTRY_PORT"

running="$(docker inspect -f '{{.State.Running}}' "${REGISTRY_NAME}" 2>/dev/null || true)"

if [ "$running" != 'true' ]; then
  docker run \
    -d --restart=always -p "127.0.0.1:${REGISTRY_PORT}:${REGISTRY_PORT}" --name "${REGISTRY_NAME}" \
    registry:2
fi