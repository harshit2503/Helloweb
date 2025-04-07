provider "azurerm" {
  features {}
  subscription_id = "fa5da814-c6c2-422a-be88-0fc464adece6"
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-dot-resource"
  location = "East US 2"
}

# Create App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "jenkins-app-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"  # Fixed the incorrect SKU block
}

# Create App Service for Jenkins
resource "azurerm_linux_web_app" "jenkins" {
  name                = "dot-app-service"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true

    application_stack {
      dotnet_version = "8.0"  # Fixed the incorrect field name
    }
  }
}
