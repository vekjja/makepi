#!/bin/bash

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml

echo "Sleeping 30 seconds to wait for cert-manager webhooks"
sleep 30

echo Defining Cert Manager Staging Cluster Issuers
# Certificate Issuer LetsEncrypt Staging
cat <<EOF | kubectl apply -f -
---
apiVersion: cert-manager.io/v1
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

echo Defining Cert Manager Prod Cluster Issuers
# Certificate Issuer LetsEncrypt Prod
cat <<EOF | kubectl apply -f -
---
apiVersion: cert-manager.io/v1
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

# Example Ingress Config
# cat <<EOF | kubectl apply -n test -f -
# ---
# apiVersion: extensions/v1
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
