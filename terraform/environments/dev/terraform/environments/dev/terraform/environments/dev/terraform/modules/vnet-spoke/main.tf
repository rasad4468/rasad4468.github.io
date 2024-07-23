variable "resource_group_name" {
  description = "The name of the resource group in which resources are created"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "spoke_vnet_name" {
  description = "The name of the spoke virtual network"
  type        = string
}

variable "is_spoke_deployed_to_same_hub_subscription" {
  description = "Specify if you are deploying the spoke VNet using the same hub Azure subscription"
  type        = bool
}

variable "vnet_address_space" {
  description = "The address space for the spoke virtual network"
  type        = list(string)
}

variable "hub_virtual_network_id" {
  description = "The ID of the hub virtual network"
  type        = string
}

variable "hub_firewall_private_ip_address" {
  description = "The private IP address of the hub firewall"
  type        = string
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
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
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type = map(string)
}

output "vnet_id" {
  description = "The ID of the spoke virtual network"
  value       = azurerm_virtual_network.spoke_vnet.id
}

output "vnet_address_space" {
  description = "The address space of the spoke virtual network"
  value       = azurerm_virtual_network.spoke_vnet.address_space
}

output "subnets" {
  description = "The subnets within the spoke virtual network"
  value       = azurerm_subnet.spoke_subnets[*].id
}
