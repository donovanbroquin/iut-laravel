resource "hcloud_server" "main" {
  name         = "main"
  image        = "ubuntu-24.04"
  server_type  = "cx22"
  datacenter   = "nbg1-dc3"
  ssh_keys     = [hcloud_ssh_key.ssh_key.id]
  firewall_ids = [hcloud_firewall.main.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  user_data = <<-EOF
    #cloud-config
    users:
      - name: iut
        ssh-authorized-keys:
          - ${var.ssh_key}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        groups: sudo

    ssh_pwauth: false
    disable_root: true

    runcmd:
      - sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
      - systemctl reload sshd
    EOF
}