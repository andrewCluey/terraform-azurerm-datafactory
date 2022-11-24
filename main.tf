/**
 * # terraform-azurerm-datafactory
 *
 * 
 * Changes in this version:
 *     - Add GitHub configuration to use optional input object (requires v1.3.x of Terraform).
 *
 * Future changes to include:
 •    
 *   
 */


# -------------------------------------------------------------------
# Create Azure Data Factory
# -------------------------------------------------------------------
resource "azurerm_data_factory" "main" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  managed_virtual_network_enabled  = var.managed_virtual_network_enabled
  public_network_enabled           = var.public_network_enabled
  customer_managed_key_id          = var.customer_managed_key_id
  customer_managed_key_identity_id = var.customer_managed_key_identity_id
  tags                             = var.tags


  dynamic "github_configuration" {
    for_each = var.github_configuration != null ? [var.github_configuration] : []
    content {
      git_url         = github_configuration.value.git_url
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }

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
# Optional Azure Integration Runtime
# -------------------------------------------------------------------
resource "azurerm_data_factory_integration_runtime_azure" "main" {
  for_each = var.azure_integration_runtime

  name                    = each.key
  data_factory_id         = azurerm_data_factory.main.id
  location                = var.location
  description             = each.value.description
  compute_type            = each.value.compute_type
  core_count              = each.value.core_count
  time_to_live_min        = each.value.time_to_live_min
  cleanup_enabled         = each.value.cleanup_enabled
  virtual_network_enabled = each.value.virtual_network_enabled
}

