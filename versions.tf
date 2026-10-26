terraform {
  required_version = "~> 1.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.8"
    }
  }
}

provider "azurerm" {
  features {}
  # identyfikator subskrypcji -- ze zmiennej środowiskowej ARM_SUBSCRIPTION_ID
}
