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