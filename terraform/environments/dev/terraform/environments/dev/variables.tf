variable "resource_group_name" {
  description = "The name of the resource group in which resources are created"
  type        = string
  default     = "rg-bxcz-demo-hub-southcentralus"
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
  default     = "southcentralus"
}

variable "spoke_vnet_name" {
  description = "The name of the spoke virtual network"
  type        = string
  default     = "default-spoke"
}

variable "is_spoke_deployed_to_same_hub_subscription" {
  description = "Specify if you are deploying the spoke VNet using the same hub Azure subscription"
  type        = bool
  default     = true
}

variable "vnet_address_space" {
  description = "The address space for the spoke virtual network"
  type        = list(string)
  default     = ["10.0.112.0/16"]
}

variable "hub_virtual_network_id" {
  description = "The ID of the hub virtual network"
  type        = string
}

variable "hub_firewall_private_ip_address" {
  description = "The private IP address of the hub firewall"
  type        = string
  default     = "10.1.0.5"
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
  default     = "publiccloud.example.com"
}

variable "hub_storage_account_id" {
  description = "The ID of the hub storage account"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}

variable "log_analytics_customer_id" {
  description = "The customer ID of the Log Analytics workspace"
  type        = string
}

variable "log_analytics_logs_retention_in_days" {
  description = "The retention period for logs in days"
  type        = number
  default     = 30
}

variable "subnets" {
  description = "A map of subnets to create in the spoke virtual network"
  type = map(object({
    subnet_name           = string
    subnet_address_prefix = list(string)
    service_endpoints     = list(string)
    nsg_inbound_rules     = list(list(string))
    nsg_outbound_rules    = list(list(string))
  }))
  default = {
    app_subnet = {
      subnet_name           = "application"
      subnet_address_prefix = ["10.0.112.1/24"]
      service_endpoints     = ["Microsoft.Storage"]
      nsg_inbound_rules = [
        ["ssh", "200", "Inbound", "Allow", "Tcp", "22", "*", ""],
        ["rdp", "201", "Inbound", "Allow", "Tcp", "3389", "*", ""]
      ]
      nsg_outbound_rules = [
        ["ntp_out", "203", "Outbound", "Allow", "Udp", "123", "", "0.0.0.0/0"]
      ]
    }
    db_subnet = {
      subnet_name           = "database"
      subnet_address_prefix = ["10.0.112.2/24"]
      service_endpoints     = ["Microsoft.Storage"]
      nsg_inbound_rules = [
        ["http", "100", "Inbound", "Allow", "Tcp", "80", "*", "0.0.0.0/0"],
        ["sql_port", "101", "Inbound", "Allow", "Tcp", "1433", "*", ""]
      ]
      nsg_outbound_rules = [
        ["ntp_out", "102", "Outbound", "Allow", "Udp", "123", "", "0.0.0.0/0"]
      ]
    }
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type = map(string)
  default = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
