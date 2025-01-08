terraform {
  required_version = ">= 1.0"

  required_providers { 
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azapi = {
      source  = "azure/azapi"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "kaan-cc-ai-demo-comm-rg"
    storage_account_name = "kaaneuaidemotfst"
    container_name       = "kaan-eu-ai-demo-tf-state-con"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults    = false
      purge_soft_delete_on_destroy       = false
      purge_soft_deleted_keys_on_destroy = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azapi" {
}