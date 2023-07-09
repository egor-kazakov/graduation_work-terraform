##########
# Конфигурационный файл KMS.
# Создает симметричный ключ шифрования для секретной информации.
##########

resource "yandex_kms_symmetric_key" "this" {
  # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = "${var.name_prefix}-kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}