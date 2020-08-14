#!/bin/bash

K3SCONFIG=~/.kube/k3sconfig

 kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

# Create Media PV
cat <<EOF | kubectl --kubeconfig=${K3SCONFIG} apply -f -
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: "media-hdd"
  labels:
    type: "local"
spec:
  storageClassName: "manual"
  capacity:
    storage: "210Gi"
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/media"
---
EOF

# Create Media PVC
cat <<EOF | kubectl --kubeconfig=${K3SCONFIG} apply -f -
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  namespace: "media"
  name: "media-hdd"
spec:
  storageClassName: "manual"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: "200Gi"
---
EOF
