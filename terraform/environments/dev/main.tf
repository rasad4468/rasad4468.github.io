provider "azurerm" {
  features {}
}

data "azurerm_virtual_network" "hub-vnet" {
  name                = "vnet-default-hub-southcentralus"
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "hub-st" {
  name                = "stdiaglogs3hfsouthcentralus"
  resource_group_name = var.resource_group_name
}

data "azurerm_log_analytics_workspace" "hub-logws" {
  name                = "logaws-3hfsouthcentralus-default-hub-southcentralus"
  resource_group_name = var.resource_group_name
}

resource "azurerm_bastion_host" "example" {
  name                = "bastionhost-southcentralus"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_name            = "bastionhost-southcentralus"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_virtual_network.hub-vnet.subnet["AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_public_ip" "example" {
  name                = "publicIP-for-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "vnet-spoke" {
  source  = "../../modules/vnet-spoke"
  version = "2.2.0"

  resource_group_name = var.resource_group_name
  location            = var.location
  spoke_vnet_name     = var.spoke_vnet_name

  is_spoke_deployed_to_same_hub_subscription = var.is_spoke_deployed_to_same_hub_subscription

  vnet_address_space = var.vnet_address_space

  hub_virtual_network_id          = data.azurerm_virtual_network.hub-vnet.id
  hub_firewall_private_ip_address = var.hub_firewall_private_ip_address
  private_dns_zone_name           = var.private_dns_zone_name
  hub_storage_account_id          = data.azurerm_storage_account.hub-st.id

  log_analytics_workspace_id           = data.azurerm_log_analytics_workspace.hub-logws.id
  log_analytics_customer_id            = data.azurerm_log_analytics_workspace.hub-logws.workspace_id
  log_analytics_logs_retention_in_days = var.log_analytics_logs_retention_in_days

  subnets = var.subnets

  tags = var.tags
}
