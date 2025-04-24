terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
        databricks = {
            source  = "databricks/databricks"
            version = "~> 1.0"
        }
       
    }
}

provider "azurerm" {
    features {}
}
provider "databricks" {
    alias       = "workspace"
    host        = azurerm_databricks_workspace.workspace.workspace_url
}