output "hub_virtual_network_id" {
  description = "The ID of the hub virtual network"
  value       = data.azurerm_virtual_network.hub-vnet.id
}

output "hub_storage_account_id" {
  description = "The ID of the hub storage account"
  value       = data.azurerm_storage_account.hub-st.id
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  value       = data.azurerm_log_analytics_workspace.hub-logws.id
}

output "log_analytics_customer_id" {
  description = "The customer ID of the Log Analytics workspace"
  value       = data.azurerm_log_analytics_workspace.hub-logws.workspace_id
}

output "vnet_spoke_id" {
  description = "The ID of the spoke virtual network"
  value       = module.vnet-spoke.vnet_id
}

output "vnet_spoke_address_space" {
  description = "The address space of the spoke virtual network"
  value       = module.vnet-spoke.vnet_address_space
}

output "vnet_spoke_subnets" {
  description = "The subnets within the spoke virtual network"
  value       = module.vnet-spoke.subnets
}

output "bastion_host_id" {
  description = "The ID of the Azure Bastion Host"
  value       = azurerm_bastion_host.example.id
}

output "bastion_public_ip" {
  description = "The public IP address of the Azure Bastion Host"
  value       = azurerm_public_ip.example.ip_address
}
