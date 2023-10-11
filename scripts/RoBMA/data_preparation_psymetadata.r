
library(psymetadata)
psymetadata = agadullina2018 %>% mutate(meta_id = "agadullina2018", es_metric = "z") %>% 
  bind_rows(aksayli2019 %>% mutate(meta_id = "aksayli2019", es_metric = "g")) %>% as_tibble() %>%
  mutate(pub_year = as.numeric(pub_year)) %>%
  bind_rows(barroso2021 %>% mutate(meta_id = "barroso2021", es_metric = "z")) %>%
  bind_rows(coles2019 %>% mutate(meta_id = "coles2019", es_metric = "d")) %>%
  bind_rows(gamble2019 %>% mutate(meta_id = "gamble2019", es_metric = "r")) %>%
  bind_rows(gnambs2020 %>% mutate(meta_id = "gnambs2020", es_metric = "SMD")) %>%
  bind_rows(lowe2020 %>% mutate(meta_id = "lowe2020", es_metric = "g")) %>%
  bind_rows(maccann2020 %>% mutate(meta_id = "maccann2020", es_metric = "r", pub_type = as.character(pub_type))) %>%
  bind_rows(maldonado2020 %>% mutate(meta_id = "maldonado2020", es_metric = "g")) %>%
  bind_rows(manybabies2020 %>% mutate(meta_id = "manybabies2020", es_metric = "d")) %>%
  # manylabs as R and D. Lets keep R.
  bind_rows(manylabs2018 %>% rename(yi = yi_r, vi = vi_r) %>%mutate(meta_id = paste("manylabs2018", analysis), es_metric = "r")) %>%
  mutate(age = as.character(age)) %>%
  bind_rows(noble2019 %>% mutate(meta_id = "noble2019", es_metric = "g")) %>%
  bind_rows(nuijten2020 %>% mutate(meta_id = "nuijten2020", es_metric = "z")) %>%
  bind_rows(sala2019 %>% mutate(meta_id = "sala2019", es_metric = "g")) %>%
  bind_rows(schroeder2020 %>% mutate(meta_id = "schroeder2020", es_metric = "g")) %>%
  mutate(es_id = as.character(es_id), study_id = as.character(study_id)) %>%
  bind_rows(spaniol2020 %>% mutate(meta_id = "spaniol2020", es_metric = "g", es_id = as.character(es_id))) %>%
  bind_rows(stasielowicz2019a %>% mutate(meta_id = "stasielowicz2019a", es_metric = "r", es_id = as.character(es_id), study_id = as.character(study_id), age = as.character(age), pub_type = as.character(pub_type))) %>%
  bind_rows(stasielowicz2019b %>% mutate(meta_id = "stasielowicz2019b", es_metric = "r", es_id = as.character(es_id), study_id = as.character(study_id), age = as.character(age), pub_type = as.character(pub_type))) %>%
  mutate(sample = as.character(sample)) %>%
  bind_rows(stasielowicz2020 %>% mutate(meta_id = "stasielowicz2020", es_metric = "r")) %>%
  bind_rows(steffens2020 %>% mutate(meta_id = "steffens2020", es_metric = "z", es_id = as.character(es_id), study_id = as.character(study_id), age = NA, pub_type = NA, design = as.character(design), published = as.character(published))) %>%
  bind_rows(stramaccia2021 %>% mutate(meta_id = "stramaccia2021", es_metric = "d", es_id = as.character(es_id), study_id = as.character(study_id))) %>%
  bind_rows(wibbelink2017 %>% mutate(meta_id = "wibbelink2017", es_metric = "d", es_id = as.character(es_id), study_id = as.character(study_id)))

psymetadata = psymetadata %>% 
  select(es_id, n, yi, vi, es_metric, meta_id) %>% 
  mutate(es_metric = ifelse(es_metric == "g", "d", es_metric)) %>%
  mutate(es_metric = ifelse(es_metric == "SMD", "d", es_metric)) %>%
  mutate(se = sqrt(vi)) %>%
  mutate(yi = case_when(
    es_metric == "r" ~  yi,
    es_metric == "d" ~ yi/(sqrt(yi^2 + 4)) , 
    es_metric == "z" ~  (exp(2*yi) - 1)/(exp(2*yi) + 1)
  )) %>% 
  mutate(se = case_when(
    es_metric == "r" ~  se,
    es_metric == "d" ~ se_d2se_r(se, yi), 
    es_metric == "z" ~ se_z2se_r(se, yi)
  )) %>%
  mutate(es_metric = "r")

write_rds(psymetadata, "data/psymetadata.rds")