# Vite app served over nginx deployment

This example deploy a [vite](https://vitejs.dev/) application throught nginx, it uses a self-build image so it is using the local registry.

Deploy & destroy with the following commands :

```sh
# Build application image & push it to the local registry
docker build . -t vite:latest
docker tag vite:latest localhost:5000/vite:latest
docker push localhost:5000/vite:latest

# Deploy nginx webserver with terraform
terraform init
terraform apply -auto-approve

# Destroy nginx webserver with terraform
terraform destroy -auto-approve
```

Access app at <http://localhost>.
