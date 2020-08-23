#!/bin/bash

# kubectl delete -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

# Create Media PV
cat <<EOF | kubectl delete -f -
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: "ssd-pny250"
  labels:
    type: "local"
spec:
  storageClassName: "local-path"
  capacity:
    storage: "200Gi"
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/ssd/pny250"
EOF

# Create Media PVC
# cat <<EOF | kubectl delete -f -
# ---
# apiVersion: v1
# kind: PersistentVolumeClaim
# metadata:
#   namespace: "plex"
#   name: "ssd-plex"
# spec:
#   storageClassName: "local-path"
#   accessModes:
#     - ReadWriteOnce
#   resources:
#     requests:
#       storage: "120Gi"
# EOF
