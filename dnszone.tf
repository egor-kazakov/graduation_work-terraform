##########
# Конфигурационный файл DNS-зоны.
# Создает DNS-зону для управления DNS-записями.
#
# Для работы необходимо настроить у провайдера домена делегирование:
#   - ns1.yandexcloud.net
#   - ns2.yandexcloud.net
##########

resource "yandex_cm_certificate" "this" {
  name    = replace(var.dns_name, ".", "-")
  domains = ["${var.dns_name}", "*.${var.dns_name}"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 1
  }
  depends_on = [ yandex_dns_zone.this ]
}

resource "yandex_dns_zone" "this" {
  name        = replace(var.dns_name, ".", "-")
  description = "Public zone"

  zone    = "${var.dns_name}."
  public  = true
}

resource "yandex_dns_recordset" "this" {
  count   = yandex_cm_certificate.this.managed[0].challenge_count
  zone_id = yandex_dns_zone.this.id
  name    = yandex_cm_certificate.this.challenges[count.index].dns_name
  type    = yandex_cm_certificate.this.challenges[count.index].dns_type
  data    = [yandex_cm_certificate.this.challenges[count.index].dns_value]
  ttl     = 60
}