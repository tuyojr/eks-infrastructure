locals {
  defaults = ["tuyojr.me", "notes-app.tuyojr.me", "sock-shop.tuyojr.me"]
}

resource "aws_route53_zone" "domain" {
  name = local.defaults[0]

  tags = {
    Name = local.defaults[0]
  }
}

# resource "aws_route53_record" "sub-domain-1" {
#   zone_id = aws_route53_zone.domain.zone_id
#   name    = local.defaults[1]
#   type    = "A"

#   records = ["${kubernetes_service.notes-app.status.0.load_balancer.0.ingress[0].ip}"]
# }

# resource "aws_route53_record" "sub-domain-2" {
#   zone_id = aws_route53_zone.domain.zone_id
#   name    = local.defaults[2]
#   type    = "A"

#   records = ["${kubernetes_service.front-end.status.0.load_balancer.0.ingress[0].ip}"]
# }