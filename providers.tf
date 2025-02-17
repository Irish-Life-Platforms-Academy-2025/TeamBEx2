terraform {

  backend "azurerm" {
    resource_group_name  = "teamb-stage-rg"
    storage_account_name = "teambterraformsa"
    container_name       = "states"
    key                  = "teambex2.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "168b5162-e625-42f1-994a-dfcfff0433bb"

}