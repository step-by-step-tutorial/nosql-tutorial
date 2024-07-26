docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name mongo up --build -d

docker-remove-container:
	docker rm mongo --force
	docker rm mongo-express --force

docker-remove-image:
	docker image rm mongo
	docker image rm mongo-express

kube-deploy:
	kubectl apply -f ./kube/mongo-secrets.yml
	kubectl apply -f ./kube/mongo-configmap.yml
	kubectl apply -f ./kube/mongo-pvc.yml
	kubectl apply -f ./kube/mongo-deployment.yml
	kubectl apply -f ./kube/mongo-service.yml
	kubectl apply -f ./kube/mongo-express-deployment.yml
	kubectl apply -f ./kube/mongo-express-service.yml

kube-remove:
	kubectl delete all --all
	kubectl delete secrets mongo-secrets
	kubectl delete secrets mongo-configmap
	kubectl delete persistentvolumeclaim mongo-pvc

kube-port-forward-mongo:
	kubectl port-forward service/mongo 27017:27017

kube-port-forward-mongo-express:
	kubectl port-forward service/mongo-express 8081:8081

insert-bulk:
	docker cp ./persons.json mongo:/persons.json
	docker cp  ./insertPersons.js mongo:/insertPersons.js
	docker exec -it mongo mongosh "mongodb://root:root@mongo:27017/tutorial?authSource=admin" insertPersons.js

insert-file:
	docker cp ./persons.json mongo:/persons.json
	docker exec -it mongo mongofiles --host localhost --port 27017 --username root --password root --authenticationDatabase admin --db tutorial put persons.json

run-test:
	docker cp ./testCrud.json mongo:/testCrud.json
	docker exec -it mongo mongosh "mongodb://root:root@mongo:27017/tutorial?authSource=admin" testCrud.js
