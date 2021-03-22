resource "github_user_ssh_key" "benharvey_ssh_key" {
  title = "personal_key"
  key   = var.public_key
}
