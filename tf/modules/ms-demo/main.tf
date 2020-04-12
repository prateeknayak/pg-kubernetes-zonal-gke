resource "null_resource" "deploy-ms" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    command     = "./bin/deploy-microservices.sh"
    environment = {
      CLUSTER = var.cluster_name
      PROJECT = var.project
      ZONE    = var.zone
    }
  }
}
