provider "azurerm" {
  features {}
  subscription_id = "fa5da814-c6c2-422a-be88-0fc464adece6"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-dot-resource"
  location = "East US 2"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "harsh_app_service_plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "my-app_service" {
  name                = "dot-app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
