#!/bin/bash

msdemodir="microservices-demo"

if [ "$(ls -A $msdemodir)" ]; then
     echo "msdemodir directory already cloned"
else
    git clone https://github.com/GoogleCloudPlatform/microservices-demo.git
fi

for x in a
do
    cluster=$(terraform output cluster-${x})
    project=$(terraform output project)
    zone=$(terraform output zone-${x})
    context="gke_${project}_${zone}_${cluster}"

    kubectl config use-context ${context}
    kubectl get namespce microservices-demo
    retVal=$?
    if [ $retVal -ne 0 ]; then
        echo "microservices-demo doesn't exist"
        kubectl create namespace microservices-demo
    fi
    kubectl label namespace microservices-demo istio-injection=enabled
    kubectl -n microservices-demo apply -f ./microservices-demo/release/kubernetes-manifests.yaml
    kubectl -n microservices-demo apply -f ./microservices-demo/release/istio-manifests.yaml

done
