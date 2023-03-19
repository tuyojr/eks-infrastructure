locals {
  defaults = ["tuyojr.me"]
}

resource "aws_route53_zone" "domain" {
  name = local.defaults[0]

  tags = {
    Name = local.defaults[0]
  }
}

resource "aws_route53_record" "domain-route" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = local.defaults[0]
  type    = "CNAME"
  ttl     = "300" 

  records = ["a6949aa5f63174f25999351969d804be-114438520.us-east-1.elb.amazonaws.com"]
}