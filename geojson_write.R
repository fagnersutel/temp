# NOT RUN {
# From a data.frame
## to points
library(geojsonio)
geojson_write(us_cities[1:2,], lat='lat', lon='long')

## to polygons
head(states)
geojson_write(input=states, lat='lat', lon='long',
              geometry='polygon', group="group")

## partial states dataset to points (defaults to points)
geojson_write(input=states, lat='lat', lon='long')

## Lists
### list of numeric pairs
poly <- list(c(-114.345703125,39.436192999314095),
             c(-114.345703125,43.45291889355468),
             c(-106.61132812499999,43.45291889355468),
             c(-106.61132812499999,39.436192999314095),
             c(-114.345703125,39.436192999314095))
geojson_write(poly, geometry = "polygon")

### named list
mylist <- list(list(latitude=30, longitude=120, marker="red"),
               list(latitude=30, longitude=130, marker="blue"))
geojson_write(mylist)

# From a numeric vector of length 2
## Expected order is lon, lat
vec <- c(-99.74, 32.45)
geojson_write(vec)

## polygon from a series of numeric pairs
### this requires numeric class input, so inputting a list will
### dispatch on the list method
poly <- c(c(-114.345703125,39.436192999314095),
          c(-114.345703125,43.45291889355468),
          c(-106.61132812499999,43.45291889355468),
          c(-106.61132812499999,39.436192999314095),
          c(-114.345703125,39.436192999314095))
geojson_write(poly, geometry = "polygon")

# Write output of geojson_list to file
res <- geojson_list(us_cities[1:2,], lat='lat', lon='long')
class(res)
geojson_write(res)

# Write output of geojson_json to file
res <- geojson_json(us_cities[1:2,], lat='lat', lon='long')
class(res)
geojson_write(res)

# From SpatialPolygons class
library('sp')
poly1 <- Polygons(list(Polygon(cbind(c(-100,-90,-85,-100),
                                     c(40,50,45,40)))), "1")
poly2 <- Polygons(list(Polygon(cbind(c(-90,-80,-75,-90),
                                     c(30,40,35,30)))), "2")
sp_poly <- SpatialPolygons(list(poly1, poly2), 1:2)
geojson_write(sp_poly)

# From SpatialPolygonsDataFrame class
sp_polydf <- as(sp_poly, "SpatialPolygonsDataFrame")
geojson_write(input = sp_polydf)

# From SpatialGrid
x <- GridTopology(c(0,0), c(1,1), c(5,5))
y <- SpatialGrid(x)
geojson_write(y)

# From SpatialGridDataFrame
sgdim <- c(3,4)
sg <- SpatialGrid(GridTopology(rep(0,2), rep(10,2), sgdim))
sgdf <- SpatialGridDataFrame(sg, data.frame(val = 1:12))
geojson_write(sgdf)

# From SpatialRings
library(rgeos)
r1 <- Ring(cbind(x=c(1,1,2,2,1), y=c(1,2,2,1,1)), ID="1")
r2 <- Ring(cbind(x=c(1,1,2,2,1), y=c(1,2,2,1,1)), ID="2")
r1r2 <- SpatialRings(list(r1, r2))
geojson_write(r1r2)

# From SpatialRingsDataFrame
dat <- data.frame(id = c(1,2), value = 3:4)
dat
r1r2df <- SpatialRingsDataFrame(r1r2, data = dat)
r1r2df
geojson_write(r1r2df)

# From SpatialPixels
library("sp")
pixels <- suppressWarnings(SpatialPixels(SpatialPoints(us_cities[c("long", "lat")])))
summary(pixels)
geojson_write(pixels)

# From SpatialPixelsDataFrame
library("sp")
pixelsdf <- suppressWarnings(
  SpatialPixelsDataFrame(points = canada_cities[c("long", "lat")], data = canada_cities)
)
geojson_write(pixelsdf)

# From SpatialCollections
library("sp")
poly1 <- Polygons(list(Polygon(cbind(c(-100,-90,-85,-100), c(40,50,45,40)))), "1")
poly2 <- Polygons(list(Polygon(cbind(c(-90,-80,-75,-90), c(30,40,35,30)))), "2")
poly <- SpatialPolygons(list(poly1, poly2), 1:2)
coordinates(us_cities) <- ~long+lat
dat <- SpatialCollections(points = us_cities, polygons = poly)
dat <- SpatialCollections(polygons = poly)
geojson_write(dat)
# }
# NOT RUN {
# From sf classes:
if (require(sf)) {
  file <- system.file("examples", "feature_collection.geojson", package = "geojsonio")
  sf_fc <- st_read(file, quiet = TRUE)
  geojson_write(sf_fc)
}
  # }