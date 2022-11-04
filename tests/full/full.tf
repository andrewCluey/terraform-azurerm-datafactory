terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.29.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-full-test-adf"
  location = "uksouth"
}

module "test_full_adf" {
  source                          = "../../"
  name                            = "adf-full-test-r4e"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  public_network_enabled          = false
  managed_virtual_network_enabled = true

  global_parameters = {
    "testbool" = {
      type  = "Bool"
      value = true
    },
    "teststring" = {
      type  = "String"
      value = "Test String"
    }
  }
}

# Data lookup for Test assertions..

data "azurerm_data_factory" "deployed_adf" {
  name                = module.test_full_adf.adf_name
  resource_group_name = azurerm_resource_group.rg.name
}

output "global_param_look" {
  value = data.azurerm_data_factory.deployed_adf #.global_parameter["test-string"]
}