output "id" {
  description = "The ID of the new Datafactory resource."
  value       = azurerm_data_factory.main.id
}

output "name" {
  description = "The name of the newly created Azure Data Factory"
  value       = azurerm_data_factory.main.name
}


output "global_paramaters" {
  description = "A map showing any created Global Parameters."
  value       = { for gp in azurerm_data_factory.main.global_parameter : gp.name => gp }
}


