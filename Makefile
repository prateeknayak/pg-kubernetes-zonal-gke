dcr=docker-compose run --rm

tf-plan-gke-cluster:
	$(dcr) terraform init tf
	$(dcr) terraform plan \
	 -var 'project=$(PROJECT)' \
	 -var creds=${CREDS} \
	 -out=zonal-test tf

tf-create-gke-cluster: tf-plan-gke-cluster
	$(dcr) terraform apply "zonal-test"

gcloud-get-creds:
	 gcloud container clusters get-credentials gke-zonal-test --project $(PROJECT) --zone australia-southeast1-a

tf-destroy-gke-cluster:
	$(dcr) terraform destroy \
	 -var 'project=$(PROJECT)' \
	 -var creds=${CREDS} \
	 -auto-approve tf

cluster-admin-binding:
	kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(USER)
	kubectl cluster-info

istio-install:
	istioctl operator init
	istioctl manifest apply -f sm/istio-cp.yaml
