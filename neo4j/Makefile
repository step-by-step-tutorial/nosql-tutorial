deployToDocker:
	docker compose --file docker-compose.yml --project-name neo4j up -d

deployToDockerWithRebuild:
	docker compose --file docker-compose.yml --project-name neo4j up --build -d

shutdownContainers:
	docker rm neo4j --force

deleteImages:
	docker image rm neo4j

deployToKube:
	kubectl apply -f ./kube/neo4j-pvc.yml
	kubectl apply -f ./kube/neo4j-deployment.yml
	kubectl apply -f ./kube/neo4j-service.yml

shutdownKube:
	kubectl delete all --all
	kubectl delete persistentvolumeclaim neo4j-pvc

bindNeo4jToLocalhost:
	kubectl port-forward service/neo4j 7474:7474
