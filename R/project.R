#' Helper function for controlling projects
#'
#' @param project_id id for the project
#' @param filename the filename
#'
#' @export
#'
#' @rdname project
#'
#' @examples
#' \dontrun{
#' project("test_plots")
#'
#' data <- matrix(runif(200), ncol = 2)
#' pdf(figure_file("testplot.pdf"), 5, 5)
#' plot(data)
#' dev.off()
#' }
project <- function(project_id, experiment_id = NULL) {
  # check whether the working directory is indeed the workspace folder
  fold <- get_workspace_folder()

  # set option
  options(workspace_project_id = project_id, workspace_experiment_id = experiment_id)
}
