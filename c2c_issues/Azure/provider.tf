terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
  }
  # Remote state in Azure Blob Storage so the Wiz IaC Backend state-fetcher
  # can read it and build Code-to-Cloud correlation. Access key is supplied
  # at init time via the ARM_ACCESS_KEY env var (not committed here).
  backend "azurerm" {
    resource_group_name  = "avile"
    storage_account_name = "avile"
    container_name       = "tfstate"
    key                  = "c2c_issues/Azure/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "74bf2795-8375-49d1-ab43-e6656f93e94e"
}
