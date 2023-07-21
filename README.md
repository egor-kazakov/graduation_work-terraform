# Terraform

## Задача

Необходимо построить инфраструктуру в облаке Yandex Cloud, настроить управление инфраструктурой через Terraform и развернуть приложение из репозитория.

## Описание проекта

**Описание:** Управление инфраструктурой проекта через Terraform (*IaC*). Хранит состояние в *Gitlab Terraform State*

**Содержимое:**
  * `providers.tf` - настройка провайдера облака (*Yandex Cloud*)
  * `backend.tf` - настройка хранения *Terraform State*
  * `networks.tf` - настройка сети, подсетей и DNS-зоны
  * `kubernetes.tf` - настройка кластера *Kubernetes*
  * `serviceaccount.tf` - настройка сервисного аккаунта и ролей
  * `kmsprovider.tf` - настройка симметричного ключа
  * `database.tf` - настройка кластера *PostgreSQL*
  * `variables.tf` - хранение переменных проекта

## Настройка доступа к облаку

> Для установки **Yandex Cloud CLI** воспользуйтесь [инструкцией](https://cloud.yandex.ru/docs/cli/quickstart#install).

> Для проекта уже настроены переменные окружения в **Settings - CI/CD - Variables**.

Необходимо сначала проинициализировать **Yandex Cloud CLI** ([инструкция](https://cloud.yandex.ru/docs/cli/quickstart#initialize)):
```
yc init
```

После инициализации **Yandex Cloud CLI** экспортируйте переменные:
```
export YC_TOKEN=$(yc config get token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

# Фикс folder_id
export TF_VAR_YC_FOLDER_ID=$YC_FOLDER_ID
```
