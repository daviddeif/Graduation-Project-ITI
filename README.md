# GCP Final Project:

## Project Requirements:
- 1 VPC 
- 2 subnets (management subnet & restricted subnet):
   1. Management subnet has the following:
     • NAT gateway 
     • Private VM
   2. Restricted subnet has the following:
     • Private standard GKE cluster (private control plan)    
     
   ## Restrictions:
   1. Restricted subnet must not have access to internet
   2. All images deployed on GKE must come from GCR or Artifacts registry.
   3. The VM must be private.
   4. Deployment must be exposed to public internet with a public HTTP load balancer.
   5. All infra is to be created on GCP using terraform.
   6. Deployment on GKE can be done by terraform or manually by kubectl tool.
   7. The python code to be build/dockerized and pushed to GCR is on here: 
      ```https://github.com/atefhares/DevOps-Challenge-Demo-Code```
   8. Don’t use default compute service account while creating the gke cluster, create 
      custom SA and attach it to your nodes.
   9. Only the management subnet can connect to the gke cluster.
   
## Create Infrastructure Using Terraform :
  - VPC(As-required).
  - Subnets(As-required).
  - Cloud Router.
  - Cloud Nat.
  - Private Instance.
  - Firewall rule.
  - Service accounts.
  - GKE cluster.
  (note: all configurations files used in infrastructure is provided in this repo)
  ```bash 
  terraform init
  terraform apply 
  ```
  
## Create Image of Python Code Using Docker:
  - Dockerfile of python app.
  - Docker image of redis.
  - Configure Docker & gcloud to work with GCR of your project.
  (note: all configurations files used in containerization is provided in this repo)
  ```bash
  docker build -t <image-name>
  docker push gcr.io/<project-name>/<image-name>
  ```
  
## Use the private-instance to get into the cluster:
  - you could do it by just adding the configuration script file(provided) into the instance and run it.
  - then CONGRATULATIONS you are into cluster and all tools required is installed.
      
## Create GKE cluster yaml files:
  - deployment of python app.
  - deployment of redis database.
  - service (ClusterIP).
  - service (loadbalancer).
  (note: all yaml files used is provided in this repo)
  ```bash
  kubectl apply -f python_deploy.yaml
  kubectl apply -f redis_deploy.yaml
  kubectl apply -f service.yaml
  kubectl apply -f loadbalancer.yaml
  ```
## Check running application:
  ```bash
  kubectl get service
  ```
  - take the loadbalancer external-ip.
  - put it into your browser followed by the exposed port.
  
  ![alt text](https://github.com/daviddeif/GCP-FINAL-PROJECT/blob/master/screenshots/external-ip-loadbalancer.png)
  ![alt text](https://github.com/daviddeif/GCP-FINAL-PROJECT/blob/master/screenshots/running%20app1.png)
  

