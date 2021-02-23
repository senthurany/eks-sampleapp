    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`

echo -e "${ENTER_LINE}Please enter region you have the eks cluster on ${NORMAL}"
read region

echo -e "${ENTER_LINE}Please enter profile name for aws credentials to be picked from,type default if you haven't specified any ${NORMAL}"
read profile

echo -e "${ENTER_LINE}Please enter the EKS cluster name ${NORMAL}"
read cluster

echo -e "${ENTER_LINE}Please enter the namespace you want the app to deployed. \n ${RED_TEXT} Fargate Profile & Namespace should be created beforehand or else the script will produce an ERROR ${NORMAL}"
read namespace

export ACCOUNT_ID=$(aws sts get-caller-identity --profile $profile| grep Account | awk '{print $2}' | sed 's/"//g' | sed 's/,//g')
export namespace=$namespace
export region=$region

export ECR_PASSWORD=$(aws ecr get-login-password --region $region --profile profile)
docker login -u AWS -p ${ECR_PASSWORD} https://${ACCOUNT_ID}.dkr.ecr.${region}.amazonaws.com

docker build -t ${ACCOUNT_ID}.dkr.ecr>.${region}.amazonaws.com/eks-sampleapp .
docker push  ${ACCOUNT_ID}.dkr.ecr.${region}.amazonaws.com/eks-sampleapp


envsubst < deploy.tpl > deploy.yaml

kubectl apply -f deploy.yaml

sleep 120

kubectl get pods -n ${namespace}