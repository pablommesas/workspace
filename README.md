# workspace

A package for allowing easy management of your project workspace. 

## Installation
You can install the package directly from GitHub:
```R
devtools::install_github("pablommesas/workspace")
```

You also need to set an environment variable `MY_WORKSPACE_PATH`. 
For unix-based systems, this can be done by placing the following content in `~/.Renviron`:

```bash
MY_WORKSPACE_PATH=/home/user/Workspace
```

Restart R to ensure the environment variables are correctly set.

## Explanation
You can create a new project as follows:
```R
library(workspace)
workspace::initialise_project("some_project")
```

The following folders will be created:

* `/home/user/Workspace/some_project/`:
  - `scripts/`: Scripts to process raw data or derived data into results.
  - `R/`: Reusable functions which will be compiled as a package named `some_project`.
  - `raw_data/`: Any data you created or download that you certainly never want to delete
  - `derived_data/`: Data reproducible by scripts and raw data; you should be able to safely delete this folder.
  - `results/`: Any figures or data objects that you save.

## Example 
An R script located at `/home/user/Workspace/some_project/scripts/script.R` could contain the following:
```R
library(tidyverse)
library(workspace)

# let workspace know what experiment you're working on
project("some_project", experiment_id = "my_first_experiment")

# save data at derived_data/my_first_experiment/data.rds
data <- tribble(
  ~x, ~y, 
  1,  2,
  3,  1, 
  7,  2
)
write_rds(data, derived_file("data.rds"))

# save a plot at results/my_first_experiment/myplot.pdf
g <- ggpot(data) + geom_point(aes(x, y))
ggsave(result_file("myplot.pdf"), g, width = 10, height = 10)

# read data from a different project, located at derived_data/some_other_project/data.rds
old_data <- read_rds(derived_file("data.rds", "some_other_project"))

# read this script... for whatever reason.
code_txt <- read_lines(script_file("script.R"))
```
