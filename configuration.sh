#! /bin/bash
sudo apt update
sudo apt install kubectl
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
gcloud container clusters get-credentials private-cluster --region europe-west1 --project david-emad-project
