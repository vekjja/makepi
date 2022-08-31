#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

publicWeb=(
  "kevinjayne.cloud"
  "petname.ga"
)

plex=(
  "kevinjayne.cloud"
)

for domain in "${publicWeb[@]}"; do
  echo "Creating TLS secrets for $domain"
  kubectl create secret tls ${domain}-tls \
    --key "${SCRIPT_DIR}/../secrets/${domain}/tls.key" \
    --cert "${SCRIPT_DIR}/../secrets/${domain}/tls.cert" \
    --namespace public-web
done

for domain in "${plex[@]}"; do
  echo "Creating TLS secrets for $domain"
  kubectl create secret tls ${domain}-tls \
    --key "${SCRIPT_DIR}/../secrets/${domain}/tls.key" \
    --cert "${SCRIPT_DIR}/../secrets/${domain}/tls.cert" \
    --namespace plex
done
