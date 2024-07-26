docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name neo4j up --build -d

docker-remove-container:
	docker rm neo4j --force

docker-remove-image:
	docker image rm neo4j

kube-deploy:
	kubectl apply -f ./kube/neo4j-pvc.yml
	kubectl apply -f ./kube/neo4j-secret.yml
	kubectl apply -f ./kube/neo4j-deployment.yml
	kubectl apply -f ./kube/neo4j-service.yml

kube-remove:
	kubectl delete all --all
	kubectl delete secrets neo4j-secrets
	kubectl delete persistentvolumeclaim neo4j-pvc

kube-port-forward-db:
	kubectl port-forward service/neo4j 7474:7474

kube-port-forward-web:
	kubectl port-forward service/neo4j 7687:7687
