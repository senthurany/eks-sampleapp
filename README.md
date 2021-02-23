# eks-sampleapp

## Introduction

A Sample Node app to deploy into AWS EKS.

Required Dockerfiles and dependency files are provided.

Use the below command to build the docker image inside the eks-sampleapp directory.


### Prequisites 

    - Install kubectl.
    - Install awscli. 
    - Configure aws credentials either via cli or in ~/.aws/credentials file.
    - Make sure docker service is up and running.
    - Use WSL UBUNTU if running on windows. 


## Automatic Deployment 

A shell script is provided for automated deployment for this application.

This is One Click Exectution for deploying sample application.

Make sure the aws credentials are currectly configured and use the below commands,

```
    chmod +x deploy.sh
    ./deploy.sh
```
## Manual Deployment

Follow the below step by step to deploy manually. 


### Create a ECR Registry 
```
    aws ecr create-repository --repository-name  eks-sampleapp --region <region>
```

### Login to the ECR Registy 

```
    aws ecr get-login --region <region> 
```
*Copy and paste the output of the above command in your command prompt. Make sure Docker is up and running*
### Build and push the Image to the registry
```
    docker build -t <aws_account_id>.dkr.ecr>.<region>.amazonaws.com/eks-sampleapp .
    docker push  <aws_account_id>.dkr.ecr.<region>.amazonaws.com/eks-sampleapp
```

## Deploying application to EKS
### Get access to the Kubernetes via api
```
aws eks update-kubeconfig --name <cluster-name> --region <region>
```
*Replace the line 35 in deploy.yaml with your registry details, Only region and account id should be changed if the registry name is eks-sampleapp* 
*Make sure to replace the namespace which a fargate profile associated*
*381464687983.dkr.ecr.us-east-1.amazonaws.com/eks-sampleapp* 
```
    kubectl apply -f deploy.yaml
```
## Verify Service
Check the pods status using the following commands

```
    kubectl get pods -n <namespace>
```