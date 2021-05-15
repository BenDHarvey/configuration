resource "github_user_ssh_key" "benharvey_ssh_key" {
  title = "personal_key"
  key   = var.public_key
}

resource "github_user_ssh_key" "deploy_ssh_key" {
  title = "deploy_key"
  key   = var.deploy_public_key
}
