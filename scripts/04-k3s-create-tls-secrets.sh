#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

domains=(
  "petname.ga"
)

for domain in "${domains[@]}"; do
  echo "Creating TLS secret for $domain"
  kubectl create secret tls ${domain}-tls \
    --cert=${SCRIPT_DIR}/../secrets/$domain/tls.cert \
    --key=${SCRIPT_DIR}/../secrets/$domain/tls.key \
    --namespace ingress-nginx
done
