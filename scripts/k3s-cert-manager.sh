#!/bin/bash

kubectl create ns cert-manager |:

# Install cert-manager CRD
# kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.0/cert-manager.crds.yaml
# kubectl delete --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.0/cert-manager.crds.yaml

# kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.0-alpha.0/cert-manager.crds.yaml

# helm repo add jetstack https://charts.jetstack.io && helm repo update
helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager  --version v0.16.0

# Certificate Issuer LetsEncrypt Staging 
cat <<EOF | kubectl apply -f -
---
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
  namespace: cert-manager
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
  namespace: cert-manager
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
