/**
 * # terraform-azurerm-datafactory
 *
 * 
 * Changes in this version:
 *   
 *
 * Future changes to include:
 *   
 */

# -------------------------------------------------------------------
# Create Azure Data Factory
# -------------------------------------------------------------------
resource "azurerm_data_factory" "adf" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  managed_virtual_network_enabled  = var.managed_virtual_network_enabled
  public_network_enabled           = var.public_network_enabled
  customer_managed_key_id          = var.customer_managed_key_id
  customer_managed_key_identity_id = var.customer_managed_key_identity_id
  tags                             = var.tags

/*
  dynamic "github_configuration" {
    for_each = var.github_configuration # conditional
    content {
      account_name    = lookup(github_configuration.value, "account_name", "asda-ecom")
      branch_name     = lookup(github_configuration.value, "branch", "main")
      git_url         = lookup(github_configuration.value, "git_url", "https://github.com")
      repository_name = github_configuration.value.repository_name
      root_folder     = lookup(github_configuration.value, "root_folder", "/")
    }
  }
  */
  dynamic "global_parameter" {
    for_each = var.global_parameters
    content {
      name  = global_parameter.key  
      type  = global_parameter.value.type
      value = global_parameter.value.value 
    }
  }

  identity {
    type = "SystemAssigned"
  }
}


# -------------------------------------------------------------------
# Create the Data Factory Self hosted Integration Runtime
# -------------------------------------------------------------------
/*
resource "azurerm_data_factory_integration_runtime_self_hosted" "adf_ir" {
  count               = var.adf_ir_name == "" ? 0 : 1
  name                = var.adf_ir_name
  resource_group_name = var.resource_group_name
  data_factory_name   = azurerm_data_factory.adf.name
}
*/