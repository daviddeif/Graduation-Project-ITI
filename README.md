# Graduation Project ITI (USING GCP):

## Project Requirements:
Deploy backend application on kubernetes cluster using CI/CD jenkins pipeline using the following steps :
1. Implement secure Kubernetes cluster.
2. Deploy and configure Jenkins on Kubernetes.
3. Deploy backend application on Kubernetes using Jenkins pipeline.
   
## 1-Create Infrastructure Using Terraform :
   - VPC.
   - Subnets(management subnet & restricted subnet).
   - Cloud Routers.
   - Cloud Nats.
   - Private Instance (to connect the cluster).
   - Firewall rule(Only the management subnet can connect to the gke cluster).
   - Service accounts with private key.
   - private GKE cluster.
   (note: all configurations files used of infrastructure is provided in [infra] folder in this repo)
   ```bash 
   terraform init
   terraform apply 
   ```

## 2-Use the private-instance to get into the cluster:
   - you could do it by just adding the configuration.sh script file(provided) into the instance and run it.
   - then CONGRATULATIONS you are into cluster and all tools required is installed.
  
## 3-Deploy Jenkins(with gcloud installed on it) on Cluster:
   - Create namespace jenkins.
   - Apply pvc.yaml .
   - Apply deployment(used the modified jenkins image with glcoud).yaml .
   - Apply service.yaml .
   (note: all configurations files used of jenkins deployment is provided in [deploying_jenkins_yaml_files] folder in this repo)
   ![alt text](https://github.com/daviddeif/Graduation-Project-ITI/blob/master/screenshots/deploy%20jenkins.png)

      
## 4-Create Jenkinsfile of pipeline:
   - Build Dockerfile of backend application(in my case I used nginx webserver).
   - Push to Dockerhub(or any other hosting repository service) .
   - Connect to cluster using credentials.
   - apply yaml files of backend application.
   	-namespace
   	-deployment
   	-service
   (note: Jenkinsfile used for the pipeline is provided in this repo)
   (note: all configurations files used of backend application deployment is provided in [deployed_app_nginx] folder in this repo)
   
   
## 5-Check running backend application:
   ```bash
   kubectl get all -n webserver
   ```
   - take the loadbalancer external-ip.
   - put it into your browser followed by the exposed port.
  
   ![alt text](https://github.com/daviddeif/Graduation-Project-ITI/blob/master/screenshots/deployed(webserver)%20information.png)
   ![alt text](https://github.com/daviddeif/Graduation-Project-ITI/blob/master/screenshots/URL%20output(manually%20trigger).png)
   
   
## 6-Configure webhook to automate running pipeline (after push to repo):
   - After pushing any updates to the repo.
   - Hit the application url again to check the changes applied.
   ![alt text](https://github.com/daviddeif/Graduation-Project-ITI/blob/master/screenshots/URL%20output(automatic%20trigger).png)
   
   
  

