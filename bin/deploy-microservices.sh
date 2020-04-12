#!/bin/bash

set -e

msdemodir="microservices-demo"

if [ "$(ls -A $msdemodir)" ]; then
     echo "msdemodir directory already cloned"
else
    git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
fi


kubectl config use-context "gke_${PROJECT}_${ZONE}_${CLUSTER}"

# since we haven't seeded istio yet
kubectl apply -f ./microservices-demo/release/kubernetes-manifests.yaml
kubectl apply -f ./microservices-demo/release/istio-manifests.yaml
