resource "yandex_kubernetes_cluster" "this" {
  name       = "${var.name_prefix}-cluster"
  network_id = yandex_vpc_network.this.id
  master {
    version = var.k8s_version
    regional {
      region = "ru-central1"

      dynamic "location" {
        for_each = yandex_vpc_subnet.this
        content {
          zone      = location.value.zone
          subnet_id = location.value.id
        }
      }
    }
    security_group_ids = [yandex_vpc_security_group.this.id]
  }
  service_account_id      = yandex_iam_service_account.this.id
  node_service_account_id = yandex_iam_service_account.this.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.viewer
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.this.id
  }
}

resource "yandex_kubernetes_node_group" "this" {
  cluster_id = yandex_kubernetes_cluster.this.id
  name       = "${var.name_prefix}-nodes"

  instance_template {
    name       = "node{instance.index}"
    platform_id = "standard-v3"
    container_runtime {
     type = "containerd"
    }
    resources {
      memory = var.k8s_resources.mem
      cores  = var.k8s_resources.cpu
    }
    boot_disk {
      type = "network-hdd"
      size = var.k8s_resources.disk
    }
  }

  allocation_policy {
    dynamic "location" {
      for_each = yandex_vpc_subnet.this
      content {
        zone      = location.value.zone
        subnet_id = location.value.id
      }
    }
  }

  scale_policy {
    fixed_scale {
      size = var.k8s_nodes
    }
  }
}