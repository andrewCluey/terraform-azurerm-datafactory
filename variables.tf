variable "name" {
  type        = string
  description = "The name to assign to the new Azure Data Factory."
}

variable "location" {
  type        = string
  description = "The Azure Region where the Data Factory is to be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource group where the Data Factory will be deployed."
}

variable "public_network_enabled" {
  type        = bool
  description = "(Optional) Is the Data Factory visible to the public network? Defaults to true"
  default     = true
}

variable "adf_ir_name" {
  type        = string
  description = "If a self-hosted Integration Runtime is required with the Azure data factory deplyment, enter the name here. If left at default, then IR will not be deployed."
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the new resources."
  type        = map(string)
  default     = {}
}

variable "managed_virtual_network_enabled" {
  type        = bool
  description = "description"
  default     = false
}

variable "customer_managed_key_id" {
  type        = string
  description = "Specifies the Azure Key Vault Key ID to be used as the Customer Managed Key (CMK) for double encryption. Required with user assigned identity."
  default     = null
}

variable "customer_managed_key_identity_id" {
  type        = string
  description = "Specifies the ID of the user assigned identity associated with the Customer Managed Key. Must be supplied if customer_managed_key_id is set."
  default     = null
}

/*

variable "github_configuration" {
  type = object({
    git_url         = optional(string) # - Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com. Default is "https://github.com"
    account_name    = optional(string) # - Specifies the GitHub account name. Defaults to 'asda-ecom'
    repository_name = optional(string)           # - Specifies the name of the git repository. 
    branch_name     = optional(string) # - Specifies the branch of the repository to get code from. Defaults to 'main'
    root_folder     = optional(string) # - Specifies the root folder within the repository. Defaults to '/' for top level.
  })
  description = "An input object to define the settings for connecting to GitHub. NOTE! You must log in to the Data Factory management UI to complete the authentication to the GitHub repository."
  default     = {}
}
*/

variable "global_parameters" {
  type = any
  description = "An input object to define a global parameter. Accepts multiple entries."
  default     = {}
}