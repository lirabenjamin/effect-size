# install.packages("psymetadata")
# install.packages("metadat")
library(psymetadata)
library(metadat)

metadat::dat.aloe2013
metadat::dat.stowe2010
metadat::dat.pagliaro1992
metadat::dat.curtis1998

metadat::

psymetadata::agadullina2018 %>% as_tibble()
psymetadata::aksayli2019 %>% as_tibble()
psymetadata::wibbelink2017 %>% as_tibble()
psymetadata::manylabs2018 %>% as_tibble()
psymetadata::spaniol2020 %>% as_tibble()
psymetadata::maccann2020 %>% as_tibble()
library(psymetadata)
psymetadata = agadullina2018 %>% mutate(meta_id = "agadullina2018", es_metric = "z") %>% 
  bind_rows(aksayli2019 %>% mutate(meta_id = "aksayli2019", es_metric = "")) %>% as_tibble() %>%
  mutate(pub_year = as.numeric(pub_year)) %>%
  bind_rows(barroso2021 %>% mutate(meta_id = "barroso2021")) %>%
  bind_rows(coles2019 %>% mutate(meta_id = "coles2019")) %>%
  bind_rows(gamble2019 %>% mutate(meta_id = "gamble2019")) %>%
  bind_rows(gnambs2020 %>% mutate(meta_id = "gnambs2020")) %>%
  bind_rows(lowe2020 %>% mutate(meta_id = "lowe2020")) %>%
  bind_rows(maccann2020 %>% mutate(meta_id = "maccann2020", pub_type = as.character(pub_type))) %>%
  bind_rows(maldonado2020 %>% mutate(meta_id = "maldonado2020")) %>%
  bind_rows(manybabies2020 %>% mutate(meta_id = "manybabies2020")) %>%
  bind_rows(manylabs2018 %>% mutate(meta_id = "manylabs2018")) %>%
  mutate(age = as.character(age)) %>%
  bind_rows(noble2019 %>% mutate(meta_id = "noble2019")) %>%
  bind_rows(nuijten2020 %>% mutate(meta_id = "nuijten2020")) %>%
  bind_rows(sala2019 %>% mutate(meta_id = "sala2019")) %>%
  bind_rows(schroeder2020 %>% mutate(meta_id = "schroeder2020")) %>%
  mutate(es_id = as.character(es_id), study_id = as.character(study_id)) %>%
  bind_rows(spaniol2020 %>% mutate(meta_id = "spaniol2020", es_id = as.character(es_id))) %>%
  bind_rows(stasielowicz2019a %>% mutate(meta_id = "stasielowicz2019a", es_id = as.character(es_id), study_id = as.character(study_id), age = as.character(age), pub_type = as.character(pub_type))) %>%
  bind_rows(stasielowicz2019b %>% mutate(meta_id = "stasielowicz2019b", es_id = as.character(es_id), study_id = as.character(study_id), age = as.character(age), pub_type = as.character(pub_type))) %>%
  bind_rows(steffens2020 %>% mutate(meta_id = "steffens2020", es_id = as.character(es_id), study_id = as.character(study_id), age = NA, pub_type = NA, design = as.character(design), published = as.character(published))) %>%
  bind_rows(stramaccia2021 %>% mutate(meta_id = "stramaccia2021", es_id = as.character(es_id), study_id = as.character(study_id))) %>%
  bind_rows(wibbelink2017 %>% mutate(meta_id = "wibbelink2017", es_id = as.character(es_id), study_id = as.character(study_id)))

psymetadata %>% 
  select(yi, vi, es_metric, meta_id) %>%
  group_by(meta_id) %>%
  nest() %>% 
  mutate(lm = map(data, ~lm(yi~vi, data = .x)))

psymetadata %>% 
  select(meta_id, study_id) %>% 
  unique()

psymetadata %>% 
  filter(is.na(vi)) %>% 
  count(meta_id)

psymetadata %>% 
  select(meta_id, study_id, n)  %>%
  unique()  %>% 
  summarise(sum(n, na.rm = T))

ls("package:metadat") %>%
 enframe() %>% 
 mutate(
  paper = str_remove(value, "dat."),
  year = str_remove(paper, "[a-z]+")
 ) %>% 
 mutate(year = as.numeric(year)) %>% 
  filter(year > 2017) %>%
 ggplot(aes(year)) +
  geom_histogram() +
  scale_y_continuous(breaks = 1:10)

