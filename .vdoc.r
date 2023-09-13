# nolint start
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
knitr::include_graphics("output/B_proportion_by_type.png")
#
#
#
#
#
knitr::include_graphics("output/time_combined_image.png")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
library(tidyverse)
library(glue)
library(gt)

df <- read_csv("data/scholar.csv")

# unique journals
df %>% 
  mutate(Source = tolower(Source)) %>% count(Source) %>% arrange(desc(n))  %>% head(20) %>% gt::gt()

median_cite = median(df$Cites, na.rm = TRUE)
# cites
df %>% 
  ggplot(aes(Cites)) + 
  geom_histogram() +
  # add a vertical line at the mean
  geom_vline(aes(xintercept = median(Cites, na.rm = TRUE)),
             color = "red", linetype = "dashed", size = 1)+
  annotate("text",x = median_cite, y = 200, label = glue("Median = {median_cite}"), color = "red", hjust = -.1)+
  labs(y = NULL)


library("httr")
download = function(url, filename){
  GET(url, write_disk(filename, overwrite = TRUE))
}

df %>% 
  select(matches("URL")) %>% 
  head() %>%
  gt()

# df %>% 
#   select(Authors, Title, Year, url = FullTextURL) %>%
#   mutate(Title = str_replace(Title, "\\/", "-")) %>%
#   filter(!is.na(url)) %>% 
#   mutate(filename = glue("test_downloads/{Year}_{Title}.pdf")) %>% 
#   mutate(download = map2(url, filename, download))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
