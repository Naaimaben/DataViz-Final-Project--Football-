data_set <- read.csv("goalscorers.csv",dec=",")
#View(data_set)
data_set <- goalscorers

#install.packages('ggplot2')
# install.packages("dplyr")
# install.packages("scales")
library(dplyr)
library(ggplot2)

# Data transformation
df <- data_set %>% 
  group_by(penalty) %>% # Variable to be transformed
  count() %>% 
  ungroup() %>% 
  mutate(perc = `n` / sum(`n`)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc))


pie <- ggplot(df, aes(x = "", y = perc, fill = penalty))+
  geom_bar(width = 1,stat="identity")+
  coord_polar(theta = "y", start = 0)+
  theme_void()+
  labs(title ="Penlaties scored",
       fill  = "scored or not" )+
  geom_text(aes(label = labels), position = position_stack(vjust = 0.5))
pie
