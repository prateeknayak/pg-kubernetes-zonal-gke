#!/bin/bash

set -e

gcloud container clusters get-credentials ${CLUSTER} --project ${PROJECT} --zone ${ZONE}

# since we haven't seeded istio yet
kubectl create namespace istio-system
kubectl create secret generic cacerts -n istio-system \
    --from-file=.pki/ca-cert.pem \
    --from-file=.pki/ca-key.pem \
    --from-file=.pki/root-cert.pem \
    --from-file=.pki/cert-chain.pem

istioctl init
sleep 5
istioctl manifest apply -f sm/istio-cp.yaml
