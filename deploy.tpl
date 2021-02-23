apiVersion: v1
kind: Service
metadata:
  name: eks-sampleservice
  namespace: ${namespace} # Replace the namespace if it does not match your fargate profile
  labels:
    app: eks-sampleapp
spec:
  selector:
    app: eks-sampleapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: eks-sampleapp
  namespace:  ${namespace} # Replace the namespace if it does not match your fargate profile
  labels:
    app: eks-sampleapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: eks-sampleapp
  template:
    metadata:
      labels:
        app: eks-sampleapp
    spec:
      containers:
      - name: app
        image: ${ACCOUNT_ID}.dkr.ecr.${region}.amazonaws.com/eks-sampleapp # Change the ecr registry with correct one 
        ports:
        - containerPort: 3000