provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_adf_demo" {
  name     = "rg-adf-ascnewdemo"
  location = "uksouth"
}

# vnet
resource "azurerm_virtual_network" "vn_test" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.rg_adf_demo.location
  resource_group_name = azurerm_resource_group.rg_adf_demo.name
  address_space       = ["10.0.0.0/16"]
}

# subnet
resource "azurerm_subnet" "example" {
  name                                           = "kv-subnet"
  resource_group_name                            = azurerm_resource_group.rg_adf_demo.name
  virtual_network_name                           = azurerm_virtual_network.vn_test.name
  address_prefixes                               = ["10.0.1.0/24"]
  enforce_private_link_endpoint_network_policies = true # DISABLE the policy
}



module "demo_adf" {
  source = "../"

  adf_config = {
    name                = "adf-asc-demonew"
    location            = azurerm_resource_group.rg_adf_demo.location
    resource_group_name = azurerm_resource_group.rg_adf_demo.name
  }

  pe_name                     = "adf-demo-new-pe"
  adf_ir_name                 = "adf-demonew-ir"
  pe_subnet_id                = azurerm_subnet.example.id
  private_vault_dns_zone_ids  = ["/subscriptions/7dfesrdgvgsegrsrdf-ttt-98/resourceGroups/rg-test/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"]
  private_vault_dns_zone_name = "privatelink.datafactory.azure.net"

}