# install.packages("rjags")
# install.packages("RoBMA")

fit = RoBMA::RoBMA(d = aksayli2019$yi, v = aksayli2019$vi, seed = 1, model = "PSMA", parallel = TRUE)

library(RoBMA)

load("output/sample_robma_fit.rds")

forest(fit, order = "increasing")
plot_models(fit)

aksayli2019 %>% as_tibble()
interpret(fit)
diagnostics(fit, parameter = "mu", type = "chains")
summary(fit)

plot(fit, parameter = "mu") # mean
plot(fit, parameter = "tau") # heterogeneity
plot(fit, parameter = "PET-PEESE") # PET-PEESE
plot(fit, parameter = "omega") # publicatoin bias

aksayli2019 %>%   
  ggplot(aes(x = yi, y = vi)) +
  geom_point()

# make a funnel plot
metafor::rma(yi = yi,vi = vi, data = aksayli2019)  %>%
  metafor::regplot()

# Weights from 36 models
sum = summary(fit, type = "models", short_name = T)
weights = sum$summary %>% as_tibble()

# Posterior probabilities for 36 models
extract_mcmc = function(fit, model_number, parameter){
  samples <- coda::as.mcmc(fit$models[[model_number]]$fit)
  if(is.null(colnames(samples))){return(NULL)}
  samples <- samples[, parameter]
  return(samples)
}

enframe_mcmc_models = function(fit){
1:36 %>%
  enframe() %>% 
  mutate(samples = map(value, ~extract_mcmc(fit, model_number = .x, parameter = "mu"))) %>% 
  unnest(samples) %>% 
  select(model = name, sample = samples) %>% 
  nest(sample)
}

values = (summary(fit))$estimates[1,] %>% unlist() %>%enframe() %>% pull(value)
mcmc = enframe_mcmc_models(fit) %>% 
  unnest(data)  

weighted_avg <- mcmc %>% 
  left_join(weights %>% rename(model = Model)) %>% 
  mutate(bias = ifelse(model %in% c(1, 10, 19, 28), "No Bias", "Bias")) %>%
  group_by(bias) %>%
  summarise(weighted_mean = sum(sample * post_prob) / sum(post_prob))

weighted_avg %>% spread(bias, weighted_mean) %>% mutate(Bias/`No Bias`)

# Plot posterior distributions of effect size for models assuming publication bias vs. not
mcmc %>% 
  left_join(weights %>% rename(model = Model)) %>% 
  mutate(bias = ifelse(model %in% c(1, 10, 19, 28), "No Bias", "Bias")) %>% 
  ggplot(aes(
    x = sample, y = ..density.., weight = post_prob,
    color = bias, group = bias
    )) +
  geom_density(adjust = .5)+
  geom_vline(data = weighted_avg, aes(xintercept = weighted_mean, color = bias), linetype = "dashed") +
  # coord_cartesian(xlim = c(-1.2, 0), ylim = c(0, 7))+
  # scale_x_continuous(breaks = seq(-1.2, 0, .2))+
  # scale_y_continuous(breaks = seq(0, 7, 1))+
  scale_color_manual(values = c("darkred", "gray36"))


# Interpolation
mcmc %>% 
  left_join(weights %>% rename(model = Model)) %>% 
  mutate(bias = ifelse(model %in% c(1, 10, 19, 28), "No Bias", "Bias")) %>%
  nest(data = c(sample)) %>% 
  mutate(
    density = map(data, ~density(.x$sample)),
    interpol = map(density, ~approx(.x$x, .x$y, 
    # xout = seq(min(.x$x), max(.x$x),.01)
    xout = seq(-1.2, 1.2, .01)
    )),
    x = map(interpol, ~.x$x),
    y = map(interpol, ~.x$y)
    )  %>% 
    unnest(c(y, x)) %>% 
    mutate(y = y * post_prob) %>%
    group_by(x) %>%
    summarise(y = sum(y, na.rm = T)) %>%
    mutate(cum = cumsum(y)) %>%
    filter(cum > .45 & cum < .55) %>%
    ggplot(aes(x, y))+
    geom_line()
