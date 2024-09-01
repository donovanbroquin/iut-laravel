# Create a new SSH key
resource "hcloud_ssh_key" "ssh_key" {
  name       = "iut-dijon"
  public_key = var.ssh_key
}