########
## Mandatory Vars
########

variable "project" {
  type        = string
  description = "GCP project name where the cluster will be created"
}

variable "service_account" {
  type        = string
  description = "Service account for the nodepools"

}

########
## Optional Vars
########

variable "region" {
  type        = string
  description = "GCP region where the clusters will be created"
  default     = "austraila-southeast1"
}

variable "location" {
  type        = string
  description = "GCP zone"
  default     = "australia-southeast1-a"
}

variable "creds" {
  type        = string
  description = "Credential file for gcp service account"
  default     = "creds.json"
}

variable "gke_cluster_name_prefix" {
  type        = string
  description = "Name of the cluster"
  default     = "gke-zonal-test"
}

########
## Data Vars
########

data "google_container_engine_versions" "location" {
  location = var.location
  project  = var.project
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(map(string))

  default = [
    {

      cidr_block   = "0.0.0.0/0"
      display_name = "faark"
    },
  ]

  description = "auth networks"
}
