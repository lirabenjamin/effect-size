

library(metadat)


metadat = 
dat.aloe2013 %>% mutate(meta_id = "aloe2013", es_metric = "PCOR", exclude = T) %>% 
  bind_rows(dat.assink2016 %>% mutate(meta_id = "assink2016", es_metric = "SMD", study = as.character(study))) %>%
  bind_rows(dat.bakdash2021 %>% mutate(meta_id = "bakdash2021", es_metric = "SMCC", yi = es.z, vi = vi.z)) %>% 
  bind_rows(dat.bangertdrowns2004 %>% mutate(meta_id = "bangertdrowns2004", es_metric = "SMD")) %>%
  bind_rows(dat.bonett2010 %>% mutate(exclude = T, meta_id = "bonett2010", es_metric = "ARAW", study = as.character(study))) %>%
  bind_rows(dat.bourassa1996 %>% mutate(meta_id = "bourassa1996", es_metric = "OR", study = as.character(study), exclude = T)) %>%
  mutate(sample = as.character(sample))  %>%
  # missing Vi, but has N, also metric is not ZCOR but R
  bind_rows(
    dat.cohen1981 %>% mutate(meta_id = "cohen1981", es_metric = "ZCOR") %>%
      mutate(yi = ri, vi = 1/(ni - 3))
    ) %>% 
  bind_rows(dat.craft2003 %>% mutate(meta_id = "craft2003", es_metric = "ZCOR", study = as.character(study))) %>%
  bind_rows(dat.crede2010 %>% mutate(meta_id = "crede2010", es_metric = "ZCOR")) %>%
  bind_rows(dat.kalaian1996 %>% mutate(meta_id = "kalaian1996", es_metric = "SMD")) %>%
  bind_rows(dat.knapp2017 %>% mutate(meta_id = "knapp2017", es_metric = "SMD", study = as.character(study))) %>%
  bind_rows(dat.debruin2009 %>% mutate(meta_id = "debruin2009", es_metric = "PR")) %>% 
  bind_rows(dat.hasselblad1998 %>% mutate(meta_id = "hasselblad1998", es_metric = "OR", study = as.character(study))) %>%
  bind_rows(dat.konstantopoulos2011 %>% mutate(meta_id = "konstantopoulos2011", es_metric = "SMD", study = as.character(study))) %>%
  bind_rows(dat.landenberger2005 %>% mutate(meta_id = "landenberger2005", es_metric = "OR")) %>% 
  bind_rows(dat.lehmann2018 %>% mutate(meta_id = "lehmann2018", es_metric = "SMD")) %>%
  bind_rows(dat.linde2005 %>% mutate(meta_id = "linde2005", es_metric = "RR", group = as.character(group))) %>%
  bind_rows(dat.linde2015 %>% mutate(meta_id = "linde2015", es_metric = "OR")) %>%
  bind_rows(dat.linde2016 %>% mutate(meta_id = "linde2016", es_metric = "OR")) %>%
  bind_rows(dat.lopez2019 %>% mutate(meta_id = "lopez2019", es_metric = "SMC", group = as.character(group))) %>%
  bind_rows(dat.mccurdy2020 %>% mutate(meta_id = "mccurdy2020", es_metric = "RMD", sample = as.character(sample))) %>%
  mutate(type = as.character(type)) %>%
  bind_rows(dat.mcdaniel1994 %>% mutate(meta_id = "mcdaniel1994", es_metric = "ZCOR", study = as.character(study))) %>%
  bind_rows(dat.michael2013 %>% mutate(meta_id = "michael2013", es_metric = "RMD")) %>%
  bind_rows(dat.molloy2014 %>% mutate(meta_id = "molloy2014", es_metric = "ZCOR")) %>%
  bind_rows(dat.raudenbush1985 %>% mutate(meta_id = "raudenbush1985", es_mtric = "SMD", study = as.character(study))) %>%
  bind_rows(dat.tannersmith2016 %>% mutate(meta_id = "tannersmith2016", es_metric = "ZCOR")) %>% 
  as.tibble()

metadat

artanh(3)


library(psymetadata)
manylabs2018 %>% as_tibble()

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


psymetadata %>% 
  group_by(meta_id) %>%
  nest() %>% 
  ungroup() %>%
  slice(1) %>% 
  unnest(data)


?se_d2se_r
se_d2se_r(0.1, 0.3)
psymetadata %>% group_by(meta_id) %>% nest()
psymetadata %>% count(meta_id) %>% gt::gt()

atanh(.3)

RoBMA::se_d(.3, 100)

# convert a vi of d to a vi of r
RoBMA::se
