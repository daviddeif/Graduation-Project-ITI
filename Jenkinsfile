pipeline {
    agent any
    environment {
        YOUR_CRED = credentials("dockerhub")
    }
    stages {

        stage('CI'){
            steps {
                   // get code for repository       
                git 'https://github.com/daviddeif/Graduation-Project-ITI.git'

                sh "docker login -u ${YOUR_CRED_USR} -p ${YOUR_CRED_PSW}"
                sh "docker build deploy_nginx/ -t daviddeif/nginx:v$BUILD_NUMBER"
                sh "docker push daviddeif/nginx:v$BUILD_NUMBER"
            }
        }

        stage('CD'){
            steps {

                withCredentials([file(credentialsId: 'gcp-serviceaccount', variable: 'config')]){
                    sh """
                        gcloud auth activate-service-account --key-file=${config}   
                        gcloud container clusters get-credentials private-cluster --region europe-west1 --project david-emad-project  
                        sed -i 's/tag/${BUILD_NUMBER}/g' deploy_nginx/deployment_app.yaml
                        kubectl apply deploy_nginx/name
                        kubectl apply -Rf deploy_nginx

                    """
                }
            }
 
        }
    }
    
}