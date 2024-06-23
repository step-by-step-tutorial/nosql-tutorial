REM ====================================================================================================================
REM Neo4j
REM ====================================================================================================================
kubectl apply -f ./kube/neo4j-pvc.yml
REM kubectl get pvc
REM kubectl describe pvc neo4j-pvc

kubectl apply -f ./kube/neo4j-secrets.yml
REM kubectl describe secret neo4j-secrets -n default
REM kubectl get secret neo4j-secrets -n default -o yaml

kubectl apply -f ./kube/neo4j-deployment.yml
REM kubectl get deployments -n default
REM kubectl describe deployment neo4j -n default

kubectl apply -f ./kube/neo4j-service.yml
REM kubectl get service -n default
REM kubectl describe service neo4j -n default

REM ====================================================================================================================
REM After Install
REM ====================================================================================================================
kubectl get all

REM ====================================================================================================================
REM Access from localhost
REM ====================================================================================================================
REM if you want to connect database from localhost through the application use the following command
start cmd /k kubectl port-forward service/neo4j 7687:7687

REM if you want to connect to neo4j from localhost through the web browser use the following command
REM http://localhost:7474
start cmd /k kubectl port-forward service/neo4j 7474:7474
