terraform {
  required_providers {
    # terraform.io/builin/test is an experimental feature to provide native testing in Terraform.
    # This provider is only available when running tests, so you shouldn't be used in non-test modules.
    test = {
      source = "terraform.io/builtin/test"
    }

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
  name     = "rg-default-test-adf"
  location = "uksouth"
}

module "test_default_adf" {
    source = "../../"
    name = "adf-default-t-7wse"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
}


# --------------------------------------------------------------
# Test Assertions
# --------------------------------------------------------------
resource "test_assertions" "data_factory" {
  # "component" serves as a unique identifier for this particular set of assertions in the test results.
  component = "created_adf"

  # equal and check blocks serve as the test assertions.
  # The labels on these blocks are unique identifiers for the assertions.
  # Outputs from the module can be used to find out what was created (`GOT`).
  equal "adf_name" {
    description = "Confirm the Data Factory Name output."
    want        = "adf-default-t-7wse"
    got         = module.test_default_adf.adf_name
  }

}