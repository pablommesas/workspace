#' Find the workspace path
#'
#' @export
get_workspace_folder <- function() {
  pwd <- Sys.getenv("MY_WORKSPACE_PATH")

  if (pwd == "") {
    stop("Workspace path could not be found. Did you export a MY_WORKSPACE_PATH variable?")
  }

  pwd
}
