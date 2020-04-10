########
## Mandatory Vars
########

variable "name" {
  type        = string
  description = "Name of the cluster"
  default     = "gke-zonal-test"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "australia-southeast1"
}

# variable "location" {
#   type        = string
#   description = "GCP zone"
#   default     = "australia-southeast1-a"
# }

variable "project" {
  type        = string
  description = "GCP project name where the cluster will be created"
}

variable "network" {
  type        = string
  description = "GCP network name where cluster will be created"
  default     = "default"
}

variable "subnetwork" {
  type        = string
  description = "GCP subnetwork name where cluster will be created"
  default     = "default"
}

variable "primary_np_node_count" {
  type        = string
  description = "Node count for primary node pool"
  default     = "1"
}

variable "creds" {
  type        = string
  description = "Credential file for gcp service account"
  default     = "creds.json"
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


