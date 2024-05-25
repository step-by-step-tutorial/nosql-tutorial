# <p align="center">Neo4j</p>

It is a high performance graph store with all the features expected of a mature and robust database, like a friendly
query language and ACID transactions. For more information refer
to [https://github.com/neo4j/neo4j](https://github.com/neo4j/neo4j)

# Setup

## Dockerized Installation

Create a `docker compose` file include following content.

[docker-compose.yml](docker-compose.yml)

```yaml
# docker-compose.yml
version: '3.8'

services:
  neo4j:
    image: neo4j
    container_name: neo4j
    hostname: neo4j
    ports:
      - "7474:7474"
      - "7687:7687"
    volumes:
      - "./data:/data"
    environment:
      NEO4J_AUTH: none

```

Execute this command to create containerized neo4j.

```shell
docker compose --file docker-compose.yml --project-name neo4j up -d --build

```

Try to log in to the Neo4j via browser [http://localhost:7474/browser](http://localhost:7474/browser).

# Queries

## Create Node

### Create one node

```sql
CREATE(ee:Person {name: 'Emil', from: 'Sweden', kloutScore: 99})
  ```     

### Create Multi Node

```sql
CREATE
(js:Person { name: 'Johan', from: 'Sweden', learn: 'surfing' }),
(ir:Person { name: 'Ian', from: 'England', title: 'author' }),
(rvb:Person { name: 'Rik', from: 'Belgium', pet: 'Orval' }),
(ally:Person { name: 'Allison', from: 'California', hobby: 'surfing' }) 
```

## Find

### Find One Node

```sql
MATCH (ee:Person) WHERE ee.name = 'Emil' RETURN ee;
```

### Find Multi Nodes

```sql
MATCH 
  (ee:Person {name: 'Emil'}),
  (js:Person {name: 'Johan'}),
  (ir:Person {name: 'Ian'}),
  (rvb:Person {name: 'Rik'}),
  (ally:Person {name: 'Allison'})
RETURN ee, js, ir, rvb, ally
```

## Create Edge

```sql
MATCH 
  (ee:Person {name: 'Emil'}),
  (js:Person {name: 'Johan'}),
  (ir:Person {name: 'Ian'}),
  (rvb:Person {name: 'Rik'}),
  (ally:Person {name: 'Allison'})
MERGE (ee)-[:KNOWS {since: 2001}]->(js)
MERGE (ee)-[:KNOWS {rating: 5}]->(ir)
MERGE (js)-[:KNOWS]->(ir)
MERGE (js)-[:KNOWS]->(rvb)
MERGE (ir)-[:KNOWS]->(js)
MERGE (ir)-[:KNOWS]->(ally)
MERGE (rvb)-[:KNOWS]->(ally)
RETURN ee, js, ir, rvb, ally


```

## Delete

```sql
MATCH 
  (ee:Person {name: 'Emil'}),
  (js:Person {name: 'Johan'}),
  (ir:Person {name: 'Ian'}),
  (rvb:Person {name: 'Rik'}),
  (ally:Person {name: 'Allison'})
DETACH DELETE
ee, js, ir, rvb, ally

```

**<p align="center"> [Top](#neo4j) </p>**