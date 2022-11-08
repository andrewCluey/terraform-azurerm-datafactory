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
resource "azurerm_data_factory" "adf" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  managed_virtual_network_enabled  = var.managed_virtual_network_enabled
  public_network_enabled           = var.public_network_enabled
  customer_managed_key_id          = var.customer_managed_key_id
  customer_managed_key_identity_id = var.customer_managed_key_identity_id
  tags                             = var.tags


  dynamic github_configuration {
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
