# <p align="center">CouchDB</p>

To get more information, refer to [https://couchdb.apache.org](https://couchdb.apache.org).

# Getting Started

## Prerequisites

* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)

## Dockerize

### Deploy

```shell
docker compose --file docker-compose.yml --project-name couchdb up -d --build
```

### Test

```shell
curl  -u admin:password http://127.0.0.1:5984
curl  -u admin:password http://127.0.0.1:5984/_uuids?count=1
curl  -u admin:password http://127.0.0.1:5984/demo
```

### Access

CouchDB: [http://127.0.0.1:5984/_utils](http://127.0.0.1:5984/_utils)

```yaml
username: admin
password: password
```

### Setup

Open [http://127.0.0.1:5984/_utils/#setup](http://127.0.0.1:5984/_utils/#setup) to set up a database. In this case I set
up a database as a single node.

```shell
curl -X GET -u admin:password http://127.0.0.1:5984/_all_dbs
# Output:["_replicator","_users"]

curl -X PUT -u admin:password http://127.0.0.1:5984/_users
curl -X PUT -u admin:password http://127.0.0.1:5984/_replicator
curl -X PUT -u admin:password http://127.0.0.1:5984/_global_changes
```

### Down

```shell
docker rm couchdb --force
docker image rm couchdb
```

## Kubernetes

### Deploy

```shell
kubectl apply -f ./test-env.yml
```

### Test

```shell
kubectl get all
```

### Port Forward

```shell
kubectl port-forward service/couchdb 5984:5984
```

### Access

CouchDB: [http://127.0.0.1:5984/_utils](http://127.0.0.1:5984/_utils)

```yaml
username: admin
password: password
```

### Setup

Open [http://127.0.0.1:5984/_utils/#setup](http://127.0.0.1:5984/_utils/#setup) to set up a database. In this case I set
up a database as a single node.

```shell
curl -X GET -u admin:password http://127.0.0.1:5984/_all_dbs
# Output:["_replicator","_users"]

curl -X PUT -u admin:password http://127.0.0.1:5984/_users
curl -X PUT -u admin:password http://127.0.0.1:5984/_replicator
curl -X PUT -u admin:password http://127.0.0.1:5984/_global_changes
```

### Down

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

### Attach File

```shell
curl -X PUT -H "Content-Type: application/json" -u admin:password http://127.0.0.1:5984/shop/001 --data "{ \"Name\" : \"CouchDB\" , \"URL\" :\"www.couchdb.apache.org\" }"
# Output:{"ok":true,"id":"001","rev":"4-f934c23aa52b801d75d57c490fcdb0da"}
curl -vX PUT  -H "ContentType:image/jpg"  --data-binary @couchdb.png -u admin:password http://127.0.0.1:5984/shop/001/couchdb.png?rev=4-f934c23aa52b801d75d57c490fcdb0da
# Output:{"ok":true,"id":"001","rev":"5-f932b6ef0caa61cb11fa15ef28cfcc70"}
curl -u admin:password http://127.0.0.1:5984/shop/001/couchdb.png --output couchdb.png
```

#

**<p align="center"> [Top](#couchdb) </p>**