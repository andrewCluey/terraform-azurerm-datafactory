# Data lookups
data "azurerm_resource_group" "adf_rg" {
  name = var.adf_resourcegroup
}

#########################
# Create the Data Factory
#########################
resource "azurerm_data_factory" "adf" {
  name                = upper("${var.adf_name}")
  location            = data.azurerm_resource_group.adf_rg.location
  resource_group_name = data.azurerm_resource_group.adf_rg.name
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

}
