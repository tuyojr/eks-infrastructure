locals {
  defaults = ["tuyojr.me", "notes-app.tuyojr.me", "sock-shop.tuyojr.me"]
}

resource "aws_route53_zone" "domain" {
  name = local.defaults[0]

  tags = {
    Name = local.defaults[0]
  }
}

resource "aws_route53_record" "sub-domain-1" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = local.defaults[1]
  type    = "A"
  ttl     = "300" 

  records = ["a58001c47e5694136b099ac5511110c9-185002891.us-east-1.elb.amazonaws.com"]
}

resource "aws_route53_record" "sub-domain-2" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = local.defaults[2]
  type    = "A"
  ttl     = "300"

  records = ["a8f4bbcf797914a53adb1a0c8838140a-502033186.us-east-1.elb.amazonaws.com"]
}