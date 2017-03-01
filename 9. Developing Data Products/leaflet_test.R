library(leaflet)
data(quakes)

head(quakes)

str(quakes)

# explore histogram of mag and depth 
hist(quakes$mag) 
hist(quakes$depth)

# set color and radius for markers
quakes$mag_color <- as.factor(with(quakes , ifelse(mag>=4.0&mag<4.5 ,"Green" ,
                                         ifelse (mag>=4.5&mag<5.0 ,"Yellow" , "Red"))))

quakes$radius <- with(quakes , ifelse(depth>=0&depth<200 ,12 ,
                                                   ifelse (depth>=200&depth<500 ,6 , 2)))


# drow the map
leaflet(quakes) %>% addTiles() %>% addCircleMarkers(
    radius = quakes$radius,
    color = quakes$mag_color,
    stroke = FALSE, fillOpacity = 0.6
)
