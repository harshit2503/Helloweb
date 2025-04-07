variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "fa5da814-c6c2-422a-be88-0fc464adece6"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US 2"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "jenkins-app-service-plan"
}

variable "os_type" {
  description = "Operating System Type for App Service"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "Pricing Tier for App Service Plan"
  type        = string
  default     = "B1"
}
