terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "=1.16.0"
    }
  }
}

variable "LINODE_TOKEN" {
  type        = string
  description = "The linode api token required to make calls to linode api"
}

provider "linode" {
  token = var.LINODE_TOKEN
}

resource "linode_lke_cluster" "control_cluster" {
  label       = "control"
  k8s_version = "1.20"
  region      = "ap-southeast"

  pool {
    type  = "g6-standard-1"
    count = 1
  }
}
