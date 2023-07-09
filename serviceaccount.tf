##########
# Конфигурационный файл сервисного аккаунта.
# Создает сервисный аккаунт и назначает роли:
#   - editor
#   - k8s-clusters-agent
#   - vpc-public-admin
#   - container-registry.images.puller
#   - viewer
##########

resource "yandex_iam_service_account" "this" {
  name        = "${var.name_prefix}-sa"
  description = "Service account fo management k8s cluster"
  folder_id   = var.YC_FOLDER_ID
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  # Сервисному аккаунту назначается роль "editor".
  folder_id = var.YC_FOLDER_ID
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = local.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.YC_FOLDER_ID
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.YC_FOLDER_ID
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "viewer" {
  folder_id = var.YC_FOLDER_ID
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}