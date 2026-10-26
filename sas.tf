# Token SAS tylko do odczytu blobów, ważny var.sas_validity_hours godzin
# SAS token dla bezpiecznego dostępu do plików
data "azurerm_storage_account_sas" "files_sas" {
  connection_string = azurerm_storage_account.files.primary_connection_string
  https_only        = true

  start  = timeadd(timestamp(), "-5m")
  expiry = timeadd(timestamp(), "${var.sas_validity_hours}h") # domyślnie 720 h = 30 dni

  resource_types {
    object    = true # Dostęp do blob'ów
    container = false
    service   = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  permissions {
    read    = true # Tylko odczyt
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}
