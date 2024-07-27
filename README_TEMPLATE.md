# <p align="center">Title</p>

# Use Case

List of use cases for TOOL_NAME

# Setup

## Prerequisites

* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)

## Installation TOOL_NAME on Docker

### Docker Compose File

[docker-compose.yml](docker-compose.yml)

```yaml
# docker-compose.yml

```

### Apply Docker Compose File

Execute the command mentioned in the below to create TOOL_NAME container.

```shell
docker compose --file docker-compose.yml --project-name toolname up -d --build
```

### Remove From Docker

More commands to remove whatever you created.

```shell
docker rm containername --force
docker image rm imagename
```

## Install TOOL_NAME on Kubernetes

create the following Kubernetes files then apply them.

### TOOL_NAME Kube Files

[toolname-deployment.yml](./kube/toolname-deployment.yml)

```yaml
# toolname-deployment.yml
```

[toolname-service.yml](./kube/toolname-service.yml)

```yaml
# toolname-service.yml
```

### Apply Kube Files

You can apply Kubernetes files using the following commands.

```shell
kubectl apply -f ./kube/toolname-deployment.yml
kubectl apply -f ./kube/toolname-service.yml
```

To check status, use `kubectl get all` command.

<p align="justify">

In order to connect to TOOL_NAME from localhost use the following command.

```shell
kubectl port-forward service/toolname port:port
```

### Remove From Kubernetes

More command to delete everything you created and deployed to Kubernetes.

```shell
kubectl delete all --all
```

# Queries

## Database

### Create

```shell
```

### Delete Database

```shell
```

## CRUD Table/Documentation/Collection

### Create

```shell
```

### Read

```shell
```

### Update

```shell
```

### Delete

```shell
```

## CRUD Document

### Insert

```shell
```

### Bulk Insert

```shell

```

### Find

```shell
```

### Update

```shell
```

### Delete

```shell

```

# Make File

[Makefile](Makefile)

```makefile
docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name toolname up --build -d

docker-remove-container:
	docker rm toolname --force

docker-remove-image:
	docker image rm image-name

kube-deploy:
	kubectl apply -f ./kube/toolname-deployment.yml
	kubectl apply -f ./kube/toolname-service.yml

kube-delete:
	kubectl delete all --all

kube-port-forward-db:
	kubectl port-forward service/toolname port:port
```

#

**<p align="center"> [Top](#tool_name) </p>**