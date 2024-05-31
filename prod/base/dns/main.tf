locals {
  custom_domain_name = "jordibru.cloud"

  NS_values = [
    "ns-1583.awsdns-05.co.uk.",
    "ns-81.awsdns-10.com.",
    "ns-542.awsdns-03.net.",
    "ns-1515.awsdns-61.org."
  ]

  SOA_values = [
    "ns-1583.awsdns-05.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
}

resource "aws_route53_zone" "primary" {
  name          = local.custom_domain_name
  force_destroy = false

  tags = {
    Terraform = var.terraform
    Owner     = var.owner
    Stage     = var.stage
  }
}

resource "aws_route53_record" "custom_NS" {
  allow_overwrite = true
  name            = local.custom_domain_name
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.primary.zone_id

  records = local.NS_values
}

resource "aws_route53_record" "custom_SOA" {
  allow_overwrite = true
  name            = local.custom_domain_name
  ttl             = 900
  type            = "SOA"
  zone_id         = aws_route53_zone.primary.zone_id

  records = local.SOA_values
}