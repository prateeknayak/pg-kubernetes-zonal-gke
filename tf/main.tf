module "gke-zone-a" {
  source = "./modules/gke"

  name       = "${var.name}-zone-a"
  location   = "australia-southeast1-a"
  project    = var.project
  network    = "prateek-test"
  subnetwork = "subnet-a"

  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
  primary_np_node_count                  = var.primary_np_node_count
}

# module "install-istio-a" {
#   source       = "./modules/istio-init"
#   cluster_name = module.gke-zone-a.name
#   project      = module.gke-zone-a.project
#   zone         = module.gke-zone-a.location
# }


####################################################################################################################################################################

# module "gke-zone-b" {
#   source = "./modules/gke"

#   name       = "${var.name}-zone-b"
#   location   = "australia-southeast1-b"
#   project    = var.project
#   network    = "prateek-test"
#   subnetwork = "subnet-b"

#   master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
#   primary_np_node_count                  = var.primary_np_node_count
# }

# module "install-istio-b" {
#   source       = "./modules/istio-init"
#   cluster_name = module.gke-zone-b.name
#   project      = module.gke-zone-b.project
#   zone         = module.gke-zone-b.location

# }


####################################################################################################################################################################

# module "gke-zone-c" {
#   source = "./modules/gke"

#   name       = "${var.name}-zone-c"
#   location   = "australia-southeast1-c"
#   project    = var.project
#   network    = "prateek-test"
#   subnetwork = "subnet-c"

#   master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
#   primary_np_node_count                  = var.primary_np_node_count
# }

# module "install-istio-c" {
#   source       = "./modules/istio-init"
#   cluster_name = module.gke-zone-c.name
#   project      = module.gke-zone-c.project
#   zone         = module.gke-zone-c.location

# }
