terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.65.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.24.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.0"
    }
  }
  required_version = ">=1.9.8"
}
provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    use_cli         = true

}
provider "databricks" {
    host     = var.databricks_host
    # token    = var.databricks_token
}