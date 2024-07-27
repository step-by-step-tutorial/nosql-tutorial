# <p align="center">Janusgraph</p>

# Setup

## Dockerized Installation

```yaml
version: '3.8'

services:
  janusgraph:
    image: janusgraph/janusgraph
    container_name: janusgraph
    hostname: janusgraph
    restart: always
    environment:
      JANUS_PROPS_TEMPLATE: cql-es
      janusgraph.storage.hostname: cassandra
      janusgraph.index.search.hostname: elasticsearch
    ports:
      - "8182:8182"
  cassandra:
    image: cassandra:3
    container_name: cassandra
    hostname: cassandra
    restart: always
    ports:
      - "9042:9042"
      - "9160:9160"
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.5
    container_name: elasticsearch
    hostname: elasticsearch
    restart: always
    environment:
      ES_JAVA_OPTS: -Xms512m -Xmx512m
      http.host: 0.0.0.0
      network.host: 0.0.0.0
      transport.host: 127.0.0.1
      cluster.name: docker-cluster
      xpack.security.enabled: false
      discovery.zen.minimum_master_nodes: 1
      discovery.type: single-node
    ports:
      - "9200:9200"
```

Execute the following command to create containers.

```shell
docker compose --file docker-compose.yml --project-name janusgraph up -d --build

```

## Gremlin

```shell

docker exec -it janusgraph ./bin/gremlin.sh

:remote connect tinkerpop.server conf/remote.yaml
:remote console

g.V().count()

```

### Example

```shell
// Create a vertex
g.addV('person').property('name', 'Alice')
g.addV('person').property('name', 'Bob')

// Create an edge
g.V().has('name', 'Alice').addE('like').to(__.V().has('name', 'Bob'))

// Count vertices
g.V().count()

// Find a vertex by property
g.V().has('name', 'Alice')


```

**<p align="center"> [Top](#janusgraph) </p>**