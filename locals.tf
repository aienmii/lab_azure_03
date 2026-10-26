locals {
  # Wartości labu wymagane przez naming.tf
  lab            = "003"
  workload       = "files" # => local.names.st = stfiles26<student_id>
  workload_short = null    # skrót, gdy workload nie mieści się w limicie nazwy (naming.tf)

  # TODO: Dodaj local st_www dla statycznej strony (krok 4, opcjonalne)

  project_tags = merge(local.tags, {
    project = var.project
  })

  # Pliki udostępniane przez SAS: nazwa blobu => ścieżka lokalna
  shared_files = {
    "document1.pdf"     = "./files/document1.pdf"
    "presentation.pptx" = "./files/presentation.pptx"
    "data.csv"          = "./files/data.csv"
  }

  content_types = {
    pdf  = "application/pdf"
    pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    csv  = "text/csv"
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
  }
}
