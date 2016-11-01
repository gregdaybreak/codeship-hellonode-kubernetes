#!/bin/bash


set -e

DEFAULT_ZONE=us-west1-b
KUBERNETES_APP_NAME=hello-node
GOOGLE_CONTAINER_NAME=gcr.io/greg-brown-sandbox/hellonode

# authenticate to google cloud
codeship_google authenticate

# Set the default zone to use
echo "Setting default compute zone $DEFAULT_ZONE"
gcloud config set compute/zone $DEFAULT_ZONE

# set kubernetes cluster
gcloud container clusters get-credentials codeship

echo "Deploying image on GCE"
kubectl run $KUBERNETES_APP_NAME --image=$GOOGLE_CONTAINER_NAME --port=8080

echo "Creating LoadBalancer to allow external traffic"
kubectl expose deployment $KUBERNETES_APP_NAME --type="LoadBalancer"

echo "Waiting for services to boot"

echo "Listing services on GCE"
kubectl get services $KUBERNETES_APP_NAME

# update kubernetes Deployment
#GOOGLE_APPLICATION_CREDENTIALS=/keyconfig.json kubectl set image deployment/hellonode app=gcr.io/greg-brown-sandbox/hellonode:$CI_TIMESTAMP

