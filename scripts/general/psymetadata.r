# install.packages("psymetadata")
# install.packages("metadat")
library(psymetadata)
library(metadat)

metadat::dat.aloe2013
metadat::dat.stowe2010

psymetadata::agadullina2018 %>% as_tibble()
psymetadata::aksayli2019 %>% as_tibble()
psymetadata::wibbelink2017 %>% as_tibble()
psymetadata::manylabs2018 %>% as_tibble()
psymetadata::spaniol2020 %>% as_tibble()
psymetadata::maccann2020 %>% as_tibble()


??psymetadata
