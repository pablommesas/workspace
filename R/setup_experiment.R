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
project <- function(project_id) {
  # check whether the working directory is indeed the workspace folder
  fold <- get_workspace_folder()

  # set option
  options(workspace_project_id = project_id)
}

# create a helper function
project_subfolder <- function(path) {
  function(filename = "", project_id = NULL) {
    filename <- paste0(filename, collapse = "")

    work_fold <- get_workspace_folder()

    # check whether exp_id is given
    if (is.null(project_id)) {
      project_id <- getOption("workspace_project_id")
    }

    # check whether exp_fold could be found
    if (is.null(project_id)) {
      stop("No project folder found. Did you run project(...) yet?")
    }

    # determine the full path
    full_path <- paste0(work_fold, "/", path, "/", project_id, "/")

    # create if necessary
    dir.create(full_path, recursive = TRUE, showWarnings = FALSE)

    # get complete filename
    paste(full_path, filename, sep = "")
  }
}

#' @rdname project
#' @export
code_file <- project_subfolder("projects")

#' @rdname project
#' @export
derived_file <- project_subfolder("data/derived_data")

#' @rdname project
#' @export
raw_file <- project_subfolder("data/raw_data")

#' @rdname project
#' @export
result_file <- project_subfolder("data/result")

