#!/bin/bash
#nodejs-v1.yaml랑 react-v4.yaml에 이미지 번호 세팅하고 하자

cd ~/environment/manifests

kubectl apply -f nodejs-v1.yaml

kubectl apply -f react-v4.yaml

kubectl apply -f ingress-backend.yaml

kubectl apply -f ingress-frontend.yaml


