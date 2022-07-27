#!bash
mvn clean install -DskipTests=true
docker build -t appurajacool2015/gkepulumispringbootpostgresrestapidemo .
# we can docker login as a initial step
#docker login
docker push appurajacool2015/gkepulumispringbootpostgresrestapidemo
KUBECONFIG=~/GKE-kubeconfig kubectl apply -f postgres-secrets.yaml
KUBECONFIG=~/GKE-kubeconfig kubectl apply -f postgres-storage.yaml
KUBECONFIG=~/GKE-kubeconfig kubectl apply -f postgres-deployment.yaml
KUBECONFIG=~/GKE-kubeconfig kubectl apply -f postgres-service.yaml
KUBECONFIG=~/GKE-kubeconfig kubectl delete configmap hostname-config
KUBECONFIG=~/GKE-kubeconfig kubectl create configmap hostname-config --from-literal=postgres_host=$(KUBECONFIG=~/GKE-kubeconfig kubectl get svc postgres -o jsonpath="{.spec.clusterIP}")
KUBECONFIG=~/GKE-kubeconfig kubectl apply -f springboot-deployment.yaml
KUBECONFIG=~/GKE-kubeconfig kubectl apply -f springboot-service.yaml

################################################################################
# Commenting the below code to as we need different KUBECONFIG for EKS and GKE #
################################################################################
#kubectl apply #f postgres#secrets.yaml
#kubectl apply #f postgres#storage.yaml
#kubectl apply #f postgres#deployment.yaml
#kubectl apply #f postgres#service.yaml
#kubectl delete config map hostname#config
#kubectl create configmap hostname#config #-from-literal=postgres_host=$(kubectl get svc postgres -o jsonpath="{.spec.clusterIP}")
#kubectl apply -f springboot-deployment.yaml
#kubectl apply -f springboot-service.yaml


