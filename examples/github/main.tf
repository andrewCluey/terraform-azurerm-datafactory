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


resource "azurerm_resource_group" "main" {
  name     = "rg-gh-ex-adf"
  location = "uksouth"
}

module "test_gh_adf" {
  source                          = "../../"
  name                            = "adf-gh-ex-t5r"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
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




