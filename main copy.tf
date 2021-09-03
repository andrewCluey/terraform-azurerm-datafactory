########################################################################################################################
# Create the Data Factory
########################################################################################################################
resource "azurerm_data_factory" "adf" {
  name                = var.adf_config.name
  location            = var.adf_config.location
  resource_group_name = var.adf_config.resource_group_name
  tags                = var.tags

  public_network_enabled = var.public_network_enabled

  identity {
    type = "SystemAssigned"
  }
}


################################################################################
# Create a new Private Endpoint - Optional
################################################################################
resource "azurerm_private_endpoint" "pe" {
  count               = var.pe_name == "" ? 0 : 1
  name                = var.pe_name
  location            = var.adf_config.location
  resource_group_name = var.adf_config.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${var.adf_config.name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_data_factory.adf.id
    subresource_names              = ["dataFactory"]
  }

  private_dns_zone_group {
    name                 = var.private_vault_dns_zone_name
    private_dns_zone_ids = var.private_vault_dns_zone_ids
  }
}




################################################################################
# Create the Data Factory Self hosted Integrattion Runtime
################################################################################
resource "azurerm_data_factory_integration_runtime_self_hosted" "adf_ir" {
  count               = var.adf_ir_name == "" ? 0 : 1
  name                = var.adf_ir_name
  resource_group_name = var.adf_config.resource_group_name
  data_factory_name   = azurerm_data_factory.adf.name
}