terraform {
  backend "http" {
    address = "https://s053278.gitlab.yandexcloud.net/api/v4/projects/3/terraform/state/tfstate"
    lock_address = "https://s053278.gitlab.yandexcloud.net/api/v4/projects/3/terraform/state/tfstate/lock"
    unlock_address = "https://s053278.gitlab.yandexcloud.net/api/v4/projects/3/terraform/state/tfstate/lock"
    username = "test"
    password = "glpat-yRdZNGKq9hv6xbAm4LJN"
    lock_method = "POST"
    unlock_method = "DELETE"
    retry_wait_min= "5"
  }
}