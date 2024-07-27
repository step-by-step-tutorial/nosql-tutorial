docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name mongo up --build -d

docker-remove-container:
	docker rm elasticsearch --force
	docker rm kibana --force

docker-remove-image:
	docker image rm docker.elastic.co/elasticsearch/elasticsearch:8.14.3
	docker image rm docker.elastic.co/kibana/kibana:8.14.3

kube-deploy:
	kubectl apply -f ./kube/elasticsearch-deployment.yml
	kubectl apply -f ./kube/elasticsearch-service.yml
	kubectl apply -f ./kube/kibana-deployment.yml
	kubectl apply -f ./kube/kibana-service.yml

kube-remove:
	kubectl delete all --all

kube-port-forward-elasticsearch:
	kubectl port-forward service/elasticsearch 9200:9200

kube-port-forward-kibana:
	kubectl port-forward service/kibana 5601:5601