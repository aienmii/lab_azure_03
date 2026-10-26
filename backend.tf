# backend.tf -- zdalny stan w Storage Account utworzonym w lab 2.
# OpenTofu (>= 1.8) oblicza przed `tofu init` zmienne i locals (early evaluation), więc blok
# backend może używać var.* i local.* z naming.tf -- ale nie module.*, data.* ani zasobów.
# Dlatego student_id musi być znany już przy `tofu init` (export TF_VAR_student_id=...).
# Rok w kluczu stanu oddziela stany kolejnych edycji kursu.
# Uwaga: blok backend może wystąpić tylko raz -- nie umieszczaj go w versions.tf.

terraform {
  backend "azurerm" {
    resource_group_name  = local.rg.common     # rg-common-26
    storage_account_name = local.common.st_tfs # sttfstate26<student_id>
    container_name       = "tfstate"
    key                  = "${local.year}/${var.project}/terraform.tfstate"
    use_azuread_auth     = true
  }
}
