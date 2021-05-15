terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.5.2"
    }
  }
}

variable "github_token" {}
variable "public_key" {}
variable "delpoy_public_key" {}

provider "github" {
  token = var.github_token
}
