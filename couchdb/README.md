# <p align="center">CouchDB</p>

To get more information refer to [https://couchdb.apache.org](https://couchdb.apache.org).

# Use Case

List of use cases for CouchDB


# Setup

## Prerequisites

* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)

## Installation CouchDB on Docker

### Docker Compose File

[docker-compose.yml](docker-compose.yml)

```yaml
# docker-compose.yml
version: '3.1'

services:
  couchdb:
    image: couchdb
    container_name: couchdb
    hostname: couchdb
    environment:
      COUCHDB_USER: admin
      COUCHDB_PASSWORD: password
    ports:
      - "5984:5984"
```

### Apply Docker Compose File

Execute the command mentioned in the below to create MongoDB container.

```shell
docker compose --file docker-compose.yml --project-name couchdb up -d --build
```

Open [http://127.0.0.1:5984/_utils](http://127.0.0.1:5984/_utils) in the web browser to see web console of CouchDB.

### Remove From Docker

More commands to remove whatever you created.

```shell
docker rm couchdb --force
docker image rm couchdb
```

## Install CouchDB on Kubernetes

Create the following files for installing CouchDB.

### CouchDB Kube Files

[couchdb-deployment.yml](./kube/couchdb-deployment.yml)

```yaml
# couchdb-deployment.yml
```

[couchdb-service.yml](./kube/couchdb-service.yml)

```yaml
# couchdb-service.yml
```

### Apply Kube Files

You can apply Kubernetes files using the following commands.

```shell
kubectl apply -f ./kube/couchdb-deployment.yml
kubectl apply -f ./kube/couchdb-service.yml
```

To check status, use `kubectl get all` command.

<p align="justify">

In order to connect to CouchDB from localhost use the following command.

```shell
kubectl port-forward service/couchdb 5984:5984
```

### Remove From Kubernetes

More command to delete everything you created and deployed to Kubernetes.

```shell
kubectl delete all --all
```

# Queries


# Make File

[Makefile](Makefile)

```makefile
docker-deploy:
	docker compose --file docker-compose.yml --project-name couchdb up -d

docker-rebuild-deploy:
	docker compose --file docker-compose.yml --project-name couchdb up --build -d

docker-remove-container:
	docker rm couchdb --force

docker-remove-image:
	docker image rm couchdb

kube-deploy:
	kubectl apply -f ./kube/couchdb-deployment.yml
	kubectl apply -f ./kube/couchdb-service.yml

kube-remove:
	kubectl delete all --all

kube-port-forward-db:
	kubectl port-forward service/couchdb 5984:5984	
```

#

**<p align="center"> [Top](#couchdb) </p>**