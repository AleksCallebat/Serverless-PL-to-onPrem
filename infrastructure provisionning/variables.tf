variable "is_kms_enabled" {
  type        = bool
  description = "(Optional - default to true) Enable KMS (Azure Key Vault) encryption for resources"
  default     = true
}

variable "metastore_id" {
  type        = string
  description = "(Required) The ID of the metastore to associate with the Databricks workspace"
}
variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the resource group"
}
variable "is_frontend_private_link_enabled" {
  type        = bool
  description = "(Optional - default to false) Enable frontend Private Link for Databricks workspace. When true, disables public network access."
  default     = false
}

# Resource placeholder that checks to see if private_dbfs should be created
variable "boolean_create_private_dbfs" {
  description = "Whether to enable Private DBFS, all Private DBFS resources will depend on Workspace"
  type        = bool
  default     = true
}

variable "location" {
  type        = string
  description = "(Required) The location for the spoke deployment"
}

variable "vnet_cidr" {
  # Note: following chart assumes a Vnet between /16 and /24, inclusive

  # | Subnet Size (CIDR) | Maximum ADB Cluster Nodes |
  # | /17	| 32763 |
  # | /18	| 16379 |
  # | /19	| 8187 |
  # | /20	| 4091 |
  # | /21	| 2043 |
  # | /22	| 1019 |
  # | /23	| 507 |
  # | /24	| 251 |
  # | /25	| 123 |
  # | /26	| 59 |

  type        = string
  description = "(Required) The CIDR block for the spoke Virtual Network"
  # default     = "10.2.1.0/24"
  validation {
    condition     = tonumber(split("/", var.vnet_cidr)[1]) > 15 && tonumber(split("/", var.vnet_cidr)[1]) < 25
    error_message = "CIDR block must be between /16 and /24, inclusive"
  }
}

# variable "route_table_id" {
#   type        = string
#   description = "(Required) The ID of the route table to associate with the Databricks subnets"
# }

# variable "metastore_id" {
#   type        = string
#   description = "(Required) The ID of the metastore to associate with the Databricks workspace"
# }
variable "ncc_name" {
  type        = string
  description = "(Required) The name of the Network Connectivity Config object to bind to ADB Workspace"
}
variable "ncc_id" {
  type        = string
  description = "(Required) The ID of the Network Connectivity Config object to bind to ADB Workspace"
}

variable "ipgroup_id" {
  type        = string
  description = "(Required) The ID of the IP Group used for firewall egress rules"
}

variable "subscription_id" {
  type        = string
  description = "(Required) The Azure subscription ID"
}
# variable "managed_disk_key_id" {
#   type        = string
#   description = "(Required) The key for managed disk encryption"
# }

# variable "managed_services_key_id" {
#   type        = string
#   description = "(Required) The key for the managed services encryption"
# }

variable "resource_suffix" {
  type        = string
  description = "(Required) Naming resource_suffix for resources"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Map of tags to attach to resources"
  default     = {}
}

# variable "ncc_id" {
#   type        = string
#   description = "(Required) The ID of the regional hub Network Connectivity Config object to bind to ADB Workspace."
# }
# variable "databricks_token" {
#   type        = string
#   description = "(Required) The Databricks personal access token"
#   sensitive   = true
# }

variable "databricks_account_id" {
  type        = string
  description = "(Required) The Databricks account ID"
}

variable "databricks_host" {
  type        = string
  description = "(Required) The Databricks host URL"
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Required) List of security group IDs to associate with the Databricks workspace"
  default     = []
}
variable "subnet_ids" {
  type        = list(string)
  description = "(Required) List of subnet IDs to associate with the Databricks workspace"
  default     = []
}
variable "tenant_id" {
  type        = string
  description = "(Required) The Azure tenant ID"
}