output "storage_account_name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.files.name
}

output "file_urls_with_sas" {
  description = "URLs of files with SAS tokens"

  value = {
    for filename, blob in azurerm_storage_blob.shared_files :
    filename => "${blob.url}?${data.azurerm_storage_account_sas.files_sas.sas}"
  }

  sensitive = true
}

output "sas_token" {
  description = "SAS token"
  value       = data.azurerm_storage_account_sas.files_sas.sas
  sensitive   = true
}