#!/bin/bash


cd ~/environment/manifests/


kubectl delete -f ingress-backend.yaml
kubectl delete -f ingress-frontend.yaml

kubectl delete -f alb-ingress-controller/v2_2_1_full.yaml

#kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

eksctl delete nodegroup --cluster=sghaha-eks --name=node-group
eksctl delete cluster --name=sghaha-eks



aws logs describe-log-groups --query 'logGroups[*].logGroupName' --output table | \
awk '{print $2}' | grep ^/aws/containerinsights/sghaha-eks | while read x; do  echo "deleting $x" ; aws logs delete-log-group --log-group-name $x; done

aws logs describe-log-groups --query 'logGroups[*].logGroupName' --output table | \
awk '{print $2}' | grep ^/aws/eks/sghaha-eks | while read x; do  echo "deleting $x" ; aws logs delete-log-group --log-group-name $x; done