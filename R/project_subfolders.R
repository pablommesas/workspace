# create a helper function
project_subfolder <- function(path) {
  function(filename = "", project_id = NULL, experiment_id = NULL) {
    filename <- paste0(filename, collapse = "")

    work_fold <- get_workspace_folder()

    # check whether exp_id is given
    if (is.null(project_id)) {
      project_id <- getOption("workspace_project_id")
    }

    # check whether exp_id is given
    if (is.null(experiment_id)) {
      experiment_id <- getOption("workspace_experiment_id")
    }

    # check whether exp_fold could be found
    if (is.null(project_id)) {
      stop("No project folder found. Did you run project(...) yet?")
    }

    # check whether exp_fold could be found
    if (is.null(experiment_id)) {
      stop("No experiment id found. Did you run project(...) yet?")
    }

    # determine the full path
    full_path <- paste0(work_fold, "/", project_id, "/", path, "/", experiment_id, "/")

    # create if necessary
    dir.create(full_path, recursive = TRUE, showWarnings = FALSE)

    # get complete filename
    paste(full_path, filename, sep = "")
  }
}

#' @rdname project
#' @export
root_file <- project_subfolder("")

#' @rdname project
#' @export
R_file <- project_subfolder("R")

#' @rdname project
#' @export
script_file <- project_subfolder("scripts")

#' @rdname project
#' @export
derived_file <- project_subfolder("derived_data")

#' @rdname project
#' @export
raw_file <- project_subfolder("raw_data")

#' @rdname project
#' @export
result_file <- project_subfolder("results")

