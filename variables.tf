variable "tags" {
  description = "A map of tags to assign to the new resources."
  type        = map(string)
}

variable "location" {
  description = "The Azure region to deploy the resources into"
  type        = string
  default     = "West Europ"
}

variable "adf_resourcegroup" {
  description = "The name of the Resource Group to deploy the new resources into"
  type        = string
}



