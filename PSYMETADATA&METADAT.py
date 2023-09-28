PSYMETADATA
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
  bind_rows(manylabs2018 %>% mutate(meta_id = "manylabs2018", es_metric = "r" "d")) %>%
  mutate(age = as.character(age)) %>%
  bind_rows(noble2019 %>% mutate(meta_id = "noble2019", es_metric = "g")) %>%
  bind_rows(nuijten2020 %>% mutate(meta_id = "nuijten2020", es_metric = "z")) %>%
  bind_rows(sala2019 %>% mutate(meta_id = "sala2019", es_metric = "g")) %>%
  bind_rows(schroeder2020 %>% mutate(meta_id = "schroeder2020", es_metric = "g")) %>%
  mutate(es_id = as.character(es_id), study_id = as.character(study_id)) %>%
  bind_rows(spaniol2020 %>% mutate(meta_id = "spaniol2020", es_metric = "g", es_id = as.character(es_id))) %>%
  bind_rows(stasielowicz2019a %>% mutate(meta_id = "stasielowicz2019a", es_metric = "r", es_id = as.character(es_id), study_id = as.character(study_id), age = as.character(age), pub_type = as.character(pub_type))) %>%
  bind_rows(stasielowicz2019b %>% mutate(meta_id = "stasielowicz2019b", es_metric = "r", es_id = as.character(es_id), study_id = as.character(study_id), age = as.character(age), pub_type = as.character(pub_type))) %>%
  bind_rows(stasielowicz2020 %>% mutate(meta_id = "stasielowicz2020", es_metric = "r")) %>%
  bind_rows(steffens2020 %>% mutate(meta_id = "steffens2020", es_metric = "z", es_id = as.character(es_id), study_id = as.character(study_id), age = NA, pub_type = NA, design = as.character(design), published = as.character(published))) %>%
  bind_rows(stramaccia2021 %>% mutate(meta_id = "stramaccia2021", es_metric = "d", es_id = as.character(es_id), study_id = as.character(study_id))) %>%
  bind_rows(wibbelink2017 %>% mutate(meta_id = "wibbelink2017", es_metric = "d", es_id = as.character(es_id), study_id = as.character(study_id)))


METADAT
* = psychology

