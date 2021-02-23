# eks-sampleapp

## Introduction

A Sample Node app to deploy into AWS EKS.

Required Dockerfiles and dependency files are provided.

Use the below command to build the docker image inside the eks-sampleapp directory.
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
    docker build -t <aws_account_id>.dkr.ecr>.<region>.amazonaws.com/eks-sampleapp
    docker push  <aws_account_id>.dkr.ecr.<region>.amazonaws.com/eks-sampleapp
```

## Deploying application to EKS
### Get access to the Kubernetes via api
```
aws eks update-kubeconfig --name <cluster-name> --region <region>
```
*Replace the line 35 in deploy.yml with your registry details, Only region and account id should be changed if the registry name is eks-sampleapp* 
*Make sure you have a namespace called development and a fargate profile associated*
*381464687983.dkr.ecr.us-east-1.amazonaws.com/eks-sampleapp* 

## Verify Service
Check the pods status using the following commands

```
    kubectl get pods -n development
```