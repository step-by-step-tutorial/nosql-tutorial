# <p align="center">Title</p>

# Use Case

List of use cases for TOOL_NAME

# Setup

## Prerequisites

* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)

## Installation MongoDB on Docker

### Docker Compose File

[docker-compose.yml](docker-compose.yml)

```yaml
# docker-compose.yml

```

### Apply Docker Compose File

Execute the command mentioned in the below to create MongoDB container.

```shell
docker compose --file docker-compose.yml --project-name elasticsearch up -d --build 
```

### Elasticsearch

#### kibana_system User

```shell
docker exec elasticsearch ./bin/elasticsearch-reset-password -u kibana_system -i
```

#### create New User

```shell
curl -X POST -u elastic:password  -H "Content-Type: application/json" localhost:9200/_security/user/kibana_user --data "{\"password\" : \"password\",\"roles\" : [ \"kibana_admin\", \"kibana_system\" ],\"full_name\" : \"Kibana User\"}"
```

### Kibana

Open [http://localhost:5601](http://localhost:5601)

```yaml
Username: elastic
Password: password
```

### Remove From Docker

More commands to remove whatever you created.

```shell
docker rm elasticsearch --force
docker image rm docker.elastic.co/elasticsearch/elasticsearch:8.14.3
docker rm kibana --force
docker image rm docker.elastic.co/kibana/kibana:8.14.3
```

## Install MongoDB on Kubernetes

create the following Kubernetes files then apply them.

### MongoDB Kube Files

[mongo-deployment.yml](./kube/mongo-deployment.yml)

```yaml
# mongo-deployment.yml
```

[mongo-service.yml](./kube/mongo-service.yml)

```yaml
# mongo-service.yml
```

### Apply Kube Files

You can apply Kubernetes files using the following commands.

```shell
kubectl apply -f ./kube/mongo-deployment.yml
kubectl apply -f ./kube/mongo-service.yml
```

To check status, use `kubectl get all` command.

<p align="justify">

In order to connect to MongoDB and MongoExpress from localhost use the following command.

```shell
kubectl port-forward service/mongo 27017:27017
```

### Remove From Kubernetes

More command to delete everything you created and deployed to Kubernetes.

```shell
kubectl delete all --all
```

# Queries

## New Database

```shell
```

## CRUD Collection

### Create

```shell
```

### Read

```shell
```

### Delete

```shell
```

## CRUD Document

### Insert

```shell
```

### Find

```shell
```

### Set

```shell
```

### Delete

```shell

```

# Make File

[Makefile](Makefile)

```makefile
docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name mongo up --build -d

docker-remove-container:
	docker rm mongo --force
	docker rm mongo-express --force

docker-remove-image:
	docker image rm mongo
	docker image rm mongo-express

kube-deploy:
	kubectl apply -f ./kube/mongo-secrets.yml
	kubectl apply -f ./kube/mongo-configmap.yml
	kubectl apply -f ./kube/mongo-pvc.yml
	kubectl apply -f ./kube/mongo-deployment.yml
	kubectl apply -f ./kube/mongo-service.yml
	kubectl apply -f ./kube/mongo-express-deployment.yml
	kubectl apply -f ./kube/mongo-express-service.yml

kube-remove:
	kubectl delete all --all
	kubectl delete secrets mongo-secrets
	kubectl delete secrets mongo-configmap
	kubectl delete persistentvolumeclaim mongo-pvc

kube-port-forward-db:
	kubectl port-forward service/mongo 27017:27017

kube-port-forward-web:
	kubectl port-forward service/mongo-express 8081:8081
```

#

**<p align="center"> [Top](#mongodb) </p>**