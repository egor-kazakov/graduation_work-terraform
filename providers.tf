##########
# Конфигурационный файл провайдеров.
# Описаны необходимые версии terraform и подключаемых модулей.
#
# Учетные записи для подключения к облаку
# хранятся как переменные CI/CD Variables:
#   - YC_TOKEN
#   - YC_CLOUD_ID
#   - YC_FOLDER_ID
#   - TF_VAR_YC_FOLDER_ID
##########

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}