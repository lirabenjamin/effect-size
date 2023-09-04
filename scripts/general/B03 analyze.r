data = read_csv("data/string_counts.csv")

# Calculate confidence intervals
conf_int <- function(n, N) {
  test <- binom.test(n, N)
  return(test$conf.int)
}

conf_int(1, 10)[2]

data %>%
  pivot_longer(-c("file_name", "year"), names_to = "type", values_to = "value") %>% 
  count(type, value) %>% 
  group_by(type) %>%
  mutate(
    proportion = n/sum(n),
    conf = map2(n, sum(n), conf_int)
  ) %>%
  unnest_wider(conf, names_sep = ".") %>%
  filter(value) %>%
  ungroup() %>%
  mutate(type = fct_reorder(type, proportion)) %>%
  ggplot(aes(type, proportion, fill = type))+
  geom_col()+
  geom_errorbar(aes(ymin = conf.1, ymax = conf.2), width = 0.2)+
  geom_text(aes(label = scales::percent(proportion)), hjust = -.35)+
  guides(fill = "none")+
  coord_flip(ylim = c(0,1))+
  scale_y_continuous(labels = scales::percent)+
  labs(x = NULL, y = "Proportion", title = "Proportion of strings by type", caption = "Confidence intervals are 95%\nN = 1,227 meta-analyses published between 2018 and 2023")
ggsave("output/B_proportion_by_type.png", width = 6, height = 4)

data %>%
  pivot_longer(-c("file_name", "year"), names_to = "type", values_to = "value") %>%
  count(year, type, value) %>% 
  group_by(year, type) %>%
  mutate(
    proportion = n/sum(n),
    conf = map2(n, sum(n), conf_int)
  ) %>%
  unnest_wider(conf, names_sep = ".")  %>%
  filter(value) %>% 
  ggplot(aes(year, proportion, color = type))+
  geom_line()+
  geom_hline(aes(yintercept = proportion, color = type), data = . %>% group_by(type) %>% slice(1), linetype = 2, alpha = .3)+
  geom_ribbon(aes(ymin = conf.1, ymax = conf.2, fill = type), alpha = .2, color = NA)+
  coord_cartesian(ylim = c(0,1))+
  scale_y_continuous(labels = scales::percent)+
  labs(color = NULL, fill = NULL,  x = NULL, y = "Proportion", title = "Proportion of strings by type and year", caption = "Confidence intervals are 95%\nN = 1,227 meta-analyses published between 2018 and 2023")
ggsave("output/B_proportion_by_type_year.png", width = 6, height = 4)

data %>% count(egger)

data %>% 
  pivot_longer(`publication bias`:robma) %>% 
  group_by(name) %>%
  nest() %>%
  mutate(
    glm = map(data, glm, family = 'binomial', formula = value ~ year),
    tidy = map(glm, broom::tidy)
  )  %>% 
  unnest(tidy) %>% 
  filter(term == "year") %>% 
  mutate(
    OR = exp(estimate),
    ` ` = Ben::codeps(p.value)
  ) %>% 
  arrange(desc(OR)) %>% 
  select(name, logodds = estimate, std.error, OR, p.value, ` `) %>%
  ungroup() %>%
  gt::gt() %>%
  gt::fmt_auto() %>% 
  gt::tab_header(
    title = gt::md("**Logistic regressions predicting string presence from logistic regression models**")
  ) %>%
  gt::tab_footnote(gt::md("*N* = 1,227 meta-analyses published between 2018 and 2023")) %>%
  gt::gtsave("output/B_logistic_regression.png")

# merge 2 images together
library(magick)
image1 <- image_read("output/B_proportion_by_type_year.png")
image2 <- image_read("output/B_logistic_regression.png")

# Combine the images
combined_image <- image_append(c(image1, image2), stack = TRUE)

# Save the combined image
image_write(combined_image, "output/time_combined_image.png")
