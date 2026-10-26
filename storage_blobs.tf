# Prywatny kontener na pliki do udostępnienia
resource "azurerm_storage_container" "shared_files" {
  name                  = "shared-files"
  storage_account_id    = azurerm_storage_account.files.id
  container_access_type = "private"
}

# Upload plików z katalogu files/
# Upload plików do Storage Account
resource "azurerm_storage_blob" "shared_files" {
  for_each = local.shared_files

  name                 = each.key
  storage_container_id = azurerm_storage_container.shared_files.id
  type                 = "Block"
  source               = each.value
  content_type = lookup(
    local.content_types, reverse(split(".", each.key))[0], "application/octet-stream"
  )
}
