#### load required libraries ####
library(ggplot2)
library(dplyr)

#### load data ####
df <- read.csv("Metadata.csv")

mean(df[df$Reactor.phase == "Control", "ph"])
levels(df$Reactor.phase)

#### select ####
physicochem <- dplyr::select(df,ph,temp,Conductivity)
head(physicochem)

physicochem <- df %>% select(ph,temp,Conductivity)

physicochem.control <- df %>%
  filter(Reactor.phase == "Control") %>% 
  select(ph,temp,Conductivity)

# Challenge: select only the Diversity parameters 
# for reactor phase startup
diversity <- df %>% 
  filter(Reactor.phase == "Startup") %>%
  select(contains("Diversity"))