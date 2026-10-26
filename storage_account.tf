# Storage Account na pliki udostępniane przez SAS -- bez publicznego dostępu
# Storage Account na pliki udostępniane przez SAS -- bez publicznego dostępu
resource "azurerm_storage_account" "files" {
  name                     = local.names.st # stfiles26<student_id>
  resource_group_name      = data.azurerm_resource_group.basic.name
  location                 = data.azurerm_resource_group.basic.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # Bezpieczeństwo
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false # brak anonimowego dostępu do kontenerów

  blob_properties {
    last_access_time_enabled = true # wymagane przez reguły "since_last_access"
    delete_retention_policy {
      days = 7
    }
  }

  tags = merge(local.project_tags, { purpose = "file-sharing" })
}

# Cykl życia obiektów: chłodniejsze warstwy dla rzadko czytanych plików, usuwanie po 30 dniach
resource "azurerm_storage_management_policy" "files" {
  storage_account_id = azurerm_storage_account.files.id

  rule {
    name    = "shared-files-cleanup"
    enabled = true

    filters {
      blob_types   = ["blockBlob"]
      prefix_match = ["shared-files/"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_last_access_time_greater_than = 7
        tier_to_cold_after_days_since_last_access_time_greater_than = 14
        delete_after_days_since_creation_greater_than               = 30
      }
    }
  }
}
