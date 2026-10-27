# Część opcjonalna: statyczna strona WWW -- tworzona tylko przy static_website_enabled = true.
# Osobny Storage Account, bo strona wymaga publicznego odczytu, a konto z plikami SAS
# ma go wyłączony.
resource "azurerm_storage_account" "www" {
  count = var.static_website_enabled ? 1 : 0

  name                     = local.st_www # stwww26<student_id>
  resource_group_name      = data.azurerm_resource_group.basic.name
  location                 = data.azurerm_resource_group.basic.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled       = false
    last_access_time_enabled = true
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }

  tags = merge(local.project_tags, { purpose = "static-website" })
}

resource "azurerm_storage_container" "www" {
  count = var.static_website_enabled ? 1 : 0

  name                  = "$web" # nazwa wymagana przez Azure
  storage_account_id    = azurerm_storage_account.www[0].id
  container_access_type = "private"
}

resource "azurerm_storage_account_static_website" "www" {
  count = var.static_website_enabled ? 1 : 0

  storage_account_id = azurerm_storage_account.www[0].id
  index_document     = "index.html"
  error_404_document = "404.html"

  depends_on = [azurerm_storage_container.www]
}

# Pliki strony z katalogu www/
resource "azurerm_storage_blob" "web_files" {
  for_each = var.static_website_enabled ? toset(var.web_files) : toset([])

  name                 = each.value
  storage_container_id = azurerm_storage_container.www[0].id
  type                 = "Block"
  source               = "${path.module}/www/${each.value}"
  content_type = lookup(
    local.content_types, reverse(split(".", each.value))[0], "application/octet-stream"
  )
}

# Cykl życia: pliki strony do chłodniejszych warstw, bez usuwania
resource "azurerm_storage_management_policy" "www" {
  count = var.static_website_enabled ? 1 : 0

  storage_account_id = azurerm_storage_account.www[0].id

  rule {
    name    = "static-website"
    enabled = true
    filters {
      prefix_match = ["$web/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than     = 7
        tier_to_cold_after_days_since_last_access_time_greater_than = 14
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 14
      }
    }
  }
}
