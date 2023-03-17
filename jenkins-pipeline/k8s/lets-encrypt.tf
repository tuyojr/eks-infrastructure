resource "tls_private_key" "reg_private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.reg_private_key.private_key_pem
  email_address   = var.email_addr
}

resource "tls_private_key" "cert_private_key" {
  algorithm = "RSA"
}

resource "tls_cert_request" "tuyojr-certifcate" {
  private_key_pem = tls_private_key.cert_private_key.private_key_pem
  dns_names       = [local.defaults[1], local.defaults[2]]

  subject {
    common_name = local.defaults[0]
  }
}

resource "acme_certificate" "tuyojr-cert" {
  account_key_pem         = tls_private_key.reg_private_key.public_key_pem
  certificate_request_pem = tls_cert_request.tuyojr-certifcate.cert_request_pem

  dns_challenge {
    provider = "route53"
  }
}