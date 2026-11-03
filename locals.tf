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
  shared_files = {
    "document1.pdf"     = "${path.module}/files/document1.pdf"
    "data.csv"          = "${path.module}/files/data.csv"
    "presentation.pptx" = "${path.module}/files/presentation.pptx"
  }
  # TODO: Dodaj local content_types (typy MIME wg rozszerzenia, krok 1)
  content_types = {
    pdf  = "application/pdf"
    csv  = "text/csv"
    pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
  }
}