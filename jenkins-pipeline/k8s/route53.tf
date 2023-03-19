locals {
  defaults = ["tuyojr.me", "notes-app", "sock-shop"]
}

resource "aws_route53_zone" "domain" {
  name = local.defaults[0]

  tags = {
    Name = local.defaults[0]
  }
}

resource "aws_route53_record" "domain-route1" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "${local.defaults[1]}.${local.defaults[0]}"
  type    = "CNAME"
  ttl     = "300" 

  records = ["a6c642af84fe448ed8922bb175e5b126-1272802884.us-east-1.elb.amazonaws.com"]
}

resource "aws_route53_record" "domain-route2" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "${local.defaults[2]}.${local.defaults[0]}"
  type    = "CNAME"
  ttl     = "300" 

  records = ["afb1a32638588498a9842b32ca704756-1090645815.us-east-1.elb.amazonaws.com"]
}