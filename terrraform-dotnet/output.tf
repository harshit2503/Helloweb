output "resource_group_name" {
  description = "The name of the created Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan"
  value       = azurerm_service_plan.asp.name
}

output "jenkins_url_app" {
  description = "The URL of the deployed Jenkins Web App"
  value       = azurerm_linux_web_app.jenkins.default_hostname
}
