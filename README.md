# Terraform Azure Key Vault
A terraform module to creating and configuring keyvault and secrets


## Basic Usage
```hcl
module "key_vault" {
  source              = "."
  name                = "key-vault-${random_string.username.result}"
  resource_group_name = module.resource_group.name
  location            = var.location

  soft_delete_enabled         = true
  purge_protection_enabled    = false
  enabled_for_disk_encryption = true

  sku_name = var.key_vault_sku_name

  # User Permissions
  key_permissions     = var.key_vault_key_permissions
  secret_permissions  = var.key_vault_secret_permissions
  storage_permissions = var.key_vault_storage_permissions

  # Admin Permissions - Terraform
  admin_key_permissions     = var.key_vault_admin_key_permissions
  admin_secret_permissions  = var.key_vault_admin_secret_permissions
  admin_storage_permissions = var.key_vault_admin_storage_permissions

  network_acls_default_action = var.key_vault_network_acls_default_action
  network_acls_bypass         = var.key_vault_network_acls_bypass

  users = var.key_vault_access_policy_users

  # secrets = var.key_vault_secrets
  secrets = local.key_vault_secrets

  tags = local.common_tags
}

```

## Doc generation

Code formatting and documentation for variables and outputs is generated using [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) which uses [terraform-docs](https://github.com/segmentio/terraform-docs).

Follow [these instructions](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) to install pre-commit locally.

And install `terraform-docs` with
```bash
go get github.com/segmentio/terraform-docs
```
or
```bash
brew install terraform-docs.
```

## Contributing

Report issues/questions/feature requests on in the issues section.

Full contributing guidelines are covered [here](CONTRIBUTING.md).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_key\_permissions | List of key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list` | <pre>[<br>  "backup",<br>  "create",<br>  "decrypt",<br>  "delete",<br>  "encrypt",<br>  "get",<br>  "import",<br>  "list",<br>  "purge",<br>  "recover",<br>  "restore",<br>  "sign",<br>  "unwrapKey",<br>  "update",<br>  "verify",<br>  "wrapKey"<br>]</pre> | no |
| admin\_secret\_permissions | List of secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set | `list(string)` | <pre>[<br>  "backup",<br>  "delete",<br>  "get",<br>  "list",<br>  "purge",<br>  "recover",<br>  "restore",<br>  "set"<br>]</pre> | no |
| admin\_storage\_permissions | List of storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update. | `list(string)` | <pre>[<br>  "backup",<br>  "deleteas",<br>  "delete",<br>  "getas",<br>  "get",<br>  "listas",<br>  "list",<br>  "purge",<br>  "recover",<br>  "restore",<br>  "regeneratekey",<br>  "set",<br>  "setas",<br>  "update"<br>]</pre> | no |
| enabled\_for\_disk\_encryption | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false | `bool` | `null` | no |
| location | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| name | Specifies the name of the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| network\_acls\_bypass | Specifies which traffic can bypass the network rules. Possible values are AzureServices and None. | `string` | `null` | no |
| network\_acls\_default\_action | The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. Possible values are Allow and Deny. | `string` | `"Deny"` | no |
| network\_acls\_ip\_rules | (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault. | `list(string)` | `null` | no |
| network\_acls\_subnet\_ids | (Optional) One or more Subnet ID's which should be able to access this Key Vault. | `list(string)` | `null` | no |
| purge\_protection\_enabled | Is Purge Protection enabled for this Key Vault? Defaults to false | `bool` | `null` | no |
| resource\_group\_name | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| secrets | List of secrets for be created | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |
| sku\_name | The Name of the SKU used for this Key Vault. Possible values are standard and premium | `string` | `"standard"` | no |
| tags | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| user\_key\_permissions | List of key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list` | <pre>[<br>  "list",<br>  "get",<br>  "decrypt",<br>  "unwrapKey"<br>]</pre> | no |
| user\_secret\_permissions | List of secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set | `list` | <pre>[<br>  "list",<br>  "get"<br>]</pre> | no |
| user\_storage\_permissions | List of storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update. | `list` | <pre>[<br>  "list",<br>  "get",<br>  "listas",<br>  "getsas"<br>]</pre> | no |
| users | Object IDs of Users that will have access to the key vault | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| vault\_uri | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
