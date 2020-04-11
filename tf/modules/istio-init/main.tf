resource "null_resource" "create_local_pki" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    command     = "./bin/certs.sh"
  }
}

resource "null_resource" "apply_istio_pki_to_cluster" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    command     = "./bin/init-istio-pki.sh"
    environment = {
      CLUSTER = var.cluster_name
      PROJECT = var.project
    }
  }
}
