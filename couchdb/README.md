# <p align="center">CouchDB</p>

To get more information refer to [https://couchdb.apache.org](https://couchdb.apache.org).

# Use Case

List of use cases for CouchDB

# Setup

## Prerequisites

* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)
* [Couchdb](https://couchdb.apache.org)

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
curl  -u admin:password http://127.0.0.1:5984
curl  -u admin:password http://127.0.0.1:5984/_uuids?count=1
curl  -u admin:password http://127.0.0.1:5984/demo
```

Open [http://127.0.0.1:5984/_utils](http://127.0.0.1:5984/_utils) in the web browser to see web console of CouchDB.

```yaml
username: admin
password: password
```

### After Installation

Open [http://127.0.0.1:5984/_utils/#setup](http://127.0.0.1:5984/_utils/#setup) to set up database. In this case I set
up database as a single node.

```shell
curl -X GET -u admin:password http://127.0.0.1:5984/_all_dbs
# Output:["_replicator","_users"]

curl -X PUT -u admin:password http://127.0.0.1:5984/_users
curl -X PUT -u admin:password http://127.0.0.1:5984/_replicator
curl -X PUT -u admin:password http://127.0.0.1:5984/_global_changes
```

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

## Database

### Create

```shell
curl -X PUT -u admin:password http://127.0.0.1:5984/shop
# Output: {"ok":true}
```

### Read

```shell
curl -X GET -u admin:password http://127.0.0.1:5984/shop
```

### Delete

```shell
curl -X DELETE -u admin:password http://127.0.0.1:5984/shop
# Output: {"ok":true}
```

## Document

### Create

```shell
curl -X PUT -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/001 --data "{ \"Name\" : \"CouchDB\" , \"URL\" :\"www.couchdb.apache.org\" }"
# Output:{"ok":true,"id":"001","rev":"1-c81f7289f59ec3c485b2cfae69eae2ea"}
curl -X PUT -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/002 --data "{ \"Name\" : \"PouchDB\" , \"URL\" :\"www.pouchdb.com\" }"
# Output:{"ok":true,"id":"002","rev":"1-b1fba88a7d267be2c97f2768d1f8e428"}
```

### Read

```shell
curl -X GET -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/001
curl -X GET -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/002
```

### Update

```shell
curl -X PUT -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/001 --data "{ \"Name\" : \"CouchDB Inc.\",\"_rev\": \"1-c81f7289f59ec3c485b2cfae69eae2ea\" }"
# Output: {"ok":true,"id":"001","rev":"2-7524533d7f9108d55a0ec8afe70b7284"}
```

### Delete

```shell
curl -X DELETE -u admin:password http://127.0.0.1:5984/shop/001?rev=2-7524533d7f9108d55a0ec8afe70b7284
# Output:{"ok":true,"id":"001","rev":"3-59ad51ca24feabc3f3c28d906d537d56"}
curl -X DELETE -u admin:password http://127.0.0.1:5984/shop/002?rev=1-b1fba88a7d267be2c97f2768d1f8e428
# Output:{"ok":true,"id":"002","rev":"2-576524274188a157dd88849331a85867"}
```

### Attache File

```shell
curl -X PUT -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/001 --data "{ \"Name\" : \"CouchDB\" , \"URL\" :\"www.couchdb.apache.org\" }"
# Output:{"ok":true,"id":"001","rev":"4-f934c23aa52b801d75d57c490fcdb0da"}
curl -vX PUT  -H "ContentType:image/jpg"  --data-binary @couchdb.png -u admin:password http://127.0.0.1:5984/shop/001/couchdb.png?rev=4-f934c23aa52b801d75d57c490fcdb0da
# Output:{"ok":true,"id":"001","rev":"5-f932b6ef0caa61cb11fa15ef28cfcc70"}
curl -u admin:password http://127.0.0.1:5984/shop/001/couchdb.png --output couchdb.png
```

# Make File

[Makefile](Makefile)

```makefile
docker-compose-deploy:
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