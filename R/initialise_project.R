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

  code_file()
  derived_file()
  raw_file()
  result_file()

  git2r::init(project_folder)
  readr::write_lines(c("derived_data"), root_file(".gitignore"), append = TRUE)
  readr::write_lines(c("raw_data", "derived_data", "results", "scripts"), root_file(".Rbuildignore"), append = TRUE)

  usethis::create_project(path = project_folder, rstudio = TRUE)
}

#' @rdname initialise_project
#' @export
initialize_project <- initialise_project
