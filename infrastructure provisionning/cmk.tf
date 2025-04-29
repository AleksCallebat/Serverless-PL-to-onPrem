# resource "azurerm_key_vault" "databricks" {
#     provider                    = azurerm
#     name                        = "aleks-databricks-kv"
#     location                    = var.location
#     resource_group_name         = var.resource_group_name
#     sku_name                    = "standard"
#     tenant_id                   = var.tenant_id
    

#     network_acls {
#         bypass                     = "AzureServices"
#         default_action             = "Deny"
#         ip_rules                   = ["130.41.123.37"]
#         virtual_network_subnet_ids = []
#     }

   
# }
# data "azuread_client_config" "current" {}

# resource "azurerm_key_vault_access_policy" "current_identity" {
#     key_vault_id = azurerm_key_vault.databricks.id
#     tenant_id    = var.tenant_id
#     object_id    = data.azuread_client_config.current.object_id # Replace with a variable for the object ID

#     key_permissions = [
#         "Get", "List", "Create", "Update", "Import", "Delete", "Recover", "Backup", "Restore", "GetRotationPolicy", "SetRotationPolicy"
#     ]

#     secret_permissions = [
#         "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
#     ]

#     certificate_permissions = [
#         "Get", "List", "Create", "Update", "Delete", "Import", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers"
#     ]
# }


# resource "azurerm_key_vault_key" "databricks" {
#     name         = "databricks-key-aleks-2"
#     key_vault_id = azurerm_key_vault.databricks.id
#     key_type     = "RSA"
#     key_size     = 2048
#     key_opts  = ["decrypt", "encrypt", "sign", "verify"]
    
# }



# output "key_vault_id" {
#     value = azurerm_key_vault.databricks.id
# }