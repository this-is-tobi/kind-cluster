# Simple nginx webserver deployment

This example deploy a simple nginx webserver, it uses official Docker Hub nginx image so it is not using the local registry.

Deploy & destroy with the following commands :

```sh
# Pull the official nginx image
docker pull nginx:latest

# Deploy nginx webserver with terraform
terraform init
terraform apply -auto-approve

# Destroy nginx webserver with terraform
terraform destroy -auto-approve
```

Access app at <http://localhost>.
