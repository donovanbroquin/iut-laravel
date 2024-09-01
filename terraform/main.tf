terraform {

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }

    ovh = {
      source = "ovh/ovh"
      version = "~> 0.48"
    }
  }
}