library(leaflet)
library(htmltools)
library(htmlwidgets)
library(dplyr)

heatPlugin <- htmlDependency("Leaflet.heat", "99.99.99",
                             src = c(href = "http://leaflet.github.io/Leaflet.heat/dist/"),
                             script = "leaflet-heat.js"
)

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, list(plugin))
  map
}

leaflet() %>% addTiles() %>%
  fitBounds(min(quakes$long), min(quakes$lat), max(quakes$long),     max(quakes$lat)) %>%
  registerPlugin(heatPlugin) %>%
  onRender("function(el, x, data) {
           data = HTMLWidgets.dataframeToD3(data);
           data = data.map(function(val) { return [val.lat, val.long, val.mag*100]; });
           L.heatLayer(data, {radius: 25}).addTo(this);
           }", data = quakes %>% select(lat, long, mag))




## INITIALIZE
library("leaflet")
library("data.table")
library("sp")
library("rgdal")
# library("maptools")
library("KernSmooth")

inurl <- "https://data.cityofchicago.org/api/views/22s8-eq8h/rows.csv?accessType=DOWNLOAD"
infile <- "Crime_-_Car_Thefts_first_6_months_of_2016.csv"

## LOAD DATA
## Also, clean up variable names, and convert dates
if(!file.exists(infile)){
  download.file(url = inurl, destfile = infile)
}
dat <- data.table::fread(infile)
setnames(dat, tolower(colnames(dat)))
setnames(dat, gsub(" ", "_", colnames(dat)))
dat <- dat[!is.na(longitude)]
dat[ , date := as.IDate(date, "%m/%d/%Y")]

## MAKE CONTOUR LINES
## Note, bandwidth choice is based on MASS::bandwidth.nrd()
kde <- bkde2D(dat[ , list(longitude, latitude)],
              bandwidth=c(.0045, .0068), gridsize = c(100,100))
CL <- contourLines(kde$x1 , kde$x2 , kde$fhat)

## EXTRACT CONTOUR LINE LEVELS
LEVS <- as.factor(sapply(CL, `[[`, "level"))
NLEV <- length(levels(LEVS))

## CONVERT CONTOUR LINES TO POLYGONS
pgons <- lapply(1:length(CL), function(i)
  Polygons(list(Polygon(cbind(CL[[i]]$x, CL[[i]]$y))), ID=i))
spgons = SpatialPolygons(pgons)

## Leaflet map with polygons
leaflet(spgons) %>% addTiles() %>% 
  addPolygons(color = heat.colors(NLEV, NULL)[LEVS])


## Leaflet map with points and polygons
## Note, this shows some problems with the KDE, in my opinion...
## For example there seems to be a hot spot at the intersection of Mayfield and
## Fillmore, but it's not getting picked up.  Maybe a smaller bw is a good idea?

leaflet(spgons) %>% addTiles() %>%
  addPolygons(color = heat.colors(NLEV, NULL)[LEVS]) %>%
  addCircles(lng = dat$longitude, lat = dat$latitude,
             radius = .5, opacity = .2, col = "blue")


