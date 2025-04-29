# main.tf


# Create a Databricks SQL endpoint
resource "databricks_sql_endpoint" "serverless_sql" {
    depends_on = [azurerm_databricks_workspace.workspace]
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

