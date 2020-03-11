###### IMPORTANT NOTE ######
# After the Key Vault has been created you will need to enable soft delete via powershell
#
# ($resource = Get-AzResource -ResourceId (Get-AzKeyVault -VaultName "LOC-ENV-KVLT01").ResourceId).Properties | Add-Member -MemberType "NoteProperty" -Name "enableSoftDelete" -Value "true"
# Set-AzResource -resourceid $resource.ResourceId -Properties $resource.Properties
#
# Support to do this through Terraform will be added to the the AzureRM 2.0 Provider update.


resource "azurerm_key_vault" "keyvault" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.mgmt_rsg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }

  access_policy {
    tenant_id          = var.tenant_id
    object_id          = var.kv_backup_id
    key_permissions    = ["get", "list", "backup"]
    secret_permissions = ["get", "list", "backup"]
  }

  sku {
    name = var.kv_sku
  }
}

output "vault_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}

