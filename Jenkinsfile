pipeline {
    agent any
    enviroment {
          YOUR_CRED = credentials('dockerhub')
    }
    stages {

        stage('CI'){
            steps {
                   // get code for repository       
                git 'https://github.com/daviddeif/Graduation-Project-ITI.git'

                sh "docker login -u ${YOUR_CRED_USR} -p ${YOUR_CRED_PSW}"
                sh "cd deploy_nginx"
                sh "docker build . -t daviddeif/ngnix:v$BUILD_NUMBER"
                sh "docker push daviddeif/nginx:v$BUILD_NUMBER"
               }
          }

        stage('CD'){
            steps {

                withCredentials([file(credentialsId: 'gcp_serviceaccount', variable: 'config')]){
                    sh """
                        gcloud auth activate-service-account --key-file=${config}   
                        gcloud container clusters get-credentials private-cluster --region europe-west1 --project david-emad-project  
                        sed -i 's/tag/${BUILD_NUMBER}/g' deploy_nginx/ngnix-deployment_app.yaml
                        kubectl create namespace webserver
                        kubectl apply -Rf deploy_nginx

                    """
                    }
               }
 
          }
     }
}