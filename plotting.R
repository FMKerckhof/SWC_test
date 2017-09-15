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
df$Cell.density..cells.mL.
p1 <- ggplot(data = df, aes(x = Timepoint,y = Cell.density..cells.mL., fill = Cell.density..cells.mL.)) +
  geom_point(shape = 21, size = 4)
p1
#If you run it like this, it gives the following message: Error in FUN(X[[i]], ...) : object 'Cell.density..cells.mL' not found
#It must be:
  
  p1 <-ggplot(data = df, aes(x = Timepoint, y = Cell.density..cells.mL.,
                             fill=Reactor.phase)) + geom_point(shape = 21, size=4)
p1   
p2 <- p1 + scale_y_log10()  # change y-axis to log-scale
p2

p3 <- p2 + facet_grid(~Reactor.cycle)
p3

p4 <- p2 + facet_grid(Reactor.phase~Reactor.cycle)
p4
## Right side
p5<-ggplot(data=df, aes(x=Timepoint , y=Diversity...D0, fill=Reactor.phase ))+
  geom_point(shape=21, size=5)
P6 <- p5 + facet_grid(~Reactor.phase)+theme_dark()
P6

### Middle side
############### conductivity ###### df <- read.csv("Metadata.csv",nrows=77) 

pp1 <- ggplot(data=df,aes(x= Timepoint,y=Conductivity,fill=Reactor.phase)) 
pp1 <- pp1 + geom_point(shape=21,size=4,alpha = 0.5) + theme_bw() +  geom_line(aes(color=Reactor.cycle)) # Facet it 
pp3 <- pp1 + facet_grid(~Reactor.cycle)  # how do i know whats in reactor phase unique(df$Reactor.phase) #plot alles in fucntie van reactor phase 
pp4 <- pp1 + facet_grid(Reactor.phase~Reactor.cycle) 
pp4

