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

const documentToInsert = { name: "Alice", age: 25, city: "New York" };
const insertResult = db[collectionName].insertOne(documentToInsert);
assert(insertResult.insertedId, "Insert operation failed");

const findResult = db[collectionName].findOne({ name: "Alice" });
assert(findResult, "Document not found after insert");
printjson(findResult);

const updateResult = db[collectionName].updateOne(
    { name: "Alice" },
    { $set: { age: 26 } }
);
assert(updateResult.matchedCount > 0, "No document matched for update");
assert(updateResult.modifiedCount > 0, "Document not modified");

const updatedDocument = db[collectionName].findOne({ name: "Alice" });
assert(updatedDocument, "Document not found after update");
assert(updatedDocument.age === 26, "Document not updated correctly");
printjson(updatedDocument);

const deleteResult = db[collectionName].deleteOne({ name: "Alice" });
assert(deleteResult.deletedCount > 0, "Document not deleted");

const verifyDeletion = db[collectionName].findOne({ name: "Alice" });
assert(!verifyDeletion, "Document still exists after deletion");

db.getMongo().close();

print("All operations were successful");
