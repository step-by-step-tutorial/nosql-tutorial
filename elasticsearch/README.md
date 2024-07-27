# <p align="center">Elasticsearch</p>

Elasticsearch is a distributed, RESTful search and analytics engine capable of addressing a growing number of use cases.
It is built on Apache Lucene and provides a scalable search solution that is capable of handling large amounts of data
and performing complex queries quickly and efficiently. for more
information [Elasticsearch](https://www.elastic.co/elasticsearch).

# Use Case

List of use cases for Elasticsearch.

* Full-Text search
* Log/Metrics analysis
* Geospatial analysis
* Vector database

# Setup

## Prerequisites

* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)
* [Elasticsearch](https://www.elastic.co/elasticsearch)
* [Kibana](https://www.elastic.co/kibana)

## Installation Elasticsearch on Docker

### Docker Compose File

[docker-compose.yml](docker-compose.yml)

```yaml
# docker-compose.yml
version: '3.8'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.14.3
    container_name: elasticsearch
    hostname: elasticsearch
    environment:
      ELASTIC_PASSWORD: password
      discovery.type: single-node
      xpack.security.http.ssl.enabled: false
      xpack.license.self_generated.type: trial
    ports:
      - "9200:9200"
    healthcheck:
      test: [ "CMD-SHELL", "curl -sS http://localhost:9200/_cluster/health || exit 1" ]
      interval: 30s
      timeout: 10s
      retries: 3

  kibana:
    image: docker.elastic.co/kibana/kibana:8.14.3
    container_name: kibana
    hostname: kibana
    environment:
      ELASTICSEARCH_URL: http://elasticsearch:9200
      ELASTICSEARCH_HOSTS: http://elasticsearch:9200
      ELASTICSEARCH_USERNAME: kibana_system
      ELASTICSEARCH_PASSWORD: password
      xpack.security.enabled: false
      xpack.license.self_generated.type: trial
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
```

### Apply Docker Compose File

Execute the command mentioned in the below to create MongoDB container.

```shell
docker compose --file docker-compose.yml --project-name elasticsearch up -d --build 
```

### Check Status

```shell
curl -u elastic:password http://localhost:9200
```

Open [http://localhost:9200](http://localhost:9200) in browser then put the following information.

```yaml
Username: elastic
Password: password
```

### User

#### kibana_system

```shell
# configure the Kibana password in the elasticsearch container
docker exec elasticsearch ./bin/elasticsearch-reset-password -u kibana_system -i
```

```shell
curl -u elastic:password -X POST -H "Content-Type: application/json" http://localhost:9200/_security/user/kibana_system/_password --data "{\"password\" : \"password\"}"
curl -u kibana_system:password http://localhost:9200/_security/_authenticate

```

#### New User

```shell
curl -X POST -u elastic:password  -H "Content-Type: application/json" localhost:9200/_security/user/kibana_user --data "{\"password\" : \"password\",\"roles\" : [ \"kibana_admin\", \"kibana_system\" ],\"full_name\" : \"Kibana User\"}"
```

### Kibana

Open [http://localhost:5601](http://localhost:5601) in browser then put the following information.

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

## Install Elasticsearch on Kubernetes

create the following Kubernetes files then apply them.

### Kube Files

[elasticsearch-deployment.yml](./kube/elasticsearch-deployment.yml)

```yaml
# elasticsearch-deployment.yml
```

[elasticsearch-service.yml](./kube/elasticsearch-service.yml)

```yaml
# elasticsearch-service.yml
```

[kibana-deployment.yml](./kube/kibana-deployment.yml)

```yaml
# kibana-deployment.yml
```

[kibana-service.yml](./kube/kibana-service.yml)

```yaml
# kibana-service.yml
```

### Apply Kube Files

You can apply Kubernetes files using the following commands.

```shell
kubectl apply -f ./kube/elasticsearch-deployment.yml
kubectl apply -f ./kube/elasticsearch-service.yml
kubectl apply -f ./kube/kibana-deployment.yml
kubectl apply -f ./kube/kibana-service.yml
```

To check status, use `kubectl get all` command.

<p align="justify">

In order to connect to MongoDB and MongoExpress from localhost use the following command.

```shell
kubectl port-forward service/elasticsearch 9200:9200
kubectl port-forward service/kibana 5601:5601
```

### Remove From Kubernetes

More command to delete everything you created and deployed to Kubernetes.

```shell
kubectl delete all --all
```

# Queries

## Index

### Create

```kibana
PUT /person
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1
  },
  "mappings": {
    "properties": {
      "name": {
        "type": "text"
      },
      "age": {
        "type": "integer"
      },
      "email": {
        "type": "keyword"
      },
      "address": {
        "properties": {
          "street": {
            "type": "text"
          },
          "city": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword"
              }
            }
          },
          "state": {
            "type": "text",
            "fields": {
              "keyword": {
                "type": "keyword"
              }
            }
          },
          "zip": {
            "type": "keyword"
          }
        }
      },
      "created_at": {
        "type": "date",
        "format": "strict_date_optional_time||epoch_millis"
      }
    }
  }
}
```

```shell
curl -u elastic:password -X PUT  -H "Content-Type: application/json" localhost:9200/person --data-binary @person_index.json
# Output: {"acknowledged":true,"shards_acknowledged":true,"index":"person"}
```

### List of Indices

```kibana
GET /_cat/indices?v
```

### Delete

```kibana
DELETE /person
```

```shell
curl -X DELETE "localhost:9200/person"
# Output: {"acknowledged":true}
```

## CRUD Documentation

### Insert

```kibana
POST /person/_doc/1
{
  "name": "John Doe",
  "age": 30,
  "email": "john.doe@example.com",
  "address": {
    "street": "123 Main St",
    "city": "Anytown",
    "state": "CA",
    "zip": "12345"
  },
  "created_at": "2024-07-27T14:30:00Z"
}

POST /person/_doc/2
{
  "name": "Jane Smith",
  "age": 25,
  "email": "jane.smith@example.com",
  "address": {
    "street": "456 Elm St",
    "city": "Othertown",
    "state": "NY",
    "zip": "67890"
  },
  "created_at": "2024-07-26T09:15:00Z"
}
```

### Bulk Insert

```kibana
POST /person/_bulk
{ "index": { "_id": "1" } }
{ "name": "John Doe", "age": 30, "email": "john.doe1@example.com", "address": { "street": "123 Main St", "city": "Anytown", "state": "CA", "zip": "12345" }, "created_at": "2024-07-27T14:30:00Z" }
{ "index": { "_id": "2" } }
{ "name": "Jane Smith", "age": 25, "email": "jane.smith@example.com", "address": { "street": "456 Elm St", "city": "Othertown", "state": "NY", "zip": "67890" }, "created_at": "2024-07-26T09:15:00Z" }
{ "index": { "_id": "3" } }
{ "name": "Alice Johnson", "age": 28, "email": "alice.johnson@example.com", "address": { "street": "789 Pine St", "city": "Anycity", "state": "TX", "zip": "54321" }, "created_at": "2024-07-25T11:45:00Z" }
{ "index": { "_id": "4" } }
{ "name": "Bob Brown", "age": 35, "email": "bob.brown@example.com", "address": { "street": "101 Maple St", "city": "Everytown", "state": "FL", "zip": "98765" }, "created_at": "2024-07-24T08:00:00Z" }
{ "index": { "_id": "5" } }
{ "name": "Charlie Davis", "age": 40, "email": "charlie.davis@example.com", "address": { "street": "202 Birch St", "city": "Sometown", "state": "WA", "zip": "65432" }, "created_at": "2024-07-23T07:20:00Z" }
{ "index": { "_id": "6" } }
{ "name": "Diana Evans", "age": 32, "email": "diana.evans@example.com", "address": { "street": "303 Cedar St", "city": "Thistown", "state": "OR", "zip": "87654" }, "created_at": "2024-07-22T06:30:00Z" }
{ "index": { "_id": "7" } }
{ "name": "Edward Foster", "age": 27, "email": "edward.foster@example.com", "address": { "street": "404 Walnut St", "city": "Heretown", "state": "NV", "zip": "43210" }, "created_at": "2024-07-21T05:45:00Z" }
{ "index": { "_id": "8" } }
{ "name": "Fiona Green", "age": 22, "email": "fiona.green@example.com", "address": { "street": "505 Spruce St", "city": "Thattown", "state": "UT", "zip": "21098" }, "created_at": "2024-07-20T04:55:00Z" }
{ "index": { "_id": "9" } }
{ "name": "George Harris", "age": 38, "email": "george.harris@example.com", "address": { "street": "606 Ash St", "city": "Mycity", "state": "CO", "zip": "32109" }, "created_at": "2024-07-19T04:00:00Z" }
{ "index": { "_id": "10" } }
{ "name": "Hannah Irving", "age": 29, "email": "hannah.irving@example.com", "address": { "street": "707 Oak St", "city": "Yourtown", "state": "AZ", "zip": "54310" }, "created_at": "2024-07-18T03:15:00Z" }
{ "index": { "_id": "11" } }
{ "name": "Ian Jackson", "age": 31, "email": "ian.jackson@example.com", "address": { "street": "808 Poplar St", "city": "Hiscity", "state": "NM", "zip": "65432" }, "created_at": "2024-07-17T02:30:00Z" }
{ "index": { "_id": "12" } }
{ "name": "Jenny King", "age": 26, "email": "jenny.king@example.com", "address": { "street": "909 Willow St", "city": "Heretown", "state": "MT", "zip": "32145" }, "created_at": "2024-07-16T01:45:00Z" }
{ "index": { "_id": "13" } }
{ "name": "Kevin Lewis", "age": 33, "email": "kevin.lewis@example.com", "address": { "street": "1010 Cherry St", "city": "Thistown", "state": "ID", "zip": "21098" }, "created_at": "2024-07-15T00:55:00Z" }
{ "index": { "_id": "14" } }
{ "name": "Laura Martin", "age": 34, "email": "laura.martin@example.com", "address": { "street": "1111 Chestnut St", "city": "Mycity", "state": "SD", "zip": "43210" }, "created_at": "2024-07-14T23:00:00Z" }
{ "index": { "_id": "15" } }
{ "name": "Michael Nelson", "age": 36, "email": "michael.nelson@example.com", "address": { "street": "1212 Hickory St", "city": "Yourtown", "state": "ND", "zip": "54321" }, "created_at": "2024-07-13T22:15:00Z" }
{ "index": { "_id": "16" } }
{ "name": "Nina Owens", "age": 24, "email": "nina.owens@example.com", "address": { "street": "1313 Pine St", "city": "Hiscity", "state": "WY", "zip": "65432" }, "created_at": "2024-07-12T21:30:00Z" }
{ "index": { "_id": "17" } }
{ "name": "Oscar Perry", "age": 37, "email": "oscar.perry@example.com", "address": { "street": "1414 Birch St", "city": "Heretown", "state": "NE", "zip": "32145" }, "created_at": "2024-07-11T20:45:00Z" }
{ "index": { "_id": "18" } }
{ "name": "Paula Quinn", "age": 27, "email": "paula.quinn@example.com", "address": { "street": "1515 Cedar St", "city": "Thistown", "state": "KS", "zip": "21098" }, "created_at": "2024-07-10T19:55:00Z" }
{ "index": { "_id": "19" } }
{ "name": "Quincy Roberts", "age": 28, "email": "quincy.roberts@example.com", "address": { "street": "1616 Spruce St", "city": "Mycity", "state": "OK", "zip": "43210" }, "created_at": "2024-07-09T19:00:00Z" }
{ "index": { "_id": "20" } }
{ "name": "Rachel Scott", "age": 29, "email": "rachel.scott@example.com", "address": { "street": "1717 Maple St", "city": "Yourtown", "state": "AR", "zip": "54321" }, "created_at": "2024-07-08T18:15:00Z" }
```

```shell
curl -u elastic:password -X PUT  -H "Content-Type: application/json" localhost:9200/person/_bulk --data-binary @bulk_person.json
```

### Find

```kibana
# Find all documents
GET /person/_search
{
  "query": {
    "match_all": {}
  }
}

# Find persons by age (e.g., 28)
GET /person/_search
{
  "query": {
    "term": {
      "age": 28
    }
  }
}

```

### Aggregate

```kibana
# Aggregate by age
GET /person/_search
{
  "size": 0,
  "aggs": {
    "age_groups": {
      "terms": {
        "field": "age"
      }
    }
  }
}

# Aggregate by city
GET /person/_search
{
  "size": 0,
  "aggs": {
    "city_groups": {
      "terms": {
        "field": "address.city.keyword"
      }
    }
  }
}

# Aggregate average age
GET /person/_search
{
  "size": 0,
  "aggs": {
    "average_age": {
      "avg": {
        "field": "age"
      }
    }
  }
}

# Aggregate by state with sub-aggregation by city
GET /person/_search
{
  "size": 0,
  "aggs": {
    "states": {
      "terms": {
        "field": "address.state.keyword"
      },
      "aggs": {
        "cities": {
          "terms": {
            "field": "address.city.keyword"
          }
        }
      }
    }
  }
}
```

### Find and Aggregate

```kibana
# Filter and aggregate by city for age between 25 and 35
GET /person/_search
{
  "query": {
    "range": {
      "age": {
        "gte": 25,
        "lte": 35
      }
    }
  },
  "aggs": {
    "city_groups": {
      "terms": {
        "field": "address.city.keyword"
      }
    }
  }
}
```

### Update

```kibana
POST /person/_update/1
{
  "doc": {
    "email": "new.email@example.com"
  }
}

# Find persons by _id (e.g., 1)
GET /person/_search
{
  "query": {
    "term": {
      "_id": 1
    }
  }
}
```

### Delete

```kibana
DELETE /person/_doc/1

# Find persons by _id (e.g., 1)
GET /person/_search
{
  "query": {
    "term": {
      "_id": 1
    }
  }
}
```

# Make File

[Makefile](Makefile)

```makefile
docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name mongo up --build -d

docker-remove-container:
	docker rm elasticsearch --force
	docker rm kibana --force

docker-remove-image:
	docker image rm docker.elastic.co/elasticsearch/elasticsearch:8.14.3
	docker image rm docker.elastic.co/kibana/kibana:8.14.3

kube-deploy:
	kubectl apply -f ./kube/elasticsearch-deployment.yml
	kubectl apply -f ./kube/elasticsearch-service.yml
	kubectl apply -f ./kube/kibana-deployment.yml
	kubectl apply -f ./kube/kibana-service.yml

kube-remove:
	kubectl delete all --all

kube-port-forward-elasticsearch:
	kubectl port-forward service/elasticsearch 9200:9200

kube-port-forward-kibana:
	kubectl port-forward service/kibana 5601:5601
```

#

**<p align="center"> [Top](#elasticsearch) </p>**