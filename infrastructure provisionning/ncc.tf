

# resource "databricks_mws_networks" "ncc" {
#     account_id       = var.databricks_account_id
#     network_name     = azurerm_virtual_network.this.name
#     vpc_id           = azurerm_virtual_network.this.id
#     subnet_ids       = [azurerm_subnet.host.id, azurerm_subnet.container.id]
#     security_group_ids = [azurerm_network_security_group.this.id]
# }