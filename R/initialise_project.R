#' Initialise a project
#'
#' @param project_id The project_id
#'
#' @importFrom git2r init
#' @importFrom usethis create_project
#' @importFrom readr write_lines
#'
#' @export
initialise_project <- function(project_id) {
  project(project_id, experiment_id = "")

  project_folder <- root_file("")

  # create r package
  usethis::create_package(
    path = root_file("package"),
    rstudio = TRUE,
    open = FALSE,
    fields = list(Package = project_id)
  )

  # create folders
  derived_file()
  raw_file()
  result_file()

  # initialise git repository
  git2r::init(project_folder)
  readr::write_lines(c("derived_data"), root_file(".gitignore"), append = TRUE)
  readr::write_lines(c("raw_data", "derived_data", "results", "scripts"), root_file(".Rbuildignore"), append = TRUE)

  # move project file
  pack_file <- root_file(c(project_id, ".Rproj"))
  file.rename(root_file("package/package.Rproj"), pack_file)
  lines <- readr::read_lines(pack_file)
  lines <- c(lines, "PackagePath: package")
  readr::write_lines(lines, pack_file)
}

#' @rdname initialise_project
#' @export
initialize_project <- initialise_project
