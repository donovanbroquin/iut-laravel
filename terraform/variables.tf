variable "ssh_key" {
  type      = string
  sensitive = true
}

variable "private_ipv4" {
  type      = string
  sensitive = true
}

variable "private_ipv6" {
  type      = string
  sensitive = true
}

variable "dns_zone" {
  type      = string
  sensitive = false
}