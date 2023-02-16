FROM jenkins/jenkins:lts
USER root

#Installing gcloud
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list 
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install google-cloud-cli
RUN apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
RUN USE_GKE_GCLOUD_AUTH_PLUGIN=True
