library("httr")

df <- read_csv("data/scholar.csv")

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
  mutate(filename = glue("test_downloads/{Year}_{Title}.pdf")) %>% 
  mutate(download = map2(url, filename, download))