##########
# Конфигурационный файл сервисного аккаунта.
# Создает сервисный аккаунт и назначает роли:
#   - editor
#   - container-registry.images.puller
##########

resource "yandex_iam_service_account" "this" {
  name        = "sa"
  description = "Service account fo management k8s cluster"
  folder_id   = var.YC_FOLDER_ID
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  # Сервисному аккаунту назначается роль "editor".
  folder_id = var.YC_FOLDER_ID
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.YC_FOLDER_ID
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}