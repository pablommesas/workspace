# workspace

A package for allowing easy management of your project workspace. 
This package assumes that an environment variable `MY_WORKSPACE_PATH` has been set,
and that your project resides within this folder.

For example, the `.bash_profile` contains:
```bash
export MY_WORKSPACE_PATH=/home/user/Workspace
```

An R script located at `/home/user/Workspace/project/myproject/script.R` could contain the following:
```R
library(tidyverse)
library(workspace)

project("myproject")

# save data at /home/user/Workspace/data/derived_data/myproject/data.rds
data <- tribble(
  ~x, ~y, 
  1,  2,
  3,  1, 
  7,  2
)
write_rds(data, derived_data("data.rds"))

# save a plot at /home/user/Workspace/data/result/myproject/myplot.pdf
g <- ggpot(data) + geom_point(aes(x, y))
ggsave(result_file("myplot.pdf), g, width = 10, height = 10)

# read data from a different project, located at /home/user/Workspace/data/derived_data/some_other_project/data.rds
old_data <- read_rds(derived_data("data.rds", "some_other_project"))
```
