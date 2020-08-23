#!/bin/bash

# kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: "hdd-tera-300"
spec:
  persistentVolumeReclaimPolicy: Retain
  storageClassName: "hdd-tera-300"
  capacity:
    storage: "300Gi"
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/hdd/tera"
EOF

# Create Media PV
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: "ssd-pny250-120"
spec:
  persistentVolumeReclaimPolicy: Retain
  storageClassName: "ssd-pny250-120"
  capacity:
    storage: "120Gi"
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/ssd/pny250"
EOF

# Create Media PV
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: "ssd-pny250-1"
spec:
  persistentVolumeReclaimPolicy: Retain
  storageClassName: "ssd-pny250-1"
  capacity:
    storage: "1Gi"
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/mnt/ssd/pny250"
EOF

# Create Media PVC
# cat <<EOF | kubectl apply -f -
# ---
# apiVersion: v1
# kind: PersistentVolumeClaim
# metadata:
#   namespace: "plex"
#   name: "plex-ssd"
# spec:
#   storageClassName: "media-ssd"
#   accessModes:
#     - ReadWriteMany
#   resources:
#     requests:
#       storage: "200Gi"
# EOF
