# resource "random_pet" "rg_name" { 
#   prefix = var.resource_group_name_prefix
# }

// RESOURCE GROUP
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${var.prefix}-rg"
}

data "azurerm_client_config" "current" {
}

// STORAGE ACCOUNT
resource "azurerm_storage_account" "default" {
  name                            = "${local.sanitized_prefix}st"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  allow_nested_items_to_be_public = false
}

// KEY VAULT
resource "azurerm_key_vault" "default" {
  name                     = "${var.prefix}-kv"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = false
  soft_delete_retention_days  = 7
  enable_rbac_authorization = true


}


// AzAPI AIServices
resource "azapi_resource" "AIServicesResource" {
  type     = "Microsoft.CognitiveServices/accounts@2023-10-01-preview"
  name     = "${var.prefix}-aiservices"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    kind       = "AIServices"
    name       = "${var.prefix}-aiservices"
    properties = {
      customSubDomainName = "${var.prefix}domain"
      apiProperties = {
        statisticsEnabled = false
      }
    }
    sku = {
      name = var.sku
    }
  }

  response_export_values = ["*"]
}

// Assign Cognitive Services OpenAI Contributor role to the specified principal
resource "azurerm_role_assignment" "openai_contributor" {
  scope                = azapi_resource.AIServicesResource.id
  role_definition_name = "Cognitive Services OpenAI Contributor"
  principal_id         = "8b24774c-70ab-427a-9d6f-8ee5d038b6e3"
}

// Assign Key Vault Secrets Officer role to the specified principal
resource "azurerm_role_assignment" "key_vault_secrets_officer" {
  scope                = azurerm_key_vault.default.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = "8b24774c-70ab-427a-9d6f-8ee5d038b6e3"
}

// Azure AI Hub
resource "azapi_resource" "hub" {
  type     = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
  name     = "${var.prefix}-aih"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    kind       = "hub"
    properties = {
      description    = "This is my Azure AI hub"
      friendlyName   = "My Hub"
      storageAccount = azurerm_storage_account.default.id
      keyVault       = azurerm_key_vault.default.id

      # Uncomment if needed
      # applicationInsight = azurerm_application_insights.default.id
      # containerRegistry  = azurerm_container_registry.default.id

      # Optional: Customer Managed Keys
      # encryption = {
      #   status = var.encryption_status
      #   keyVaultProperties = {
      #     keyVaultArmId  = azurerm_key_vault.default.id
      #     keyIdentifier  = var.cmk_keyvault_key_uri
      #   }
      # }
    }
  }
}


// Azure AI Project
resource "azapi_resource" "project" {
  type     = "Microsoft.MachineLearningServices/workspaces@2024-04-01-preview"
  name     = "${var.prefix}-project"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    kind       = "project"
    properties = {
      description  = "This is my Azure AI PROJECT"
      friendlyName = "My Project"
      hubResourceId = azapi_resource.hub.id
    }
  }
}


// AzAPI AI Services Connection
resource "azapi_resource" "AIServicesConnection" {
  type     = "Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview"
  name     = "${var.prefix}-connection"
  parent_id = azapi_resource.hub.id

  body = {
    properties = {
      category   = "AIServices"
      target     = azapi_resource.AIServicesResource.output.properties.endpoint
      authType   = "AAD"
      isSharedToAll = true
      metadata = {
        ApiType    = "Azure"
        ResourceId = azapi_resource.AIServicesResource.id
      }
    }
  }
  response_export_values = ["*"]
}

