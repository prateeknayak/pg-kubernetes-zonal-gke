## GKE Zonal Cluster

In this playground repo we attempt to create three clusters within `australia-southeast1` region one for each zone. We then will build out service mesh in each cluster which is seeded using same CA generated by the pki script. Once the cluster is stood up and istio is bootstrapped we will then deploy the `microservices-demo` app to these clusters. The end goal will be to leverage a combination of global load balancing on google and Traffic director to route traffic to appropriate service.

#### Pre-requisites
- GCP account with Billing activated
- GKE and other necessary APIs enabled
- Credentials to provision the required infra with following perms
    - Kubernetes Engine Admin
    - Service Account Admin
    - Service Account User
    - Compute Viewer
    - Project IAM
- Existing VPC with subnets to create GKE clusters in (todo: add network module)
- Tools:
    - terraform
    - gcloud sdk
    - kubectl
    - istioctl

### Steps to stand this up

1. Set the required env vars
    - export PROJECT=<your-project>
    - export CREDS=<absolute-path-to-your-creds-file.json>

