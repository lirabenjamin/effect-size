library(tidyverse)

# read csv with delimiter
read_csv2("data/scimago - psych.csv") %>% 
  select(Rank, Title,Areas) %>%
  mutate(Title = tolower(Title)) %>%
  # 283 journals
  filter(!
    (
      str_detect(Title, "psychology")|
      str_detect(Title, "psychological")|
      str_detect(Title, "psychologist")|
      str_detect(Title, "personality")|
      str_detect(Title, "behavior")|
      str_detect(Title, "behaviour")|
      str_detect(Title, "behavioral")|
      str_detect(Title, "behavioural")|
      str_detect(Title, "cognition")|
      str_detect(Title, "psycholinguistic")|
      str_detect(Title, "psychologica")|
      str_detect(Title, "emotion")|
      str_detect(Title, "cognitive")
      )
  ) %>% 
  # 148 journals for psych not included
  gt::gt()
