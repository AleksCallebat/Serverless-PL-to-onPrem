

variable "subscription_id"  {
    description = "The Azure subscription ID"
    type        = string
}

variable "workspace_name" {
    description = "The name of the Databricks workspace"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the Azure resource group"
    type        = string
}
# variable "token" {
#   description = "The Databricks personal access token"
#   type        = string
#   sensitive   = true
# }

variable "workspace_location" {
  description = "The location of the Databricks workspace"
  type        = string
}

variable "endpoint_name" {
  description = "The name of the serverless SQL endpoint"
  type        = string
  default     = "serverless-sql-endpoint"
}

variable "cluster_size" {
  description = "The size of the cluster for the SQL endpoint"
  type        = string
  default     = "Small"
}

variable "max_num_clusters" {
  description = "The maximum number of clusters for the SQL endpoint"
  type        = number
  default     = 5
}

variable "min_num_clusters" {
    description = "The minimum number of clusters for the SQL endpoint"
    type        = number
    default     = 1
}
