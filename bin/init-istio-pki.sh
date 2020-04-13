#!/bin/bash

for x in a b c
do
    # generate kubeconfig for the cluster
    echo "get credentials"
    cluster=$(terraform output cluster-${x})
    project=$(terraform output project)
    zone=$(terraform output zone-${x})

    echo $cluster
    echo $project
    echo $zone
    gcloud container clusters get-credentials $cluster --zone $zone --project $project

    # seeding istio-namespace with CA secret so that intermesh mTLS can work
    ${dcr} kubectl get namespace istio-system > /dev/null 2> /dev/null
    retVal=$?
    if [ $retVal -ne 0 ]; then
    echo "istio-system doesn't exist"
    ${dcr} kubectl create namespace istio-system
    fi

    ${dcr} kubectl create secret generic cacerts -n istio-system \
    --from-file=.pki/ca-cert.pem \
    --from-file=.pki/ca-key.pem \
    --from-file=.pki/root-cert.pem \
    --from-file=.pki/cert-chain.pem

    # initialise the istio operator
    istioctl operator init

    # not sure if this sleep is required
    # Observed some racy behaviour given the IO crd is not persisted in cluster
    sleep 5

    # Apply the IO crd with demo profile
    istioctl manifest apply -f sm/istio-cp.yaml
done





