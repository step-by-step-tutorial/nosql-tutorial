docker-deploy:
	docker compose --file docker-compose.yml --project-name mongo up -d

docker-rebuild-deploy:
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

kube-port-forward-db:
	kubectl port-forward service/mongo 27017:27017

kube-port-forward-web:
	kubectl port-forward service/mongo-express 8081:8081
