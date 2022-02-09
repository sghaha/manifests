#!/bin/bash
#nodejs-v1.yaml랑 react-v4.yaml에 이미지 번호 세팅하고 하자

cd ~/environment/manifests
kubectl delete -f ingress-backend.yaml
kubectl delete -f ingress-frontend.yaml

kubectl delete -f nodejs-v1.yaml

kubectl delete -f react-v4.yaml




