##########
# Конфигурационный файл-заглушка для работы с удаленным tfstate в проекте GitLab.
#
# Данные передаются как переменные окружения при работе 
# контейнера registry.gitlab.com/gitlab-org/terraform-images/stable:latest
#
# Для применения конфигурации используется команда: gitlab-terraform
# TF_ADDRESS=${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/terraform/state/yc-tfstate
##########

terraform {
  backend "http" {
  }
}