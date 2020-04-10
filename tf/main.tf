module "gke" {
  source = "./modules/gke"

  name       = var.name
  location   = var.location
  project    = var.project
  network    = var.network
  subnetwork = var.subnetwork

  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
  primary_np_node_count                  = var.primary_np_node_count

}
