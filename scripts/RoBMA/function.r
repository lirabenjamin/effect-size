library(RoBMA)
# Get posterior probabilities for one model
extract_mcmc = function(fit, model_number, parameter){
  samples <- coda::as.mcmc(fit$models[[model_number]]$fit)
  if(is.null(colnames(samples))){return(NULL)}
  samples <- samples[, parameter]
  return(samples)
}

# Get posterior probabilities for all models
enframe_mcmc_models = function(fit){
1:36 %>%
  enframe() %>% 
  mutate(samples = map(value, ~extract_mcmc(fit, model_number = .x, parameter = "mu"))) %>% 
  unnest(samples) %>% 
  select(model = name, sample = samples) %>% 
  nest(sample)
}

# Get model weights
get_model_weights = function(fit){
  sum = summary(fit, type = "models", short_name = T)
  weights = sum$summary %>% as_tibble()
  return(weights)
}

get_effect_heterogeneity_bias = function(fit){
  sum = summary(fit)
  comp = sum$components %>% as.data.frame() %>% rownames_to_column() %>% as_tibble()
  return(comp)
}

get_estimates = function(fit){
sum = summary(fit)
estimates = sum$estimates %>% as.data.frame() %>% rownames_to_column() %>% as_tibble()
return(estimates)
}

data = enframe_mcmc_models(fit) %>% 
  unnest(data) %>% 
  left_join(get_model_weights(fit) %>% rename(model = Model)) %>% 
  select(model, sample, post_prob) %>% 
  mutate(post_prob = round(post_prob * 100))

data %>% 
  ggplot(aes(sample, weight = post_prob)) +
  geom_density()


library(BMA)
library(psymetadata)
install.packages("metaBMA")

data = aksayli2019 %>% as_tibble() %>% mutate(se = sqrt(vi))

fit_bma = metaBMA::meta_bma(y = data$yi, SE = data$se)
fit_bma %>%str()

get_estimates(fit) %>% filter(rowname == "mu") %>% pull(Median)/
get_estimates_bma(fit_bma) %>% filter(rowname == "averaged") %>% pull(`50%`)
get_estimates_bma = function(fit_bma){
  fit_bma$estimates %>% as.data.frame() %>% rownames_to_column() %>%as_tibble()
}

fit_bma$inclusion %>% enframe()
fit_bma$BF
fit_bma$estimates
weighted_data <- rep(data$sample, times = data$post_prob * 100)

enframe(weighted_data) %>% 
  ggplot(aes(x = value)) +
  geom_histogram(binwidth = 0.1) +
  geom_vline(xintercept = 0.5, color = "red") +
  labs(title = "Posterior Probabilities for Model 1", x = "Effect Size", y = "Frequency") +
  theme_bw()

# Function to run all datasets:
## Inputs: data, es_metric_input, es_metric_output
## run robma and bma
## calculate correction factor
## Save both results and data for plotting.
library(RoBMA)
summary(fit)

extract_mcmc(fit, model_number = 32, parameter = "mu")
enframe_mcmc_models(fit)



def run_all(data, es_metric):
    # Run robma and bma
    robma_results = run_robma(data, es_metric)
    bma_results = run_bma(data, es_metric)
    
    # Calculate correction factor
    correction_factor = calculate_correction_factor(data, es_metric)
    
    # Save results and data
    save_results(robma_results, bma_results, correction_factor, data, es_metric)
    
    return robma_results, bma_results, correction_factor

