resource "github_repository" "configuration" {
  name        = "configuration"
  description = "configuration repo containing all personal configuration and dotfiles"

  visibility = "private"

}

resource "github_repository" "org" {
  name        = "org"
  description = "The repo that holds all the org files"

  visibility = "private"
}
