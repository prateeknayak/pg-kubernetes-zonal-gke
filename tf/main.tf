module "gke-zone-a" {
  source = "./modules/gke"

  name       = "${var.name}-zone-a"
  location   = "australia-southeast1-a"
  project    = var.project
  network    = var.network
  subnetwork = var.subnetwork

  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
  primary_np_node_count                  = var.primary_np_node_count
}

module "install-istio" {
  source       = "./modules/istio-init"
  cluster_name = module.gke-zone-a.name
  project      = module.gke-zone-a.project
}


# module "gke-zone-b" {
#   source = "./modules/gke"

#   name       = "${var.name}-zone-b"
#   location   = "australia-southeast1-b"
#   project    = var.project
#   network    = var.network
#   subnetwork = var.subnetwork

#   master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
#   primary_np_node_count                  = var.primary_np_node_count
# }

# module "gke-zone-c" {
#   source = "./modules/gke"

#   name       = "${var.name}-zone-c"
#   location   = "australia-southeast1-c"
#   project    = var.project
#   network    = var.network
#   subnetwork = var.subnetwork

#   master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
#   primary_np_node_count                  = var.primary_np_node_count
# }
