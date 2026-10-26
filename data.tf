# Grupa zasobów utworzona w lab 2 (rg-labs-basic-26)
data "azurerm_resource_group" "basic" {
  name = local.rg.basic
}

# TODO: Dodaj data source client_config dla RBAC (krok 2)
