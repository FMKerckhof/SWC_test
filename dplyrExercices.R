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

#### Group_by ####
meanph <- df %>% group_by(Reactor.phase) %>% 
                  summarise(mean.ph = mean(ph),
                            mean.d2 = mean(Diversity...D2),
                            sd.ph = sd(ph))

# Challenge
# Generate the above summary for reactor cycle 2 and add
# standard deviation of the d2 and the mean log10
# transformed cell density
meanph <- df %>%
  filter(Reactor.cycle == 2) %>% 
  group_by(Reactor.phase) %>% 
  summarise(mean.ph = mean(ph),
            mean.d2 = mean(Diversity...D2),
            sd.ph = sd(ph),
            sd.d2 = sd(Diversity...D2),
            avelog10.celldens = mean(log10(Cell.density..cells.mL.)))