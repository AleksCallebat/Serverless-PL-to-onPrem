variable "subscription_id"  {
    description = "The Azure subscription ID"
    type        = string
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "workspace_name" {
    description = "Name of the Databricks workspace"
    type        = string
}

variable "workspace_location" {
    description = "Azure region for the workspace"
    type        = string
}

variable "databricks_token" {
    description = "Databricks personal access token"
    type        = string
    sensitive   = true
}

variable "endpoint_name" {
    description = "Name of the Databricks SQL endpoint"
    type        = string
    default     = "serverless-sql-endpoint"
}

variable "cluster_size" {
    description = "Cluster size for the SQL endpoint"
    type        = string
    default     = "Small"
}

variable "max_num_clusters" {
    description = "Maximum number of clusters for the SQL endpoint"
    type        = number
    default     = 5
}

variable "min_num_clusters" {
    description = "Minimum number of clusters for the SQL endpoint"
    type        = number
    default     = 1
}
