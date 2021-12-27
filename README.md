# Kind cluster (Kubernetes in Docker)

## Purpose

This project aims to start a local [kubernetes](https://kubernetes.io/) cluster using [kind](https://kind.sigs.k8s.io/). This allows to run local kubernetes deployments tests with docker containers.

## Prerequisite

Stuff you need to get going :

- Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
- Install [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- Install [Kubernetes](https://kubernetes.io/releases/download/)
- Install [Terraform](https://www.terraform.io/downloads)

## Get Started

### Start kind cluster

Run the following commands in your terminal :

```shell
# Clone the project
git clone <this_project_url>

# Deploy kind cluster
sh deploy.sh
```

### Stop kind cluster

Run the following commands in your terminal :

```shell
# Destroy kind cluster & all terraform stuff
sh destroy.sh
```

## Additional tool

Terraform is used to deploy the cluster and connect to the local [docker registry](https://docs.docker.com/registry/).

The local registry gives us the ability to pull local self-build docker images without pushing them to the [Docker Hub](https://hub.docker.com/). It runs under `localhost:5000` with the name `local-registry`.

Example of registry usage :

1. Build your docker image with a tag

```sh
docker build /path/to/your/dockerfile -t your-image:latest
```

2. Tag your local image with the local registry

```sh
docker your-image:latest localhost:5000/your-image:latest
```

3. Push your image to the local registry

```sh
docker push localhost:5000/your-image:latest
```

4. Then you are able to pull from `localhost:5000/your-image-latest`

## Examples

Deployment examples can be found in the `./examples/` folder. Don't forget to start the kind cluster first.

## Notes

- Registry name & port can be update in `./kind-cluster/variables.tf` and `./local-registry/variables.tf`.

- Cluster can be personalized in `./kind-cluster/main.tf` (number of nodes, port mapping, volume mount, etc... - See [kind configuration](https://kind.sigs.k8s.io/docs/user/configuration/)). Cluster default conf is :

  - One `controle-plane node` & one `worker node` are deployed.
  - Port `80` & `443` are mapped to the host.
  - No volume are mounted.

- 🚨 This is only a test environment, don't use it in production.
