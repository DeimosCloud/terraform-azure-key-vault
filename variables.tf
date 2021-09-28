variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
  default     = "standard"
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false"
  default     = null
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Is Purge Protection enabled for this Key Vault? Defaults to false"
  default     = null
}


variable "users" {
  description = "Object IDs of Users that will have access to the key vault"
  type = list(object({
    user_id = string
    admin   = bool
  }))
  default = []
}

# User permissions
variable "user_key_permissions" {
  type        = list(any)
  description = "List of key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default     = ["list", "get", "decrypt", "unwrapKey"]
}

variable "user_secret_permissions" {
  type        = list(any)
  description = "List of secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["list", "get"]
}

variable "user_storage_permissions" {
  type        = list(any)
  description = "List of storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update."
  default     = ["list", "get", "listas", "getsas"]
}

# Admin permission
variable "admin_key_permissions" {
  type        = list(any)
  description = "List of key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default     = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]

}

variable "admin_secret_permissions" {
  type        = list(string)
  description = "List of secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "admin_storage_permissions" {
  type        = list(string)
  description = "List of storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update."
  default     = ["backup", "deleteas", "delete", "getas", "get", "listas", "list", "purge", "recover", "restore", "regeneratekey", "set", "setas", "update"]
}

variable "network_acls_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  default     = "Deny"
}

variable "network_acls_bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  default     = null
}

variable "network_acls_ip_rules" {
  default     = null
  type        = list(string)
  description = "(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
}

variable "network_acls_subnet_ids" {
  default     = null
  type        = list(string)
  description = "(Optional) One or more Subnet ID's which should be able to access this Key Vault."
}

variable "secrets" {
  description = "List of secrets for be created"
  default     = {}
}
