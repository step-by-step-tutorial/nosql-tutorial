docker-compose-deploy:
	docker compose --file docker-compose.yml --project-name couchdb up --build -d

docker-remove-container:
	docker rm couchdb --force

docker-remove-image:
	docker image rm couchdb

kube-deploy:
	kubectl apply -f ./kube/couchdb-deployment.yml
	kubectl apply -f ./kube/couchdb-service.yml

kube-remove:
	kubectl delete all --all

kube-port-forward-db:
	kubectl port-forward service/couchdb 5984:5984
