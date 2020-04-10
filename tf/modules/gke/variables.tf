
variable "name" {
  description = "The name of the cluster"
  type        = string
}

variable "description" {
  description = "The description of the cluster"
  type        = string
  default     = "GKE Cluster - zonal topology"
}

variable "location" {
  description = "The location (region or zone) to host the cluster in"
  type        = string
}

variable "project" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "network" {
  description = "A reference (self link) to the VPC network to host the cluster in"
  type        = string
}

variable "subnetwork" {
  description = "A reference (self link) to the subnetwork to host the cluster in"
  type        = string
}

variable "logging_service" {
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com/kubernetes, logging.googleapis.com (legacy), and none"
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Stackdriver Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting. Available options include monitoring.googleapis.com/kubernetes, monitoring.googleapis.com (legacy), and none"
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "master_authorized_networks_cidr_blocks" {
  description = "List of cidr blocks"
  type        = list
}

variable "kubernetes_version" {
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region."
  type        = string
  default     = "latest"
}

variable "primary_np_node_count" {
  description = "node count for the primary nodepool"
  type        = string
  default     = 1
}
