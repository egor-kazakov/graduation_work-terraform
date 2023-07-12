# Terraform

## Задача

Необходимо построить инфраструктуру в облаке Yandex Cloud, настроить управление инфраструктурой через Terraform и развернуть приложение из репозитория.

## Описание проекта

**Описание:** Управление инфраструктурой проекта через Terraform (*IaC*). Хранит состояние в *Gitlab Terraform State*

**Содержимое:**
  * `providers.tf` - настройка провайдера облака (*Yandex Cloud*)
  * `backend.tf` - настройка хранения *Terraform State*
  * `networks.tf` - настройка сети и подсетей
  * `kubernetes.tf` - настройка кластера *Kubernetes*
  * `serviceaccount.tf` - настройка сервисного аккаунта и ролей
  * `kmsprovider.tf` - настройка симметричного ключа
  * `database.tf` - настройка кластера *PostgreSQL*
  * `variables.tf` - хранение переменных проекта

## Подготовка

> **ВАЖНО!** Действия выполняются только при локальном запуске

### Установка дистрибутивов

Для работы необходимо:
 1. Yandex Cloud CLI
 1. Terraform
 1. Kubectl

 Для установки **Yandex Cloud CLI** воспользуйтесь командой (согласно [инструкции](https://cloud.yandex.ru/docs/cli/quickstart#install)):
 ```
 curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
 ```

Инструкция по установке [**Terraform**](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform)

> *Зеркала на территории РФ недоступны (11.06.2023). Используйте VPN*

### Настройка доступа к облаку

> Для проекта уже настроены переменные окружения в **Settings - CI/CD - Variables**.
> Действия выполняются только при локальном запуске

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

### Импорт Terraform State

Для импорта `tfstate` авторизуйтесь в **Gitlab**, откройте проект **Terraform** и перейдите во вкладку **Infrastructure - Terraform**.

Скачайте `tfstate` и поместите его в локальный проект.

Удалите `backend.tf`, т.к. для локального использования он не потребуется.

### Применение конфигурации

Перейдите в директорию **Terraform**:
```
cd terraform
```

Проинициализируйте проект **Terraform**:
```
terraform init
```

Примените конфигурацию:
```
terraform apply
```
> Используйте аттрибуты **-var** или **-var-file** чтобы изменить параметры

### Удаление конфигурации
> В связи с тем, что это тестовый стенд с конечным граном (3000 руб. + 1000 руб.), рекомендуется удаление стенда.
Удалите созданную инфраструктуру:
```
terraform destroy
```

Удалите образы, созданные *Packer*:
```
yc compute image delete nginx-1
```