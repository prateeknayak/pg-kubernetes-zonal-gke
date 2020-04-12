
output "cluster-a" {
  value = module.gke-zone-a.name
}

output "zone-a" {
  value = module.gke-zone-a.location
}

output "cluster-b" {
  value = module.gke-zone-b.name
}

output "zone-b" {
  value = module.gke-zone-b.location
}

output "cluster-c" {
  value = module.gke-zone-c.name
}

output "zone-c" {
  value = module.gke-zone-c.location
}

output "project" {
  value = module.gke-zone-a.project
}