*metadat = aloe2013 %>% mutate(meta_id = "aloe2013", es_metric = "PCOR") %>% 
  *bind_rows(assink2016 %>% mutate(meta_id = "assink2016", es_metric = "SMD")) %>%
  *bind_rows(bakdash2021 %>% mutate(meta_id = "bakdash2021", es_metric = "SMCC")) %>% 
  *bind_rows(bangertdrowns2004 %>% mutate(meta_id = "bangertdrowns2004", es_metric = "SMD")) %>%
  *bind_rows(bonett2010 %>% mutate(meta_id = "bonett2010", es_metric = "ARAW")) %>%
  *bind_rows(bourassa1996 %>% mutate(meta_id = "bourassa1996", es_metric = "OR")) %>%
  *bind_rows(cohen1981 %>% mutate(meta_id = "cohen1981", es_metric = "ZCOR")) %>% 
  *bind_rows(craft2003 %>% mutate(meta_id = "craft2003", es_metric = "ZCOR")) %>%
  *bind_rows(crede2010 %>% mutate(meta_id = "crede2010", es_metric = "ZCOR")) %>%
  *bind_rows(kalaian1996 %>% mutate(meta_id = "kalaian1996", es_metric = "SMD")) %>%
  *bind_rows(knapp2017 %>% mutate(meta_id = "knapp2017", es_metric = "SMD")) %>%
  *bind_rows(debruin2009 %>% mutate(meta_id = "debruin2009", es_metric = "PR")) %>% 
  *bind_rows(hasselblad1998 %>% mutate(meta_id = "hasselblad1998", es_metric = "OR")) %>%
  *bind_rows(konstantopoulos2011 %>% mutate(meta_id = "konstantopoulos2011", es_metric = "SMD")) %>%
  *bind_rows(landenberger2005 %>% mutate(meta_id = "landenberger2005", es_metric = "OR")) %>% 
  *bind_rows(lehmann2018 %>% mutate(meta_id = "lehmann2018", es_metric = "SMD")) %>%
  *bind_rows(linde2005 %>% mutate(meta_id = "linde2005", es_metric = "RR")) %>%
  *bind_rows(linde2015 %>% mutate(meta_id = "linde2015", es_metric = "OR")) %>%
  *bind_rows(linde2016 %>% mutate(meta_id = "linde2016", es_metric = "OR")) %>%
  *bind_rows(lopez2019 %>% mutate(meta_id = "lopez2019", es_metric = "SMC")) %>%
  *bind_rows(mccurdy2020 %>% mutate(meta_id = "mccurdy2020", es_metric = "RMD")) %>%
  *bind_rows(mcdaniel1994 %>% mutate(meta_id = "mcdaniel1994", es_metric = "ZCOR")) %>%
  *bind_rows(michael2013 %>% mutate(meta_id = "michael2013", es_metric = "RMD")) %>%
  *bind_rows(molloy2014 %>% mutate(meta_id = "molloy2014", es_metric = "ZCOR")) %>%
  *bind_rows(raudenbush1985 %>% mutate(meta_id = "raudenbush1985", es_metric = "SMD")) %>%
  *bind_rows(tannersmith2016 %>% mutate(meta_id = "tannersmith2016", es_metric = "ZCOR")) %>%

  bind_rows(anand1999 %>% mutate(meta_id = "anand1999", es_metric = "OR")) %>% 
  bind_rows(axfors2021 %>% mutate(meta_id = "axfors2021", es_metric = "OR")) %>%
  bind_rows(baker2009 %>% mutate(meta_id = "baker2009", es_metric = "OR")) %>%
  bind_rows(baskerville2012 %>% mutate(meta_id = "baskerville2012", es_metric = "SMD")) %>% 
  bind_rows(bcg %>% mutate(meta_id = "bcg", es_metric = "RR")) %>%
  bind_rows(begg1989 %>% mutate(meta_id = "begg1989", es_metric = "RR")) %>%
  bind_rows(berkey1998 %>% mutate(meta_id = "berkey1998", es_metric = "RMD")) %>% 
  bind_rows(besson2016 %>% mutate(meta_id = "besson2016", es_metric = "SMD")) %>%
  bind_rows(bornmann2007 %>% mutate(meta_id = "bornmann2007", es_metric = "OR")) %>% 
  bind_rows(cannon2006 %>% mutate(meta_id = "cannon2006", es_metric = "OR")) %>%
  bind_rows(colditz1994 %>% mutate(meta_id = "colditz1994", es_metric = "RR")) %>%
  bind_rows(collins1985a %>% mutate(meta_id = "collins1985a", es_metric = "OR")) %>%
  bind_rows(collins1985b %>% mutate(meta_id = "collins1985b", es_metric = "OR")) %>% 
  bind_rows(curtis1998 %>% mutate(meta_id = "curtis1998", es_metric = "ROM")) %>% 
  bind_rows(dagostino1998 %>% mutate(meta_id = "dagostino1998", es_metric = "SMD")) %>%
  bind_rows(darnico2009 %>% mutate(meta_id = "damico2009", es_metric = "OR")) %>%
  bind_rows(dogliotti2014 %>% mutate(meta_id = "dogliotti2014", es_metric = "OR")) %>%
  bind_rows(dong2013 %>% mutate(meta_id = "dong2013", es_metric = "OR")) %>%
  bind_rows(dorn2007 %>% mutate(meta_id = "dorn2007", es_metric = "RR")) %>% 
  bind_rows(egger2001 %>% mutate(meta_id = "egger2001", es_metric = "OR")) %>%
  bind_rows(fine1993 %>% mutate(meta_id = "fine1993", es_metric = "OR")) %>%
  bind_rows(franchini2012 %>% mutate(meta_id = "franchini2012", es_metric = "RMD")) %>% 
  bind_rows(frank2008 %>% mutate(meta_id = "frank2008", es_metric = "OR")) %>%
  bind_rows(gibson2002 %>% mutate(meta_id = "gibson2002", es_metric = "RR")) %>%
  bind_rows(graves2010 %>% mutate(meta_id = "graves2010", es_metric = "RR")) %>% 
  bind_rows(gurusamy2011 %>% mutate(meta_id = "gurusamy2011", es_metric = "OR")) %>%
  bind_rows(hackshaw1998 %>% mutate(meta_id = "hackshaw1998", es_metric = "OR")) %>%
  bind_rows(hahn2001 %>% mutate(meta_id = "hahn2001", es_metric = "OR")) %>% 
  bind_rows(hannum2020 %>% mutate(meta_id = "hannum2020", es_metric = "PR")) %>%
  bind_rows(hart1999 %>% mutate(meta_id = "hart1999", es_metric = "RR")) %>%
  bind_rows(hartmannboyce2018 %>% mutate(meta_id = "hartmannboyce2018", es_metric = "RR")) %>% 
  bind_rows(hine1989 %>% mutate(meta_id = "hine1989", es_metric = "RD")) %>%
  bind_rows(ishak2007 %>% mutate(meta_id = "ishak2007", es_metric = "RMD")) %>%
  bind_rows(kearonl1998 %>% mutate(meta_id = "kearonl1998", es_metric = "OR")) %>% 
  bind_rows(laopaiboon2015 %>% mutate(meta_id = "laopaiboon2015", es_metric = "RR")) %>%
  bind_rows(laul1992 %>% mutate(meta_id = "laul1992", es_metric = "OR")) %>%
  bind_rows(lec2004 %>% mutate(meta_id = "lec2004", es_metric = "RR")) %>% 
  bind_rows(li2007 %>% mutate(meta_id = "li2007", es_metric = "OR")) %>%
  bind_rows(lim2014 %>% mutate(meta_id = "lim2014", es_metric = "ZCOR")) %>% 
  bind_rows(maire2019 %>% mutate(meta_id = "maire2019", es_metric = "SC")) %>%
  bind_rows(moura2021 %>% mutate(meta_id = "moura2021", es_metric = "ZCOR")) %>%
  bind_rows(nakagawa2007 %>% mutate(meta_id = "nakagawa2007", es_metric = "ZCOR")) %>%
  bind_rows(nielweise2007 %>% mutate(meta_id = "nielweise2007", es_metric = "OR")) %>% 
  bind_rows(nielweise2008 %>% mutate(meta_id = "nielweise2008", es_metric = "IRR")) %>%
  bind_rows(normand1999 %>% mutate(meta_id = "normand1999", es_metric = "RMD")) %>%
  bind_rows(obrien2003 %>% mutate(meta_id = "obrien2003", es_metric = "RR")) %>%
  bind_rows(pagliaro1992 %>% mutate(meta_id = "pagliaro1992", es_metric = "OR")) %>%
  bind_rows(pignon2000 %>% mutate(meta_id = "pignon2000", es_metric = "HR")) %>%
  bind_rows(pritz1997 %>% mutate(meta_id = "pritz1997", es_metric = "PR")) %>%
  bind_rows(riley2003 %>% mutate(meta_id = "riley2003", es_metric = "HR")) %>%
  bind_rows(senn2013 %>% mutate(meta_id = "senn2013", es_metric = "RMD")) %>%
  bind_rows(stowe2010 %>% mutate(meta_id = "stowe2010", es_metric = "RMD")) %>%
  bind_rows(vanhowel1999 %>% mutate(meta_id = "vanhowel1999", es_metric = "OR")) %>%
  bind_rows(viechtbauer %>% mutate(meta_id = "viechtbauer", es_metric = "OR")) %>%
  bind_rows(white2020 %>% mutate(meta_id = "white2020", es_metric = "ZCOR)) %>%
  bind_rows(woods2010 %>% mutate(meta_id = "woods2010", es_metric = "OR")) %>%
  bind_rows(yusuf1985 %>% mutate(meta_id = "yusuf1985", es_metric = "OR")) %>%


#OTHER OSF meta-analysis beyond May 2021

  *bind_rows(baglole2021 %>% mutate(meta_id = "baglole2021", es_metric = "SMD")) %>%
   #https://osf.io/sed6k
  *bind_rows(keinrath2021 %>% mutate(meta_id = "keinrath2021", es_metric = "z")) %>% 
   #https://osf.io/sed6k


#Legend for more uncommon effect size metrics
SMD: Standard mean deviation
OR: odds ratios
PCOR: (semi-)partial correlation coefficient
ZCOR: z-correlation
RR: Risk ratio
2-year disease-free survival rates: does not give metric
ROM: ratio of means
PR: proportions
RMD: Raw mean differences
RD: risk differences
SMC: Standarized mean changes
SC: spatial correlation
IRR: incidence rates
HR: hazard ratios
ARAW: raw alphas 
