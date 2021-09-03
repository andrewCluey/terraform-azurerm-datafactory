variable "adf_config" {
  type        = object({
    name = string
    location = string
    resource_group_name = string
  })
  description = "The required input parameters for a new Azure data factory (v2)"
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

variable "pe_name" {
  type        = string
  description = "The Name to assign to the Private Endpoint (if required)"
  default     = ""
}

variable "pe_subnet_id" {
  type        = string
  description = "Ther ID of the Subnet where the ADF Private Endpoint should be deployed."
  default     = ""
}

variable "private_vault_dns_zone_name" {
  description = "The name of the Private DNS zone for Private Endpoint"
  type        = string
  default     = ""
}

variable "private_vault_dns_zone_ids" {
  description = "The ID of the Private DNS zone for Private Endpoint"
  type        = list(string)
  default     = []
}



variable "tags" {
  description = "A map of tags to assign to the new resources."
  type        = map(string)
  default     = {}
}
