# function.r
analyze_data <- function(data_file) {
  # Your data analysis code here

}

# Get the dataset index from the environment variable SGE_TASK_ID
dataset_index <- Sys.getenv('SGE_TASK_ID')

# Build the dataset file name
data_file <- paste0('test_parallel/dataset-', dataset_index, '.csv')

# Call your function
analyze_data(data_file)