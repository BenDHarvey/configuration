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

resource "github_repository" "bloomsprout_infrastructure" {
  name        = "bloomsprout-infrastructure"
  description = "Contains infrastructure code for the bloomsprout project"

  visibility = "public"
}

resource "github_repository" "bloomsprout_temperature_sensor" {
  name        = "bloomsprout-temperature-sensor"
  description = "Contains code for the temperatures sensor (DHT11)"

  visibility = "public"
}
