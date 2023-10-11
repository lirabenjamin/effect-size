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
