#! /bin/bash

# since we haven't seeded istio yet
kubectl create namespace istio-system
kubectl create secret generic cacerts -n istio-system \
    --from-file=.pki/ca-cert.pem \
    --from-file=.pki/ca-key.pem \
    --from-file=.pki/root-cert.pem \
    --from-file=.pki/cert-chain.pem
