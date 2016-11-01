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

# update kubernetes Deployment
GOOGLE_APPLICATION_CREDENTIALS=/keyconfig.json kubectl set image deployment/hello-node app=gcr.io/greg-brown-sandbox/hello-node:$CI_TIMESTAMP

