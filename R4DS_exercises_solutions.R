

## DATA VISUALIZTION 

####################################3.2.4
###################################
library(tidyverse)

#displ = engine size
#hwy = car's fuel efficiency on highway

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

str(mpg)
# plot city and hwy miles per gallon by type of car
mpg %>% 
  ggplot(aes(x = cty,y = hwy, color = class)) + 
  geom_point()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = class)) +
  geom_point() 
  
  


library(tidyverse)




ggplot(data = mpg)

nrow(mpg)
ncol(mpg)
glimpse(mpg)

?mpg
#The ggplot() function creates the background of the plot,
  #but since no layers were specified with geom function, nothing is drawn.
#4 
mpg %>% 
  ggplot(aes(hwy,cyl)) +
  geom_point()

# OR
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = cyl))

#scatter of class vs drive-- no continuous between front wheel/rear wheel drive and 
    # type of car 
# these are  categorical variables - want a bar chart 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))

## BETTER FOR CLASS AND DRIVE 
mpg %>% 
  select(class, drv) %>% 
  map(table)
library(purrr)

mpg %>% 
  ggplot(aes(class, fill = drv)) +
  geom_bar(position = 'dodge') +
  labs(fill = 'Drive') +
  theme(legend.position = "top")

ggplot(mpg, aes(x = class, y = drv)) +
  geom_count()

mpg %>% 
  count(class, drv) %>% 
  ggplot(aes(x = class, y = drv, fill = n)) +
  geom_tile()
## THEN DO PLOT OF CATEGORICAL VARIABLES
mpg %>%
  count(class, drv) %>%
  complete(class, drv, fill = list(n = 0L)) %>%
  ggplot(aes(x = class, y = drv)) +
  geom_tile(mapping = aes(fill = n))
  

# bigger engine size = lower fuel efficency
  
mpg %>%
  count(class, drv) %>%
  complete(class, drv, fill = list(n = 0L)) %>%
  View

####################################3.3.1
###################################
#1) If we want to set the aethetic property manually to have a parituclar appearance, 
  #we need to do so outside of the aes() fxn/mapping argument and
      # as it's own argument of geom_point, which  is the place where we 
    # map properties of aethetics to variables 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = 1:234))

#The argumentcolour = "blue" is included within the mapping argument, and as such, it is treated as an aesthetic, which is a mapping between a variable and a value.

#2) Which variables in mpg are categorical, which are continuous? 

glimpse(mpg)
mpg %>% 
  map(typeof)

#3) Map a continuous variable ot color, size, and shape 

mpg %>% 
  ggplot(mapping = aes(x = cty, y = hwy)) +
  geom_point(mapping = aes(color = displ)) +
  scale_colour_gradient(low = "darkolivegreen1", high = "darkolivegreen")

# remember BORDER = COLOR = STROK
    #INSIDE = FILL = SIZE

##HOW DO AESTHETICS BEHAVE DIFFERENT FOR CATEGORICAL VS CONTINUOUS VARS
##Instead of using discrete colors, the continuous variable uses a scale that varies from a light to dark blue color.

#4) 
mpg %>% 
  ggplot(mapping = aes(x = displ, y = hwy, size = displ)) +
  geom_point()

#5) STROKE AESTHETIC 
# stroke controls size of border color 
sizes <- expand.grid(size = (0:3) * 2, stroke = (0:3) * 2)
ggplot(sizes, aes(size, stroke, size = size, stroke = stroke)) + 
  geom_abline(slope = -1, intercept = 6, colour = "white", size = 6) + 
  geom_point(shape = 21, fill = "red") +
  scale_size_identity()


mpg %>% 
  ggplot(mapping = aes(x = displ, y = hwy)) +
  geom_point(fill = 'red', size = 2, color = 'blue',stroke = 3)

# stroke aesthetic works with geom_point shapes that have EITHER
# a border(color = stroke), or inside  (fill = size )

#6) What happens if you map an aesthetic to something other than a variable name, 
#like aes(colour = displ < 5)

?mpg
ggplot(mpg, aes(x = displ, y = hwy, color = displ < 5)) +
  geom_point() +
  labs(color = "Disply < 5")

ggplot(mpg, aes(x = displ, y = hwy, color = displ < 5)) +
  geom_point() +
  labs(color = "Disply < 5") + 
  theme(legend.title = element_text(color = 'blue'))

################################### 3.5.1
###################################

#1)  facet on continuous 
#The continuous variable is converted to a categorical variable, and the plot contains a facet for each distinct value.
ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~cty) # makes a facet of revery value of continuous

#instead
ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty)) 

#2) empty cells  in facet_grid
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

#3) 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#4)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) 
# advantages - everything on consisten y axies, see each individuall 
# disadvantages vs color - to many facets

#5)
# arguments for controlling layout of individuals panels: 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~cyl, switch = 'x')

# Use the `labeller` option to control how labels are printed:
### TREATS THE COMBINATION AS ONE FACET OF LEVEL 
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(c("cyl", "drv"), labeller = "label_both")

### TREATED THEM AS TWO FACETS 
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_grid(cyl ~ drv, labeller = "label_both")

?facet_wrap

#6) 
# varaible with mroe unique levels = columns 
## so rows are wider? 

################################### 3.6.1
###################################

#1) geom_line
# geom_boxplot
?geom_boxplot
#geom_histogram
geom_area()

#2) 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

#3) 
?geom_bar

#4) Adds a standard error bar

#5) no! the geoms will inherit both the supplied 
  # variable to the data argument and aes fxn in ggplot global fxn unless we 
    #specify otherwise
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))


#6) 
 
#plot 1 

p1 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
p1
#plot 2
p2 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv),se = FALSE) 

#plot 3 
ggplot(mpg, aes(displ, hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

#plot 4
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(se = FALSE)

#plot 5 

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  geom_smooth(aes(linetype = drv),se = FALSE)


#plot 6

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(fill = drv), color = 'white',shape = 21, size = 4) 

# ANSWER
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))


layer_data(plot5)

####3
p <- ggplot(mpg, aes(class, hwy))
p + geom_boxplot()
p + geom_boxplot() + geom_jitter(width = 0.2)
p + geom_boxplot() + coord_flip()
?geom_point

ggplot(mpg, aes(cty, hwy)) + geom_jitter(width = 0.5, height = 0.5)

ggplot(mpg, aes(class, cty, fill = drv)) +
  geom_area()

set.seed(345)
Sector <- rep(c("S01","S02","S03","S04","S05","S06","S07"),times=7)
Year <- as.numeric(rep(c("1950","1960","1970","1980","1990","2000","2010"),each=7))
Value <- runif(49, 10, 100)
data <- data.frame(Sector,Year,Value)

ggplot(data, aes(x=Year, y=Value, fill=Sector)) + 
  geom_area()


################################### 3.7.1
###################################

#1) 


