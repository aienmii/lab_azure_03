output "storage_account_name" {
  description = "Nazwa Storage Account z plikami udostępnianymi przez SAS"
  value       = azurerm_storage_account.files.name
}

output "file_urls_with_sas" {
  description = "URL-e plików z tokenem SAS (tylko odczyt)"
  value = {
    for filename, blob in azurerm_storage_blob.shared_files :
    filename => "${blob.url}?${data.azurerm_storage_account_sas.files_sas.sas}"
  }
  sensitive = true
}

output "sas_token" {
  description = "Token SAS do plików (wrażliwy)"
  value       = data.azurerm_storage_account_sas.files_sas.sas
  sensitive   = true
}

# TODO: Dodaj output static_website_url (statyczna strona, krok 4)
