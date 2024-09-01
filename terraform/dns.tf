resource "ovh_domain_zone_record" "ipv4" {
  for_each  = toset(var.subdomains)
  
  zone      = var.dns_zone
  subdomain = each.value
  fieldtype = "A"
  ttl       = 300
  target    = hcloud_server.main.ipv4_address
}

resource "ovh_domain_zone_record" "ipv6" {
  for_each  = toset(var.subdomains)
  
  zone      = var.dns_zone
  subdomain = each.value
  fieldtype = "AAAA"
  ttl       = 300
  target    = hcloud_server.main.ipv6_address
}