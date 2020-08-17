#!/bin/bash

kubectl create ns cert-manager |:

helm repo add jetstack https://charts.jetstack.io && helm repo update
helm install \
 cert-manager jetstack/cert-manager \
 --namespace cert-manager \
 --version v0.16.1 \
 --set installCRDs=true

echo "Sleeping 30 seconds to wait for cert-manager webhooks"
sleep 30

# Certificate Issuer LetsEncrypt Staging 
cat <<EOF | kubectl apply -f -
---
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    email: seemywings@gmail.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
    - http01:
        ingress:
          class: nginx
---
EOF

# Certificate Issuer LetsEncrypt Prod
cat <<EOF | kubectl apply -f -
---
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: seemywings@gmail.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
---
EOF

# cat <<EOF | kubectl apply -n test -f -
# ---
# apiVersion: extensions/v1beta1
# kind: Ingress
# metadata:
#   name: my-ingress
#   annotations:
#     kubernetes.io/ingress.class: "nginx"
#     cert-manager.io/cluster-issuer: "letsencrypt-staging"
# spec:
#   tls:
#   - hosts:
#     - demo.livingroom.cloud
#     secretName: "demo.livingroom.cloud-staging-tls"
#   rules:
#   - host: demo.livingroom.cloud
#     http:
#       paths:
#         - path: /
#           backend:
#             serviceName: nginx-test
#             servicePort: 80
# ---
# EOF
