const username = 'root';  // Replace with your username
const password = 'root';  // Replace with your password
const dbName = 'tutorial'; // Replace with your database name
const collectionName = 'testCollection'; // You can specify your collection name

const db = connect(`mongodb://${username}:${password}@localhost:27017/${dbName}?authSource=admin`);

function assert(condition, message) {
    if (!condition) {
        throw new Error("Assertion failed: " + message);
    }
}

db[collectionName].drop();

// Insert
const givenDocument = {name: "John Doe", age: 30, city: "New York"};
const actualInsert = db[collectionName].insertOne(givenDocument);
assert(actualInsert.insertedId, "Insert operation failed");

//Find one
const actualFind = db[collectionName].findOne({name: "John Doe"});
assert(actualFind, "Document not found after insert");
printjson(actualFind);

// Update one
const updateResult = db[collectionName].updateOne(
    {name: "John Doe"},
    {$set: {age: 35}}
);
assert(updateResult.matchedCount > 0, "No document matched for update");
assert(updateResult.modifiedCount > 0, "Document not modified");

const actualUpdate = db[collectionName].findOne({name: "John Doe"});
assert(actualUpdate, "Document not found after update");
assert(actualUpdate.age === 35, "Document not updated correctly");
printjson(actualUpdate);

//Delete one
const deleteResult = db[collectionName].deleteOne({name: "John Doe"});
assert(deleteResult.deletedCount > 0, "Document not deleted");

const actualDelete = db[collectionName].findOne({name: "John Doe"});
assert(!actualDelete, "Document still exists after deletion");

db.getMongo().close();

print("All operations were successful");
