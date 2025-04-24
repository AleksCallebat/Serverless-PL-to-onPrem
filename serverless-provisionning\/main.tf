# main.tf
resource "azurerm_resource_group" "rg" {
    provider = azurerm
    name     = var.resource_group_name
    location = var.workspace_location
}

resource "azurerm_databricks_workspace" "workspace" {
    depends_on = [azurerm_resource_group.rg]
    provider = azurerm
    location       = var.workspace_location
    sku            = "premium"
    name = var.workspace_name
    resource_group_name = var.resource_group_name
}

resource "databricks_sql_endpoint" "serverless_sql" {
    provider = databricks.workspace
    name                 = var.endpoint_name
    cluster_size         = var.cluster_size
    max_num_clusters     = var.max_num_clusters
    min_num_clusters     = var.min_num_clusters
    enable_serverless_compute = true
}


# Output the endpoint ID
output "sql_endpoint_id" {
    value = databricks_sql_endpoint.serverless_sql.id
}

# Output the workspace ID
output "workspace_id" {
    value = azurerm_databricks_workspace.workspace.id
}