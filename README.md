<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-datafactory

Changes in this version:
    - Added optional element to add Azure integrated runtimes.

Future changes to include:

## Example - default
```hcl
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
  name     = "rg-def-ex-adf"
  location = "uksouth"
}

module "test_default_adf" {
  source                          = "../../"
  name                            = "adf-def-ex-s2w"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_integration_runtime"></a> [azure\_integration\_runtime](#input\_azure\_integration\_runtime) | Map Object to define any Azure Integration Runtime nodes that required.<br>  key of each object is the name of a new node.<br>  configuration parameters within the object allow customisation.<br>  EXAMPLE:<br>  azure\_integration\_runtime = {<br>    az-ir-co-01 {<br>      "compute\_type" .  = "ComputeOptimized"<br>      "cleanup\_enabled" = true<br>      core\_count        = 16<br>    },<br>    az-ir-gen-01 {},<br>    az-ir-gen-02 {},<br>  } | <pre>map(object({<br>    description             = optional(string, "Azure Integrated Runtime")<br>    compute_type            = optional(string, "General")<br>    virtual_network_enabled = optional(string, true)<br>    core_count              = optional(number, 8)<br>    time_to_live_min        = optional(number, 0)<br>    cleanup_enabled         = optional(bool, true)<br>  }))</pre> | `{}` | no |
| <a name="input_customer_managed_key_id"></a> [customer\_managed\_key\_id](#input\_customer\_managed\_key\_id) | Specifies the Azure Key Vault Key ID to be used as the Customer Managed Key (CMK) for double encryption. Required with user assigned identity. | `string` | `null` | no |
| <a name="input_customer_managed_key_identity_id"></a> [customer\_managed\_key\_identity\_id](#input\_customer\_managed\_key\_identity\_id) | Specifies the ID of the user assigned identity associated with the Customer Managed Key. Must be supplied if customer\_managed\_key\_id is set. | `string` | `null` | no |
| <a name="input_github_configuration"></a> [github\_configuration](#input\_github\_configuration) | An input object to define the settings for connecting to GitHub. NOTE! You must log in to the Data Factory management UI to complete the authentication to the GitHub repository. | <pre>object({<br>    git_url         = optional(string) # - OPTIONAL: Specifies the GitHub Enterprise host name. Defaults to "https://github.com"<br>    account_name    = optional(string) # - REQUIRED: Specifies the GitHub account name. Defaults to ''<br>    repository_name = optional(string) # - REQUIRED: Specifies the name of the git repository. <br>    branch_name     = optional(string) # - OPTIONAL: Specifies the branch of the repository to get code from. Defaults to 'main'<br>    root_folder     = optional(string) # - OPTIONAL: Specifies the root folder within the repository. Defaults to '/' for top level.<br>  })</pre> | `null` | no |
| <a name="input_global_parameters"></a> [global\_parameters](#input\_global\_parameters) | An input object to define a global parameter. Accepts multiple entries. | `any` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Data Factory is to be deployed. | `string` | `"uksouth"` | no |
| <a name="input_managed_virtual_network_enabled"></a> [managed\_virtual\_network\_enabled](#input\_managed\_virtual\_network\_enabled) | Is Managed Virtual Network enabled? | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to the new Azure Data Factory. | `string` | n/a | yes |
| <a name="input_public_network_enabled"></a> [public\_network\_enabled](#input\_public\_network\_enabled) | (Optional) Is the Data Factory visible to the public network? Defaults to true | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource group where the Data Factory will be deployed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the new resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_global_paramaters"></a> [global\_paramaters](#output\_global\_paramaters) | A map showing any created Global Parameters. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the new Datafactory resource. |
| <a name="output_name"></a> [name](#output\_name) | The name of the newly created Azure Data Factory |
<!-- END_TF_DOCS -->