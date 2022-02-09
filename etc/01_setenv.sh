#!/bin/bash

echo "sghaha"



cd ~/environment
pwd

eksctl create cluster -f eks-demo-cluster.yaml







rolearn=$(aws cloud9 describe-environment-memberships --environment-id=$C9_PID | jq -r '.memberships[].userArn')
echo ${rolearn}
eksctl create iamidentitymapping --cluster eks-demo --arn ${rolearn} --group system:masters --username admin
kubectl describe configmap -n kube-system aws-auth



cd ~/environment/manifests/alb-ingress-controller

eksctl utils associate-iam-oidc-provider \
    --region ${AWS_REGION} \
    --cluster eks-demo \
    --approve
    
    

RESULT=$(aws eks describe-cluster --name eks-demo --query "cluster.identity.oidc.issuer" --output text | cut -d"/" -f5)
aws iam list-open-id-connect-providers | grep $RESULT




eksctl create iamserviceaccount \
    --cluster eks-demo \
    --namespace kube-system \
    --name aws-load-balancer-controller \
    --attach-policy-arn arn:aws:iam::$ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve
    
aws logs put-retention-policy --log-group-name /aws/eks/eks-demo/cluster --retention-in-days 1
    
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.4.1/cert-manager.yaml




#kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.4.1/cert-manager.yaml
#cd ~/environment/manifests/alb-ingress-controller
#kubectl apply -f v2_2_1_full.yaml
#kubectl get deployment -n kube-system aws-load-balancer-controller







