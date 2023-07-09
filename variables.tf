####################
# General settings
####################

variable "name_prefix" {
  type = string
  description = "Prefix name"
  default = "k8s"
}

variable "YC_FOLDER_ID" {
  type = string
  description = "Needed TF_VAR_YC_FOLDER_ID for Service account"
}

####################
# Network settings
####################

variable "cidr_blocks" {
  type = list(list(string))
  description = "cidr subnet"
  default = [
    ["10.10.0.0/24"],
    ["10.20.0.0/24"],
    ["10.30.0.0/24"]
  ]
}

variable zone {
  type = list(string)
  description = "Zones"
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
  ]
}

####################
# K8s settings
####################

variable "k8s_version" {
  type = string
  description = "Version kubernetes"
  default = "1.24"
}

variable "k8s_nodes" {
  type = number
  description = "Count nodes k8s cluster"
  default = 3
}

variable "k8s_resources" {
  type = object({
    fraction = number
    cpu      = number
    mem      = number
    disk     = number
  })
  description = "Hardware resources for nodes k8s cluster"
  default = ({
    core_fraction = 5
    cpu           = 2
    mem           = 2
    disk          = 64
  })
}
