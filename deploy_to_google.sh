#!/bin/bash


set -e

# authenticate to google cloud
codeship_google authenticate

# set compute zone
gcloud config set compute/zone us-west1-b

# set kubernetes cluster
gcloud container clusters get-credentials codeship

# update kubernetes Deployment
GOOGLE_APPLICATION_CREDENTIALS=/keyconfig.json kubectl set image deployment/deployment-name app=gcr.io/greg-brown-sandbox/hellonode:$CI_TIMESTAMP

