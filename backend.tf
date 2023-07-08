terraform {
  backend "http" {
    address = "https://s053278.gitlab.yandexcloud.net/api/v4/projects/3/terraform/state/tfstate"
    lock_address = "https://s053278.gitlab.yandexcloud.net/api/v4/projects/3/terraform/state/tfstate/lock"
    username = "s053278"
    password = "f9607592"
    lock_method = "POST"
    unlock_method = "DELETE"
  }
}