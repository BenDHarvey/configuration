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

resource "github_repository" "personal-blog" {
  name        = "blog"
  description = "My personal blog where I write things down"

  visibility = "private"
}

resource "github_repository" "bloomsprout_blog" {
  name        = "bloomsprout-blog"
  description = "The blog for the bloomsprout project"

  visibility = "public"
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

resource "github_repository" "bloomsprout_metric_consumer" {
  name        = "bloomsprout-metric-consumer"
  description = "Project for the consumer of metrics coming from the bloomsprout project"

  visibility = "public"
}

resource "github_repository" "comment-generator" {
  name        = "comment-generator"
  description = "The comment generator project"

  visibility = "private"
}

resource "github_repository" "switchdin_django_orchestrator" {
  name        = "switchdin-django-orchestrator"
  description = "A collection of docker files and scripts that can run the switchdin djano project"

  visibility = "private"
}

resource "github_repository" "infrastructure" {
  name        = "infrastructure"
  description = "A repo that contains all code dealing with server and infra for my personal environment. Largely a collection of terraform and ansible scripts with some k8s config as well"

  visibility = "private"
}
