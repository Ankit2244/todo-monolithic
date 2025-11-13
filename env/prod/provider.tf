terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backend-rg02"
    storage_account_name = "backendstg03"
    container_name       = "strg"
    key                  = "strg1.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "249a05f7-c643-4c2a-a2b0-0c1dc39022b7"
  #  tenant_id = "1449fb85-6c94-4b5d-bcf2-9410cee07ba5"
  #  client_id = "f819692e-a3ac-4a00-9436-688f6ea99999"
  #  client_secret =  "2dea7166-3d96-4740-b679-b6af49d08b6e"
}


