resource "github_repository" "configuration" {
  name        = "configuration"
  description = "configuration repo containing all personal configuration and dotfiles"

  visibility = "private"

}
