#### load required libraries ####
library(ggplot2)
library(dplyr)

#### load data ####
df <- read.csv("Metadata.csv",
               blank.lines.skip = TRUE,
               stringsAsFactors = FALSE)

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
  mutate(condratio=Conductivity/temp) %>% 
  summarise(mean.ph = mean(ph),
            mean.d2 = mean(Diversity...D2),
            sd.ph = sd(ph),
            sd.d2 = sd(Diversity...D2),
            avelog10.celldens = mean(log10(Cell.density..cells.mL.)),
            mean.condrat = mean(condratio))


#### join data sets ####
physicochem <- df %>% 
  select(sample_title,temp,ph,Conductivity)
diversity <- df %>% 
  select(sample_title,contains("Diversity"))

physicodiversity <- dplyr::full_join(physicochem,
                                     diversity,
                                     by="sample_title")
df.nona <- na.exclude(df)
na.omit()
rowSums(is.na(df))
dim(df)

#### combining dplyr and ggplot2 ####

p1 <- ggplot(data = df, aes(x = Timepoint,y = Cell.density..cells.mL., fill = Cell.density..cells.mL.)) +
  geom_point(shape = 21, size = 4)

df.2 <- df %>% filter(Reactor.cycle==2)

p2 <- df %>% filter(Reactor.cycle==2) %>% 
  ggplot(aes(x = Timepoint,y = Cell.density..cells.mL., fill = Cell.density..cells.mL.)) +geom_point(shape = 21, size = 4)

p2 + 