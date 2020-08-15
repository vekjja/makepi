#!/bin/bash


EMAIL=seemyeings@gmail.com

kubectl create ns infra |:

# Install cert-manager CRD
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.0/cert-manager.crds.yaml

helm repo add jetstack https://charts.jetstack.io && helm repo update
helm upgrade --install cert-manager jetstack/cert-manager --namespace infra  --version v0.16.0

# Certificate Issuer LetsEncrypt Staging 
cat <<EOF | kubectl apply -f -
---
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
  namespace: infra
spec:
  acme:
    email: ${EMAIL}
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
  namespace: infra
spec:
  acme:
    email: ${EMAIL}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
---
EOF

# Example Ingress
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
#     - <domain>
#     secretName: "<domain>-staging-tls"
#   rules:
#   - host: <domain>
#     http:
#       paths:
#         - path: /
#           backend:
#             serviceName: <service_name>
#             servicePort: 80
# ---
