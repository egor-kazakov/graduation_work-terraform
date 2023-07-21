##########
# Конфигурационный файл сети.
# Описаны сеть и подсети в каждой зоне доступности,
# создает DNS-зону для управления DNS-записями.
#
# Для работы необходимо настроить у провайдера домена делегирование:
#   - ns1.yandexcloud.net
#   - ns2.yandexcloud.net
##########

resource "yandex_vpc_network" "this" {
  name = "${var.name_prefix}-network"
}

resource "yandex_vpc_subnet" "this" {
  count = length(var.zone)

  name           = "${var.name_prefix}-${var.zone[count.index]}"
  zone           = var.zone[count.index]
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.cidr_blocks[count.index]
}

resource "yandex_dns_zone" "this" {
  name        = replace(var.dns_name, ".", "-")
  description = "Public zone"

  zone    = "${var.dns_name}."
  public  = true
}
