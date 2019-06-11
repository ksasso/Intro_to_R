
# SEARCH STUDY GUIDE FOR - 
    # ADD IN  - to see where my content could be supplemented for teaching
    # USE  - go back and use in cardinal code 
        # glimpse() ACROSS MULTIPLE DFs USING A MAP FUNCITON  - DONE 
        # geom_tile or geom_count to do visuals of cateogircal variable - DONE 
        # complete to add in 0s for missing combos of date-event - DONE 

## MUST REVIEW

    ### PURRR SESSIONT
  #  https://jrnold.github.io/r4ds-exercise-solutions/data-visualisation.html#exercise-3.2.5
    
    ###TIDY EVAL SESSION
    
    ## ggplot 2 session (themes, legends, titles)
        # theme 
        # geom_count
        # LEGENDS
        # SECTION 3.3 Good aes() options for 3rd variables - DIFFERENT AESTHETICS 
            # #5) STROKE AESTHETIC
        #fct_reorder
    # stroke aesthetic works with geom_point shapes that have EITHER
    # a border(color = stroke), or inside color (fill = size )
    
  
    
    ## VARIABLE TYPES



#EXAMPLES
# https://datacarpentry.org/R-genomics/04-dplyr.html


### TOP FUNCTION TO START USING 

?map # fxn over multiple columns 
?geom_count # plotting categorical variables - does counting for you 
?geom_tile # plotting categorical variables - need to do counting
?count
?add_count
?gather
?filter_at
?filter_if
?expand.grid
?complete # adds in missing combos of things
?fct_reorder # use in ggplot2 
# my_data %>%
#   count(my_column, sort = TRUE) %>%
#   mutate(Percent = n / sum(n)) %>%
#   top_n(15, n) %>%
#   ggplot(aes(fct_reorder(my_column, n), Percent) +
#            geom_col() +
#            coord_flip() +
#            scale_y_continuous(labels = scales::percent_format()) +
#            labs(x = NULL, y = “% of examples”)
?facet_grid # more than 1 variable. drv ~ cyl  -- ROWS ~ COLUMNS (BY Y ~ BY X)  - use . to manage how facets appear (r vs col)
?facet_wrap # 1 variable (~ var) OR TWO facet_wrap(c("cyl", "drv"), labeller = "label_both") TO CREATE ONE FACET PER COMBO
geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) # group aesthetic!!



##################################### QUESTIONS FOR EZGI 
###################################

ggplot(mpg) + 
  geom_smooth(aes(displ, hwy, linetype  = drv, color = drv)) +
  geom_point(mpg, aes(displ, hwy, color = drv),
             inherit.aes = FALSE)

#BUT THIS WORKS
ggplot(mpg) + 
  geom_smooth(aes(displ, hwy, linetype  = drv, color = drv)) +
  geom_point(aes(displ, hwy, color = drv),
             inherit.aes = FALSE)
 #OR 
ggplot(mpg) + 
  geom_smooth(aes(displ, hwy, linetype  = drv, color = drv)) +
  geom_point(data = mpg, aes(displ, hwy, color = drv),
             inherit.aes = FALSE)

# or surprisingyl this 
ggplot(mpg) + 
  geom_smooth(aes(displ, hwy, linetype  = drv, color = drv)) +
  geom_point(aes(displ, hwy, color = drv))

## could've' dropped inherit.aes ? because actually if I kept them all it'd be fine?? surprised that worked


