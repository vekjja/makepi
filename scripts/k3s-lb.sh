#!/bin/bash

kubectl create ns infra

# Install MetalLB
helm upgrade --install metallb stable/metallb --namespace infra \
  --set configInline.address-pools[0].name=default \
  --set configInline.address-pools[0].protocol=layer2 \
  --set configInline.address-pools[0].addresses[0]=10.0.1.1-10.0.1.254

# Install Nginx Ingress
helm upgrade --install nginx-ingress stable/nginx-ingress --namespace infra \
  --set defaultBackend.enabled=false
