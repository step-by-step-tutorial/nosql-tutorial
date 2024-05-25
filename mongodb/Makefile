deployToDocker:
	docker compose --file docker-compose.yml --project-name mongo up -d

deployToDockerWithRebuild:
	docker compose --file docker-compose.yml --project-name mongo up --build -d

shutdownContainers:
	docker rm mongo --force
	docker rm mongo-express --force

deleteImages:
	docker image rm mongo
	docker image rm mongo-express

deployToKube:
	kubectl apply -f ./kube/mongo-pvc.yml
	kubectl apply -f ./kube/mongo-secrets.yml
	kubectl apply -f ./kube/mongo-configmap.yml
	kubectl apply -f ./kube/mongo-deployment.yml
	kubectl apply -f ./kube/mongo-service.yml
	kubectl apply -f ./kube/mongo-express-deployment.yml
	kubectl apply -f ./kube/mongo-express-service.yml

shutdownKube:
	kubectl delete all --all
	kubectl delete secrets mongo-secrets
	kubectl delete secrets mongo-configmap
	kubectl delete persistentvolumeclaim mongo-pvc

bindMongoToLocalhost:
	kubectl port-forward service/mongo 27017:27017

bindMongoExpressToLocalhost:
	kubectl port-forward service/mongo-express 8081:8081
