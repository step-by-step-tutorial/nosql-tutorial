REM ====================================================================================================================
REM MongoDB
REM ====================================================================================================================
kubectl apply -f ./kube/mongo-pvc.yml
REM kubectl get pvc
REM kubectl describe pvc mongo-pvc

kubectl apply -f ./kube/mongo-secrets.yml
REM kubectl describe secret mongo-secrets -n default
REM kubectl get secret mongo-secrets -n default -o yaml

kubectl apply -f ./kube/mongo-deployment.yml
REM kubectl get deployments -n default
REM kubectl describe deployment mongo -n default

kubectl apply -f ./kube/mongo-service.yml
REM kubectl get service -n default
REM kubectl describe service mongo -n default

REM ====================================================================================================================
REM Mongo Express
REM ====================================================================================================================
kubectl apply -f ./kube/mongo-express-deployment.yml
REM kubectl get deployments -n default
REM kubectl describe deployment mongo-express -n default

kubectl apply -f ./kube/mongo-express-service.yml
REM kubectl get services -n default
REM kubectl describe service mongo-express -n default

REM ====================================================================================================================
REM After Install
REM ====================================================================================================================
kubectl get all

REM ====================================================================================================================
REM Access from localhost
REM ====================================================================================================================
REM if you want to connect database from localhost through the application use the following command
kubectl port-forward service/mongo 27017:27017

REM if you want to connect to mongo-express from localhost through the web browser use the following command
REM http://localhost:8081
kubectl port-forward service/mongo-express 8081:8081
