library("httr")
library('gt')
library(glue)

df <- read_csv("data/psych_meta_18_23.csv")
df %>% count(is.na(FullTextURL))

df %>% filter(str_detect(Authors, "Sheeran")) %>% select(Title)

download = function(url, filename){
  GET(url, write_disk(filename, overwrite = TRUE))
}

df %>% 
  select(matches("URL")) %>% 
  head() %>%
  gt()

df %>% 
  select(Authors, Title, Year, url = FullTextURL) %>%
  mutate(Title = str_replace(Title, "\\/", "-")) %>%
  filter(!is.na(url)) %>% 
  mutate(filename = glue("data/downloads/{Year}_{Title}.pdf")) %>% 
  mutate(download = map2(url, filename, download))
