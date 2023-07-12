resource "yandex_mdb_postgresql_cluster" "this" {
  name                = "${var.name_prefix}-psql-cluster"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.this.id

  config {
    version = var.psql_version
    resources {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "network-hdd"
      disk_size          = 20
    }
    pooler_config {
      pool_discard = true
      pooling_mode = "SESSION"
    }
  }

  host {
    zone      = "ru-central1-a"
    name      = "psql-central1-a"
    subnet_id = yandex_vpc_subnet.this[0].id
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