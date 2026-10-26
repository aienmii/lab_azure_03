variable "project" {
  description = "Nazwa projektu = nazwa repo; używana m.in. w kluczu stanu (backend.tf)"
  type        = string
  nullable    = false
  default     = "lab003-storage-sas-www"
}

variable "sas_validity_hours" {
  description = "Czas ważności tokenu SAS w godzinach"
  type        = number
  default     = 720 # 30 dni
}

# --- Część opcjonalna: statyczna strona WWW ---

variable "static_website_enabled" {
  description = "Czy utworzyć Storage Account ze statyczną stroną WWW (część opcjonalna)"
  type        = bool
  default     = false
}

variable "web_files" {
  description = "Pliki strony z katalogu www/ do wysłania do kontenera $web"
  type        = list(string)
  default = [
    "index.html",
    "style.css",
    "script.js"
  ]
}
