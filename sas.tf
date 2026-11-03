data "azurerm_storage_account_sas" "files_sas" {
  connection_string = azurerm_storage_account.files.primary_connection_string

  https_only = true

  start = timeadd(timestamp(), "-5m")
  expiry = timeadd(
    timestamp(),
    "${var.sas_validity_hours}h"
  )

  resource_types {
    object    = true
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
    read    = true
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