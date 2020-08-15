#!/bin/bash


# DOESNT WORK ON ARM

# Certificate Issuer LetsEncrypt Prod
cat <<EOF | kubectl apply -n demo -f -
# ---
# hello-kubernetes.yaml
# apiVersion: v1
# kind: Service
# metadata:
#   name: hello-kubernetes
# spec:
#   type: ClusterIP
#   ports:
#   - port: 80
#     targetPort: 8080
#   selector:
#     app: hello-kubernetes
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-kubernetes
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hello-kubernetes
  template:
    metadata:
      labels:
        app: hello-kubernetes
    spec:
      containers:
      - name: hello-kubernetes
        image: paulbouwer/hello-kubernetes:1.8
        ports:
        - containerPort: 8080
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: hello-kubernetes
  annotations:
    kubernetes.io/ingress.class: "nginx"
    cert-manager.io/cluster-issuer: "letsencrypt-staging"
spec:
  tls:
  - hosts:
    - demo.livingroom.cloud
    secretName: "demo.livingroom.cloud-staging-tls"
  rules:
  - host: demo.livingroom.cloud
    http:
      paths:
        - path: /
          backend:
            serviceName: hello-kubernetes
            servicePort: 8080
---
EOF
