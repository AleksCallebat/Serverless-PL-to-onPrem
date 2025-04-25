# main.tf

# Create a resource group
resource "azurerm_resource_group" "rg" {
    provider = azurerm
    name     = var.resource_group_name
    location = var.workspace_location
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    provider = azurerm
    name                = "${var.workspace_name}-vnet"
    location            = var.workspace_location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = ["10.0.0.0/16"]
}

# Create public and private subnets
resource "azurerm_subnet" "public_subnet" {
    provider = azurerm
    name                 = "${var.workspace_name}-public-subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.1.0/24"]
    enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "private_subnet" {
    provider = azurerm
    name                 = "${var.workspace_name}-private-subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.2.0/24"]
    enforce_private_link_service_network_policies = false
}

# Create a Databricks workspace with BYOVPC
resource "azurerm_databricks_workspace" "workspace" {
    depends_on = [azurerm_resource_group.rg]
    provider = azurerm
    location            = var.workspace_location
    sku                 = "premium"
    name                = var.workspace_name
    resource_group_name = azurerm_resource_group.rg.name

    custom_parameters {
        # public_subnet_name  = azurerm_subnet.public_subnet.name
        private_subnet_name = azurerm_subnet.private_subnet.name
        virtual_network_id  = azurerm_virtual_network.vnet.id
    }
}

# Create a Databricks SQL endpoint
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

# Output the workspace URL
output "workspace_url" {
    value = azurerm_databricks_workspace.workspace.workspace_url
}