# ======================================================================================================================
# MongoDB
# ======================================================================================================================
kubectl apply -f ./kube/mongo-pvc.yml
# kubectl get pvc
# kubectl describe pvc mongo-pvc

kubectl apply -f ./kube/mongo-secrets.yml
# kubectl describe secret mongo-secrets -n default
# kubectl get secret mongo-secrets -n default -o yaml

kubectl apply -f ./kube/mongo-configmap.yml
# kubectl describe configmap mongo-configmap -n default
# kubectl get configmap mongo-configmap -n default -o yaml

kubectl apply -f ./kube/mongo-deployment.yml
# kubectl get deployments -n default
# kubectl describe deployment mongo -n default

kubectl apply -f ./kube/mongo-service.yml
# kubectl get service -n default
# kubectl describe service mongo -n default

# ======================================================================================================================
# Mongo Express
# ======================================================================================================================
kubectl apply -f ./kube/mongo-express-deployment.yml
# kubectl get deployments -n default
# kubectl describe deployment mongo-express -n default

kubectl apply -f ./kube/mongo-express-service.yml
# kubectl get services -n default
# kubectl describe service mongo-express -n default

# ======================================================================================================================
# After Install
# ======================================================================================================================
kubectl get all

# ======================================================================================================================
# Access from localhost
# ======================================================================================================================
# if you want to connect database from localhost through the application use the following command
kubectl port-forward service/mongo 27017:27017

# if you want to connect to mongo-express from localhost through the web browser use the following command
# http://localhost:8081
kubectl port-forward service/mongo-express 8081:8081
