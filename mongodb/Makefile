createContainer:
	docker compose --file docker-compose.yml --project-name mongo up -d

rebuildContainer:
	docker compose --file docker-compose.yml --project-name mongo up --build -d

deleteContainer:
	docker rm mongo --force
	docker rm mongo-express --force

deleteImage:
	docker image rm mongo
	docker image rm mongo-express

createKube:
	kubectl apply -f ./kube/mongo-pvc.yml
	kubectl apply -f ./kube/mongo-secrets.yml
	kubectl apply -f ./kube/mongo-deployment.yml
	kubectl apply -f ./kube/mongo-service.yml
	kubectl apply -f ./kube/mongo-express-deployment.yml
	kubectl apply -f ./kube/mongo-express-service.yml

deleteKube:
	kubectl delete all --all
	kubectl delete secrets mongo-secrets
	kubectl delete persistentvolumeclaim mongo-pvc

bindLocalhost:
	kubectl port-forward service/mongo 27017:27017
	kubectl port-forward service/mongo-express 8081:8081
