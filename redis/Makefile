docker-deploy:
	docker compose --file docker-compose.yml --project-name redis up -d

docker-rebuild-deploy:
	docker compose --file docker-compose.yml --project-name redis up --build -d

docker-remove-container:
	docker rm redis --force
	docker rm redisinsight --force

docker-remove-image:
	docker image rm redis:latest
	docker image rm redislabs/redisinsight:latest

kube-deploy:
	kubectl apply -f ./kube/redis-deployment.yml
	kubectl apply -f ./kube/redis-service.yml
	kubectl apply -f ./kube/redisinsight-deployment.yml
	kubectl apply -f ./kube/redisinsight-service.yml

kube-remove:
	kubectl delete all --all

kube-port-forward-db:
	kubectl port-forward service/redis 6379:6379

kube-port-forward-web:
	kubectl port-forward service/redisinsight 8001:8001
