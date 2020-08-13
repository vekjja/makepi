#!/bin/bash


readonly dashboardURL=http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login
K3SCONFIG=~/.kube/k3sconfig

# Get admin-user token
kubectl --kubeconfig ${K3SCONFIG} -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

# echo $k8sToken | pbcopy

echo
echo Kubernetes Dashboard URL: $dashboardURL
# echo A valid K8S token was saved to your clipboard 
kubectl proxy



