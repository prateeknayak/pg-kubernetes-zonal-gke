data "google_container_engine_versions" "location" {
  location = var.location
  project  = var.project
}

locals {
  latest_version     = data.google_container_engine_versions.location.latest_master_version
  kubernetes_version = var.kubernetes_version != "latest" ? var.kubernetes_version : local.latest_version
  all_service_account_roles = concat([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ])
}

resource "google_container_cluster" "primary" {
  name        = var.name
  location    = var.location
  description = var.description
  project     = var.project
  network     = var.network
  subnetwork  = var.subnetwork

  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service
  min_master_version = local.kubernetes_version

  # Remove default node-pool
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_cidr_blocks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  lifecycle {
    ignore_changes = [
      node_config,
    ]
  }
  node_config {
    service_account = google_service_account.service_account.email
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  depends_on = [google_service_account.service_account]
}

resource "google_container_node_pool" "primary_pool" {
  name       = "${google_container_cluster.primary.name}-primary-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = var.primary_np_node_count

  node_config {
    machine_type = "n1-standard-2"
    image_type   = "COS"
    preemptible  = true
    tags         = ["test-only"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloudkms",
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      foo = "bar"
    }

    service_account = google_service_account.service_account.email
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_service_account" "service_account" {
  project      = var.project
  account_id   = var.name
  display_name = var.description
}


resource "google_project_iam_member" "service_account-roles" {
  for_each = toset(local.all_service_account_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
