
Open Synthesis 
#TO INCLUDE. Clear effect-size metric (Ready for Robma)
opensynthesis = dai2023 %>% mutate(meta_id = "dai2023", es_metric = "SMD") %>% 
  bind_rows(harlow2023 %>% mutate(meta_id = "harlow2023", es_metric = "SMD")) %>%
  bind_rows(lotter2023 %>% mutate(meta_id = "lotter2023", es_metric = "MNI Coordinates")) %>% 
  bind_rows(madigan2023 %>% mutate(meta_id = "madigan2023", es_metric = "Proportions")) %>%
  bind_rows(sparcio2023 %>% mutate(meta_id = "sparcio2023", es_metric = "SMD")) %>%
  bind_rows(zhang2023 %>% mutate(meta_id = "zhang2023", es_metric = "SMD")) %>%
  bind_rows(anglim2022 %>% mutate(meta_id = "anglim2022", es_metric = "Correlations")) %>% 
  bind_rows(burnette2022 %>% mutate(meta_id = "burnette2022", es_metric = "SMD & Correlations")) %>%
  bind_rows(emslander2022 %>% mutate(meta_id = "emslander2022", es_metric = "Correlations")) %>%
  bind_rows(harper2022 %>% mutate(meta_id = "harper2022", es_metric = "Correlations")) %>%
  bind_rows(huth2022 %>% mutate(meta_id = "huth2022", es_metric = "Correlations")) %>% 
  bind_rows(imuta2022 %>% mutate(meta_id = "imuta2022", es_metric = "Correlations")) %>%
  bind_rows(jansen2022 %>% mutate(meta_id = "jansen2022", es_metric = "SMD")) %>%
  bind_rows(koutsoumpis2022 %>% mutate(meta_id = "koutsoumpis2022", es_metric = "Correlations")) %>%
  bind_rows(macnamara2022 %>% mutate(meta_id = "macnamara2022", es_metric = "SMD")) %>%
  bind_rows(quigley2022 %>% mutate(meta_id = "quigley2022", es_metric = "SMD")) %>% 
  bind_rows(gerwig2021 %>% mutate(meta_id = "gerwig2021", es_metric = "Correlations")) %>%
  bind_rows(michels2021 %>% mutate(meta_id = "michels2021", es_metric = "Correlations")) %>%
  bind_rows(rouy2021 %>% mutate(meta_id = "rouy2021", es_metric = "SMD")) %>%
  bind_rows(anglim2020 %>% mutate(meta_id = "anglim2020", es_metric = "Correlations")) %>% 
  bind_rows(hennessy2020 %>% mutate(meta_id = "hennessy2020", es_metric = "SMD")) %>%
  bind_rows(thielmann2020 %>% mutate(meta_id = "thielmann2020", es_metric = "Correlations")) %>%
  bind_rows(wiernik2019 %>% mutate(meta_id = "wiernik2019", es_metric = "Correlations")) %>%
  bind_rows(rtichie2018 %>% mutate(meta_id = "rtichie2018", es_metric = "SMD")) %>% 
  bind_rows(vonholzen2018 %>% mutate(meta_id = "vonholzen2018", es_metric = "SMD")) %>%
  bind_rows(burgoyne2016 %>% mutate(meta_id = "burgoyne2016", es_metric = "Correlations")) %>%

#TO EXCLUDE. No clear effect-size metric
bind_rows(dora2023 %>% mutate(meta_id = "dora2023", es_metric = "Individual Person Data")) %>%



