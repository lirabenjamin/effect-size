library(tidyverse)
library(RoBMA)

# function.r
analyze_data <- function(i) {
  # Your data analysis code here

  psymetadata = read_rds("data/psymetadata.rds")
  data = psymetadata %>% 
    group_by(meta_id) %>%
    nest() %>% 
    ungroup() %>%
    slice(i) %>% 
    unnest(data)
  id = data$meta_id[1]
  fit = RoBMA(r = data$yi, se = data$se, seed = 13)
  write_rds(fit, paste0("output/robma/id", ".rds"))
}

# Get the dataset index from the environment variable SGE_TASK_ID
i <- Sys.getenv('SGE_TASK_ID')

# Call your function
analyze_data(i)