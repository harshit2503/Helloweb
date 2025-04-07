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
--------------------------------------------------------------

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
  name                = "integrated-dot-net"
  location            = azurerm_resource_group.rgas.location
  resource_group_name = azurerm_resource_group.rgas.name
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
