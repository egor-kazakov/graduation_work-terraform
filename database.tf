resource "yandex_mdb_postgresql_cluster" "this" {
  name                = "${var.name_prefix}-psql-cluster"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.this.id

  config {
    version = var.psql_version
    resources {
      resource_preset_id = var.psql_resurce_preset_id
      disk_type_id       = var.psql_storage.type
      disk_size          = var.psql_storage.size
    }
    pooler_config {
      pool_discard = true
      pooling_mode = "SESSION"
    }
  }
  dynamic "host" {
    for_each = var.zone

    content {
        zone      = host.value
        name      = "psql-${host.value}"
        subnet_id = yandex_vpc_subnet.this[index(var.zone, host.value)].id
    }
  }
}

resource "yandex_mdb_postgresql_database" "this" {
  cluster_id = yandex_mdb_postgresql_cluster.this.id
  name       = "${var.name_prefix}-psql-database"
  owner      = var.psql_user
  depends_on = [
    yandex_mdb_postgresql_user.this
  ]
}

resource "yandex_mdb_postgresql_user" "this" {
  cluster_id = yandex_mdb_postgresql_cluster.this.id
  name       = var.psql_user
  password   = var.psql_password
}