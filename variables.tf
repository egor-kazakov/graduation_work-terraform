####################
# General settings
####################

variable "name_prefix" {
  type = string
  description = "Prefix name"
  default = "slurm"
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