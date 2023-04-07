#!/bin/bash

kubectl create secret docker-registry ghcr-seemywingz-pull \
  --docker-server=ghcr.io \
  --docker-username=seemywingz \
  --docker-password=${GITHUB_PAT}
