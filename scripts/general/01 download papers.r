library("httr")
library('gt')

df <- read_csv("data/scholar.csv")

df %>% filter(str_detect(Authors, "Sheeran")) %>% select(Title)

download = function(url, filename){
  GET(url, write_disk(filename, overwrite = TRUE))
}

df %>% 
  select(matches("URL")) %>% 
  head() %>%
  gt()

download(df$FullTextURL[2], "test.pdf")

df %>% 
  select(Authors, Title, Year, url = FullTextURL) %>%
  mutate(Title = str_replace(Title, "\\/", "-")) %>%
  filter(!is.na(url)) %>% 
  mutate(filename = glue("downloads/{Year}_{Title}.pdf")) %>% 
  mutate(download = map2(url, filename, download))