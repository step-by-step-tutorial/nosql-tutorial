docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name janusgraph up --build -d

docker-remove-container:
	docker rm janusgraph --force

docker-remove-image:
	docker image rm janusgraph

kube-deploy:

kube-remove:
	kubectl delete all --all

kube-port-forward-janusgraph:
	kubectl port-forward service/mongo 8182:8182
