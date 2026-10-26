# lab003-storage-sas-www

Laboratorium 3 kursu „Podstawy technologii chmurowych” 2026/27 (PK).

* Część podstawowa -- udostępnianie plików przez tokeny SAS: Storage Account
  `stfiles26<student_id>`, prywatny kontener `shared-files`, pliki z `files/`, RBAC, polityka
  cyklu życia
* Część opcjonalna -- statyczna strona WWW: Storage Account `stwww26<student_id>` z hostingiem
  statycznym, pliki z `www/`; włączana przez `static_website_enabled = true`

## Uruchomienie

Wymagane zmienne środowiskowe (Laboratorium 1) i zdalny backend z lab 2/3:

```bash
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
export TF_VAR_student_id=g14k01n123456   # WŁASNA wartość
tofu init
tofu plan
tofu apply

# część opcjonalna
tofu apply -var static_website_enabled=true
```

Nazwy i tagi pochodzą z `naming.tf` (kopia z szablonu kursu), stan -- `backend.tf`
(klucz `2026/lab003-storage-sas-www/terraform.tfstate`).
