resource "ovh_domain_zone_record" "iut_ipv4" {
  zone      = var.dns_zone
  subdomain = "iut"
  fieldtype = "A"
  ttl       = 300
  target    = hcloud_server.main.ipv4_address
}

resource "ovh_domain_zone_record" "iut_ipv6" {
  zone      = var.dns_zone
  subdomain = "iut"
  fieldtype = "AAAA"
  ttl       = 300
  target    = hcloud_server.main.ipv6_address
}

resource "ovh_domain_zone_record" "nginx_ipv4" {
  zone      = var.dns_zone
  subdomain = "nginx"
  fieldtype = "A"
  ttl       = 300
  target    = hcloud_server.main.ipv4_address
}

resource "ovh_domain_zone_record" "nginx_ipv6" {
  zone      = var.dns_zone
  subdomain = "nginx"
  fieldtype = "AAAA"
  ttl       = 300
  target    = hcloud_server.main.ipv6_address
}