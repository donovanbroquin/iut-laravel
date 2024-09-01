resource "hcloud_server" "main" {
  name        = "main"
  image       = "ubuntu-24.04"
  server_type = "cx22"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}