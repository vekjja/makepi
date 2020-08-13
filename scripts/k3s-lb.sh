#!/bin/bash

# Install MetalLB
helm update --install metallb stable/metallb --namespace kube-system \
  --set configInline.address-pools[0].name=default \
  --set configInline.address-pools[0].protocol=layer2 \
  --set configInline.address-pools[0].addresses[0]=10.0.1.1-10.0.1.254

# Install Nginx Ingress
helm update --install nginx-ingress stable/nginx-ingress --namespace kube-system \
  --set defaultBackend.enabled=false
