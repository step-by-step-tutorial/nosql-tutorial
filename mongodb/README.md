# <p align="center">MongoDB</p>

MongoDB is a document database in NoSQL topic. To get more information refer
to [https://www.mongodb.com](https://www.mongodb.com).

# Use Case

List of use cases for
MongoDB [https://www.mongodb.com/solutions/use-cases](https://www.mongodb.com/solutions/use-cases).

* Artificial Intelligence
* Edge Computing
* Internet of Things
* Mobile
* Payments
* Serverless Development
* Single View
* Personalization
* Catalog
* Content Management
* Mainframe Modernization
* Gaming

# Setup

## Dockerized Installation

If installed MongoDB is included `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD` then the connection URL
will be in this format `mongodb://ROOT_USERNAME:ROOT_PASSWORD@MONGODB_HOST:PORT`,
i.g., `mongodb://root:root@mongo:27017` otherwise remove username and password from every place in this tutorial. Maybe
for some operations you need to add `?authSource=admin"` as parameter at then end of URL connection.

### Config File

If you set up MongoDB with username and password then you should enable `security.authorization` in `mongod.conf`
located in `/etc` directory of MongoDB machine. In oder to apply this change,
add `/path/to/mongod.conf:/etc/mongod.conf` volume to the docker compose file and put the customized config file in
the `/path/to/` directory in your machine.

In the following you can see the prepared config file and docker compose file.

```textmate
#mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
#  engine:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

security:
  authorization: enabled

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options:

#auditLog:
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  mongo:
    image: mongo
    container_name: mongo
    hostname: mongo
    restart: always
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: root
    volumes:
      - "./config/mongod.conf:/etc/mongod.conf"
  mongo-express:
    image: mongo-express
    container_name: mongo-express
    hostname: mongo-express
    restart: always
    ports:
      - "8081:8081"
    environment:
      ME_CONFIG_OPTIONS_EDITORTHEME: "ambiance"
      ME_CONFIG_BASICAUTH: false
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: root
      ME_CONFIG_MONGODB_URL: mongodb://root:root@mongo:27017
```

Execute the command mentioned in the below to create MongoDB container.

```shell
docker compose --file docker-compose.yml --project-name mongo up -d --build
```

## Kubernetes Installation

create the following Kubernetes files then apply them.


[mongo-configmap](./kube/mongo-configmap).yml         
mongo-deployment.yml        
mongo-express-deployment.yml
mongo-express-service.yml   
mongo-pvc.yml               
mongo-secrets.yml           
mongo-service.yml



## Mongo Shell

Follow the below command to connect to dockerized MongoDB instance.

```shell
docker exec -it mongo mongosh mongodb://username:password@host:port

# Example
docker exec -it mongo mongosh mongodb://root:root@mongo:27017
```

## Mongo Express

Login to [http://localhost:8081](http://localhost:8081) to access Mongo Express dashboard.

# Queries

## New Database

To create a new database in MongoDB, you must execute this command: `use database-name;`, e.g., `use tutorial;`

```shell
use tutorial;
db.getName();
```

## CR~~U~~D Collection

### Create

```shell
db.createCollection("collection-name");

#Example
db.createCollection("persons");
```

### Read

```shell
# Show all collection of the database
show collections;
```

### Delete

```shell
db.collection_name.drop();

# Exmample
db.persons.drop();
```

## CRUD Document

### Insert

```shell
db.collection_name.insertOne(string-json);

# Example:
db.persons.insertOne({
    "ID": 1,
    "Salutation": "Mr.",
    "FirstName": "John",
    "LastName": "Doe",
    "DateOfBirth": "1985-04-23",
    "Gender": "Male",
    "MaritalStatus": "Single",
    "BirthNationality": "American",
    "CurrentNationality": "American",
    "Country": "USA",
    "Province": "California",
    "City": "Los Angeles",
    "ZipCode": "90001",
    "Street": "Sunset Blvd",
    "HouseNumber": "123",
    "MobilePhone": "+1-310-555-1234",
    "EmailAddress": "john.doe@example.com",
    "JobTitle": "Software Engineer",
    "FieldOfStudy": "Computer Science",
    "AcademicDegree": "Bachelor"
});
```

### Insert Many

```shell
db.persons.insertMany(
[
  {"ID": 1, "Salutation": "Mr.", "FirstName": "John", "LastName": "Doe", "DateOfBirth": "1985-04-23", "Gender": "Male", "MaritalStatus": "Single", "BirthNationality": "American", "CurrentNationality": "American", "Country": "USA", "Province": "California", "City": "Los Angeles", "ZipCode": "90001", "Street": "Sunset Blvd", "HouseNumber": "123", "MobilePhone": "+1-310-555-1234", "EmailAddress": "john.doe@example.com", "JobTitle": "Software Engineer", "FieldOfStudy": "Computer Science", "AcademicDegree": "Bachelor"},
  {"ID": 2, "Salutation": "Ms.", "FirstName": "Jane", "LastName": "Smith", "DateOfBirth": "1990-07-15", "Gender": "Female", "MaritalStatus": "Married", "BirthNationality": "British", "CurrentNationality": "British", "Country": "UK", "Province": "England", "City": "London", "ZipCode": "E1 6AN", "Street": "Baker Street", "HouseNumber": "221B", "MobilePhone": "+44-20-7946-0958", "EmailAddress": "jane.smith@example.co.uk", "JobTitle": "Data Analyst", "FieldOfStudy": "Statistics", "AcademicDegree": "Master"},
  {"ID": 3, "Salutation": "Dr.", "FirstName": "Alice", "LastName": "Johnson", "DateOfBirth": "1975-09-30", "Gender": "Female", "MaritalStatus": "Divorced", "BirthNationality": "Canadian", "CurrentNationality": "Canadian", "Country": "Canada", "Province": "Ontario", "City": "Toronto", "ZipCode": "M5H 2N2", "Street": "King Street", "HouseNumber": "456", "MobilePhone": "+1-416-555-7890", "EmailAddress": "alice.johnson@example.ca", "JobTitle": "Research Scientist", "FieldOfStudy": "Biology", "AcademicDegree": "PhD"},
  {"ID": 4, "Salutation": "Mr.", "FirstName": "Michael", "LastName": "Brown", "DateOfBirth": "1980-12-10", "Gender": "Male", "MaritalStatus": "Married", "BirthNationality": "Australian", "CurrentNationality": "Australian", "Country": "Australia", "Province": "New South Wales", "City": "Sydney", "ZipCode": "2000", "Street": "George Street", "HouseNumber": "789", "MobilePhone": "+61-2-5555-0123", "EmailAddress": "michael.brown@example.com.au", "JobTitle": "Marketing Manager", "FieldOfStudy": "Business Administration", "AcademicDegree": "Bachelor"},
  {"ID": 5, "Salutation": "Ms.", "FirstName": "Maria", "LastName": "Garcia", "DateOfBirth": "1995-06-20", "Gender": "Female", "MaritalStatus": "Single", "BirthNationality": "Spanish", "CurrentNationality": "Spanish", "Country": "Spain", "Province": "Madrid", "City": "Madrid", "ZipCode": "28001", "Street": "Gran Via", "HouseNumber": "100", "MobilePhone": "+34-91-555-6789", "EmailAddress": "maria.garcia@example.es", "JobTitle": "Graphic Designer", "FieldOfStudy": "Design", "AcademicDegree": "Bachelor"},
  {"ID": 6, "Salutation": "Dr.", "FirstName": "Raj", "LastName": "Patel", "DateOfBirth": "1970-11-11", "Gender": "Male", "MaritalStatus": "Married", "BirthNationality": "Indian", "CurrentNationality": "Indian", "Country": "India", "Province": "Maharashtra", "City": "Mumbai", "ZipCode": "400001", "Street": "Marine Drive", "HouseNumber": "101", "MobilePhone": "+91-22-5555-7890", "EmailAddress": "raj.patel@example.in", "JobTitle": "Cardiologist", "FieldOfStudy": "Medicine", "AcademicDegree": "PhD"},
  {"ID": 7, "Salutation": "Mr.", "FirstName": "Chen", "LastName": "Wang", "DateOfBirth": "1988-05-05", "Gender": "Male", "MaritalStatus": "Single", "BirthNationality": "Chinese", "CurrentNationality": "Chinese", "Country": "China", "Province": "Beijing", "City": "Beijing", "ZipCode": "100000", "Street": "Chang'an Avenue", "HouseNumber": "202", "MobilePhone": "+86-10-5555-6789", "EmailAddress": "chen.wang@example.cn", "JobTitle": "Civil Engineer", "FieldOfStudy": "Engineering", "AcademicDegree": "Master"},
  {"ID": 8, "Salutation": "Ms.", "FirstName": "Fatima", "LastName": "Al-Farsi", "DateOfBirth": "1982-03-15", "Gender": "Female", "MaritalStatus": "Married", "BirthNationality": "Saudi Arabian", "CurrentNationality": "Saudi Arabian", "Country": "Saudi Arabia", "Province": "Riyadh", "City": "Riyadh", "ZipCode": "11564", "Street": "Olaya Street", "HouseNumber": "303", "MobilePhone": "+966-11-555-7890", "EmailAddress": "fatima.alfarsi@example.sa", "JobTitle": "HR Manager", "FieldOfStudy": "Human Resources", "AcademicDegree": "Bachelor"},
  {"ID": 9, "Salutation": "Mr.", "FirstName": "Leon", "LastName": "Müller", "DateOfBirth": "1992-08-25", "Gender": "Male", "MaritalStatus": "Single", "BirthNationality": "German", "CurrentNationality": "German", "Country": "Germany", "Province": "Bavaria", "City": "Munich", "ZipCode": "80331", "Street": "Maximilianstraße", "HouseNumber": "404", "MobilePhone": "+49-89-555-6789", "EmailAddress": "leon.mueller@example.de", "JobTitle": "Mechanical Engineer", "FieldOfStudy": "Mechanical Engineering", "AcademicDegree": "Master"},
  {"ID": 10, "Salutation": "Ms.", "FirstName": "Akira", "LastName": "Tanaka", "DateOfBirth": "1983-02-18", "Gender": "Female", "MaritalStatus": "Married", "BirthNationality": "Japanese", "CurrentNationality": "Japanese", "Country": "Japan", "Province": "Tokyo", "City": "Tokyo", "ZipCode": "100-0001", "Street": "Ginza", "HouseNumber": "505", "MobilePhone": "+81-3-5555-6789", "EmailAddress": "akira.tanaka@example.jp", "JobTitle": "Financial Analyst", "FieldOfStudy": "Finance", "AcademicDegree": "MBA"}
]
);

```

### Insert Bulk (From JSON File)

Create a file insertPersons.js then copy and past the following codes.

```js
const fs = require('fs');

const username = 'root';  // Replace with your username
const password = 'root';  // Replace with your password
const dbName = 'tutorial';      // Replace with your database name

const db = connect(`mongodb://${username}:${password}@localhost:27017/${dbName}?authSource=admin`);

const bulkOps = JSON.parse(fs.readFileSync('persons.json', 'utf8'))
    .map(doc => ({
        insertOne: {document: doc}
    }));

const result = db.persons.bulkWrite(bulkOps);

printjson(result);
```

Copy persons.json and insertPersons.js to docker container.

```shell
docker cp  path/to/host-file container-name:path/to/contaner-file

#Example
docker cp ./persons.json mongo:/persons.json
docker cp  ./insertPersons.js mongo:/insertPersons.js 
```

Mongosh can interpret JS files therefore run the following command to insert data.

```shell
docker exec -it mongo mongosh "mongodb://${username}:${password}@localhost:27017/${dbName}?authSource=admin" insertPersons.js

#Example
docker exec -it mongo mongosh "mongodb://root:root@mongo:27017/tutorial?authSource=admin" insertPersons.js
```

### Find

```shell
db.collection_name.find({conditions}, {projection});

# Example
db.persons.find({},{_id:0, FirstName:1,LastName:1});
```

### Set

```shell
db.persons.updateMany(
    {},
    [
        {
            $set: {
                Address: {
                    Country: "$Country",
                    Province: "$Province",
                    City: "$City",
                    ZipCode: "$ZipCode",
                    Street: "$Street",
                    HouseNumber: "$HouseNumber"
                }
            }
        },
        {
            $unset: ["Country", "Province", "City", "ZipCode", "Street", "HouseNumber"]
        }
    ]
);
```

### Delete

```shell
db.collection_name.deleteOne({ conditions });

# Example
db.collection_name.deleteOne({ _id: ObjectId("object_id") });

```

### Aggregation (Virtual Field)

```shell
db.persons.aggregate(
    [
        {
            $addFields: {
                FullName: {"$concat": ["$FirstName", "$LastName"]},
                Age: {
                    $floor: {
                        $divide: [{
                            $subtract: [new Date(), {$dateFromString: {dateString: "$DateOfBirth",format: "%Y-%m-%d"}}]
                        }, 1000 * 60 * 60 * 24 * 365]
                    }
                }
            }
        },
        {"$project": {_id: 0, FullName: 1, Age: 1}}
    ]
);
```

### Aggregation (Group By)

```shell
db.persons.aggregate( [ { $group : { _id : "$Address.Country", count: { $count:{} } } } ] )
```

## GridFS

It is for storing Binary files as BSON.

```shell
mongofiles --host localhost --port 27017 --username root --password root --authenticationDatabase admin --db tutorial put the-file
mongofiles --host localhost --port 27017 --username root --password root --authenticationDatabase admin --db tutorial list
mongofiles --host localhost --port 27017 --username root --password root --authenticationDatabase admin --db tutorial get the-file
mongofiles --host localhost --port 27017 --username root --password root --authenticationDatabase admin --db tutorial delete the-file

# Example
docker exec -it mongo mongofiles --host localhost --port 27017 --username root --password root --authenticationDatabase admin --db tutorial put persons.json

```

#

**<p align="center"> [Top](#mongodb) </p>**