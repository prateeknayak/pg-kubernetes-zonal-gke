locals {
  certs_script   = <<EOT
./certs.sh
  EOT
  init_istio_pki = <<EOT
./init-istio-pki.sh
  EOT
}

resource "null_resource" "create_local_pki" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.certs_script
  }

  triggers = {
    script = local.certs_script
  }
}

resource "null_resource" "apply_istio_pki_to_cluster" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.init_istio_pki
  }

  triggers = {
    script = local.init_istio_pki
  }
}
