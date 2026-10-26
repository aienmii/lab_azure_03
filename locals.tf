locals {
  # Wartości labu wymagane przez naming.tf
  lab            = "003"
  workload       = "files" # => local.names.st = stfiles26<student_id>
  workload_short = null    # skrót, gdy workload nie mieści się w limicie nazwy (naming.tf)

  # Odstępstwo od local.names.st: w tym repo są dwa Storage Account (pliki + strona WWW),
  # a naming.tf generuje jedną nazwę na lab. Druga nazwa wg tego samego wzorca CAF.
  st_www = "stwww${local.yy}${local.sid}"

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
