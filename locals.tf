locals {
  # Wartości labu wymagane przez naming.tf
  lab            = "003"
  workload       = "files" # => local.names.st = stfiles26<student_id>
  workload_short = null    # skrót, gdy workload nie mieści się w limicie nazwy (naming.tf)

  # TODO: Dodaj local st_www dla statycznej strony (krok 4, opcjonalne)

  project_tags = merge(local.tags, {
    project = var.project
  })

  # TODO: Dodaj local shared_files (pliki do udostępnienia, krok 1)

  # TODO: Dodaj local content_types (typy MIME wg rozszerzenia, krok 1)
}
