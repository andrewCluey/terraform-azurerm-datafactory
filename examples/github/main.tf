terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.20.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-gh-ex-adf"
  location = "uksouth"
}

module "test_gh_adf" {
  source                          = "../../"
  name                            = "adf-gh-ex-t5r"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  managed_virtual_network_enabled = true

  github_configuration = {
    git_url         = "https://github.com"
    account_name    = "andrewCluey"
    repository_name = "azureDataFactory-Dev"
    branch_name     = "main"
    root_folder     = "/"
  }

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
  name                = module.test_gh_adf.adf_name
  resource_group_name = azurerm_resource_group.rg.name
}

output "global_param_look" {
  value = data.azurerm_data_factory.deployed_adf #.global_parameter["test-string"]
}

