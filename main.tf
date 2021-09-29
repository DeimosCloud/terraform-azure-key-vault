data "azurerm_client_config" "current_client_config" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_key_vault" "key_vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current_client_config.tenant_id
  purge_protection_enabled    = var.purge_protection_enabled

  sku_name = var.sku_name

  # Access policy for service principal running the terraform script
  access_policy {
    tenant_id = data.azurerm_client_config.current_client_config.tenant_id
    object_id = data.azurerm_client_config.current_client_config.object_id

    key_permissions     = var.admin_key_permissions
    secret_permissions  = var.admin_secret_permissions
    storage_permissions = var.admin_storage_permissions
  }

  # access policy for defined users
  dynamic "access_policy" {

    for_each = var.users
    content {
      tenant_id = data.azurerm_client_config.current_client_config.tenant_id
      object_id = access_policy.value.user_id

      key_permissions     = access_policy.value.admin ? var.admin_key_permissions : var.user_key_permissions
      secret_permissions  = access_policy.value.admin ? var.admin_secret_permissions : var.user_secret_permissions
      storage_permissions = access_policy.value.admin ? var.admin_storage_permissions : var.user_storage_permissions
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls_bypass == null ? [] : ["acls"]

    content {
      default_action             = var.network_acls_default_action
      bypass                     = var.network_acls_bypass
      ip_rules                   = var.network_acls_ip_rules
      virtual_network_subnet_ids = var.network_acls_subnet_ids
    }
  }

  tags = var.tags
}

# KEY VAULT SECRETS

resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each     = var.secrets
  key_vault_id = azurerm_key_vault.key_vault.id
  name         = each.key
  value        = each.value

  tags = var.tags
}
