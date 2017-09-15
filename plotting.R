#### read in data ####
df <- read.csv("Metadata.csv")
# which variables?
str(df)
# Start plotting
library("ggplot2")

# Make first plot
ggplot(data=df,aes(x=Timepoint,y=ph)) +
  geom_point()
#check the variable names
names(df)

ggplot(data=df,aes(x=Timepoint,y=ph,
                   fill=Reactor.cycle)) +
  geom_point(shape=21)
# change the Reactor.cycle to a factor variable
df$Reactor.cycle <- factor(df$Reactor.cycle)
class(df$Reactor.cycle)
ggplot(data=df,aes(x=Timepoint,y=ph,
                   fill=Reactor.cycle)) +
  geom_point(shape=21, size=4)

ggplot(data=df,aes(x=Timepoint,y=temp,
                   fill=Reactor.cycle)) +
  geom_point(shape=21, size=4)

# Store ggplot object
p1 <- ggplot(data=df,aes(x=Timepoint,y=temp,
                         fill=Reactor.phase))
p1 <- p1 + geom_point(shape=21,size=4,alpha=.5)
p2 <- p1 + theme_bw() + geom_line()

# facetting (really powerful!)
p3 <- p2 + facet_grid(~Reactor.cycle)
p3

# use two factors
# how to inspect the Reactor phase factor?
df$Reactor.phase
levels(df$Reactor.phase)
p4 <- p2 + facet_grid(Reactor.phase~Reactor.cycle)
p4

# Color based upon reactor phase?
p4 + geom_line(aes(color=Reactor.phase))

# Challenge time
