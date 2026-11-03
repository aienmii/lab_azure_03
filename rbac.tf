# Administrative permissions
resource "azurerm_role_assignment" "storage_account_contributor" {
  scope                = azurerm_storage_account.files.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Data management permissions
resource "azurerm_role_assignment" "storage_blob_data_owner" {
  scope                = azurerm_storage_account.files.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}