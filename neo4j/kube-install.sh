# ======================================================================================================================
# Neo4j
# ======================================================================================================================
kubectl apply -f ./kube/neo4j-pvc.yml
# kubectl get pvc
# kubectl describe pvc neo4j-pvc

kubectl apply -f ./kube/neo4j-secrets.yml
# kubectl describe secret neo4j-secrets -n default
# kubectl get secret neo4j-secrets -n default -o yaml

kubectl apply -f ./kube/neo4j-deployment.yml
# kubectl get deployments -n default
# kubectl describe deployment neo4j -n default

kubectl apply -f ./kube/neo4j-service.yml
# kubectl get service -n default
# kubectl describe service neo4j -n default

# ======================================================================================================================
# After Install
# ======================================================================================================================
kubectl get all

# ======================================================================================================================
# Access from localhost
# ======================================================================================================================
# if you want to connect database from localhost through the application use the following command
kubectl port-forward service/neo4j 7687:7687

# if you want to connect to neo4j from localhost through the web browser use the following command
# http://localhost:7474
kubectl port-forward service/neo4j 7474:7474
