#!/bin/bash

# ███╗░░░███╗███████╗████████╗░█████╗░██╗░░░░░██╗░░░░░██████╗░
# ████╗░████║██╔════╝╚══██╔══╝██╔══██╗██║░░░░░██║░░░░░██╔══██╗
# ██╔████╔██║█████╗░░░░░██║░░░███████║██║░░░░░██║░░░░░██████╦╝
# ██║╚██╔╝██║██╔══╝░░░░░██║░░░██╔══██║██║░░░░░██║░░░░░██╔══██╗
# ██║░╚═╝░██║███████╗░░░██║░░░██║░░██║███████╗███████╗██████╦╝
# ╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚═════╝░
#
# https://metallb.universe.tf/installation/
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.4/config/manifests/metallb-native.yaml

# Create MetalLB Address Pool
cat <<EOF | kubectl apply -f -
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: metallb-pool-10-0-1-0-24
  namespace: metallb-system
spec:
  addresses:
  - 10.0.1.0/24
---
EOF

# Create MetalLB Advertisement
cat <<EOF | kubectl apply -f -
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: metallb-l2-advertisement
  namespace: metallb-system
---
EOF

# ███╗░░██╗░██████╗░██╗███╗░░██╗██╗░░██╗░░░░░░██╗███╗░░██╗░██████╗░██████╗░███████╗░██████╗░██████╗
# ████╗░██║██╔════╝░██║████╗░██║╚██╗██╔╝░░░░░░██║████╗░██║██╔════╝░██╔══██╗██╔════╝██╔════╝██╔════╝
# ██╔██╗██║██║░░██╗░██║██╔██╗██║░╚███╔╝░█████╗██║██╔██╗██║██║░░██╗░██████╔╝█████╗░░╚█████╗░╚█████╗░
# ██║╚████║██║░░╚██╗██║██║╚████║░██╔██╗░╚════╝██║██║╚████║██║░░╚██╗██╔══██╗██╔══╝░░░╚═══██╗░╚═══██╗
# ██║░╚███║╚██████╔╝██║██║░╚███║██╔╝╚██╗░░░░░░██║██║░╚███║╚██████╔╝██║░░██║███████╗██████╔╝██████╔╝
# ╚═╝░░╚══╝░╚═════╝░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝░░░░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚═════╝░
#
# Official nginx-ingress documentation: https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update

kubectl create namespace nginx-ingress
helm install nginx-ingress nginx-stable/nginx-ingress --namespace nginx-ingress --set defaultBackend.enabled=false

:

# ██╗███╗░░██╗░██████╗░██████╗░███████╗░██████╗░██████╗░░░░░░███╗░░██╗░██████╗░██╗███╗░░██╗██╗░░██╗
# ██║████╗░██║██╔════╝░██╔══██╗██╔════╝██╔════╝██╔════╝░░░░░░████╗░██║██╔════╝░██║████╗░██║╚██╗██╔╝
# ██║██╔██╗██║██║░░██╗░██████╔╝█████╗░░╚█████╗░╚█████╗░█████╗██╔██╗██║██║░░██╗░██║██╔██╗██║░╚███╔╝░
# ██║██║╚████║██║░░╚██╗██╔══██╗██╔══╝░░░╚═══██╗░╚═══██╗╚════╝██║╚████║██║░░╚██╗██║██║╚████║░██╔██╗░
# ██║██║░╚███║╚██████╔╝██║░░██║███████╗██████╔╝██████╔╝░░░░░░██║░╚███║╚██████╔╝██║██║░╚███║██╔╝╚██╗
# ╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░╚═════╝░░░░░░░╚═╝░░╚══╝░╚═════╝░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝
# Official Kubernetes Ingress: https://kubernetes.github.io/ingress-nginx/deploy/

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml

# # Wait for ingress controller to be ready
# kubectl wait --namespace ingress-nginx \
#   --for=condition=ready pod \
#   --selector=app.kubernetes.io/component=controller \
#   --timeout=120s

# # View LoadBalancer External IP
# kubectl get service ingress-nginx-controller --namespace=ingress-nginx