METADAT
* = psychology
#TO INCLUDE. All these report a clear yi =  effect-size metric, or a clear mention to effect-size metric (Ready for robma)
*metadat = aloe2013 %>% mutate(meta_id = "aloe2013", es_metric = "r-squared") %>% 
*bind_rows(bangertdrowns2004 %>% mutate(meta_id = "bangertdrowns2004", es_metric = "SMD")) %>%
*bind_rows(kalaian1996 %>% mutate(meta_id = "kalaian1996", es_metric = "SMD")) %>%
*bind_rows(knapp2017 %>% mutate(meta_id = "knapp2017", es_metric = "SMD")) %>%
*bind_rows(konstantopoulos2011 %>% mutate(meta_id = "konstantopoulos2011", es_metric = "SMD")) %>%
*bind_rows(lehmann2018 %>% mutate(meta_id = "lehmann2018", es_metric = "SMD")) %>%
*bind_rows(mccurdy2020 %>% mutate(meta_id = "mccurdy2020", es_metric = "RMD")) %>%
*bind_rows(michael2013 %>% mutate(meta_id = "michael2013", es_metric = "RMD")) %>%
*bind_rows(raudenbush1985 %>% mutate(meta_id = "raudenbush1985", es_metric = "SMD")) %>%
*bind_rows(assink2016 %>% mutate(meta_id = "assink2016", es_metric = "SMD")) %>%
*bind_rows(lopez2019 %>% mutate(meta_id = "lopez2019", es_metric = "SMC")) %>% #SMC "diff numeric standardized mean change"


#TO INCLUDE? Ask Ben
*bind_rows(molloy2014 %>% mutate(meta_id = "molloy2014", es_metric = "ZCOR")) %>% #"r-to-z transformed correlations and corresponding sampling variance
*bind_rows(mcdaniel1994 %>% mutate(meta_id = "mcdaniel1994", es_metric = "ZCOR")) %>% #"calculate r-to-z transformed correlations and corresponding sampling variances"
*bind_rows(tannersmith2016 %>% mutate(meta_id = "tannersmith2016", es_metric = "ZCOR")) %>% #"yi numeric r-to-z transformed correlation coefficient"
*bind_rows(cohen1981 %>% mutate(meta_id = "cohen1981", es_metric = "ZCOR")) %>% ""#calculate r-to-z transformed correlations and corresponding sampling variances"
*bind_rows(crede2010 %>% mutate(meta_id = "crede2010", es_metric = "correlation coefficient")) %>% #calculate r-to-z transformed correlations and corresponding sampling variances



#TO EXCLUDE. No explicit mention to yi = effect-size metric, or ri = ;inferred these from code and "concepts" section
  *bind_rows(bonett2010 %>% mutate(meta_id = "bonett2010", es_metric = "Cronbach alpha")) %>% #measures internal consistency of different ethnic groups responding to a questionnaire
  *bind_rows(hasselblad1998 %>% mutate(meta_id = "hasselblad1998", es_metric = "OR")) %>% #no exlpicit yi but uses odd ratios in code
  *bind_rows(linde2016 %>% mutate(meta_id = "linde2016", es_metric = "OR")) %>%
  *bind_rows(landenberger2005 %>% mutate(meta_id = "landenberger2005", es_metric = "Log OR")) %>% #as extrcated from R code, no explicit mention
*bind_rows(linde2015 %>% mutate(meta_id = "linde2015", es_metric = "OR")) %>% #no yi mention, but says "odds ratio was used as effect measure"
  *bind_rows(bourassa1996 %>% mutate(meta_id = "bourassa1996", es_metric = "OR")) %>%  #says explictly OR is the effect-size metric, but used Log of OR in code
  *bind_rows(debruin2009 %>% mutate(meta_id = "debruin2009", es_metric = "PR")) %>% #as mentioned in 'concepts' and code it is PR (proportions), but no explicit mentions
  *bind_rows(linde2005 %>% mutate(meta_id = "linde2005", es_metric = "RR")) %>% # as mentioned in "concept" and code it is RR (risk ratios), but no explicit mention


#TO EXCLUDE.As ri = effect size metric, no m
*bind_rows(bakdash2021 %>% mutate(meta_id = "bakdash2021", es_metric = "z-transformed correlation coefficient")) %>% #"es.z numeric z-transformed correlation coefficient; includes ghost results (disclosed and undisclosed non"
*bind_rows(craft2003 %>% mutate(meta_id = "craft2003", es_metric = "correlation coefficient")) %>%


