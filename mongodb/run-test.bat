docker cp ./crud-test.json mongo:/crud-test.json
docker exec -it mongo mongosh "mongodb://root:root@mongo:27017/tutorial?authSource=admin" crud_test.js
