#https://stackoverflow.com/questions/39008850/find-number-of-points-within-a-radius-in-r-using-lon-and-lat-coordinates
#https://stackoverflow.com/questions/21977720/r-finding-closest-neighboring-point-and-number-of-neighbors-within-a-given-rad

library(RANN)
set.seed(123)

## simulate some data
lon = runif(100, -99.1, -99)
lat = runif(100, 33.9, 34)

## data is a 100 x 2 matrix (can also be data.frame)
mydata <- cbind(lon, lat)
mydata
radius <- 0.02   ## your radius
res <- nn2(mydata, k=nrow(mydata), searchtype="radius", radius = radius)
## prints total number of nearest neighbors (for all points) found using "radius"
print(length(which(res$nn.idx>0)))
##[1] 1224
res1 <- nn2(mydata, k=100, radius = radius) 
## prints total number of nearest neighbors (for all points) found using your call
print(length(which(res1$nn.idx>0)))
##[1] 10000

radius <- 0.03   ## increase radius
res <- nn2(mydata, k=nrow(mydata), searchtype="radius", radius = radius)
## prints total number of nearest neighbors (for all points) found using "radius"
print(length(which(res$nn.idx>0)))
##[1] 2366
res1 <- nn2(mydata, k=100, radius = radius)
## prints total number of nearest neighbors (for all points) found using your call
print(length(which(res1$nn.idx>0)))
##[1] 10000
count <- rowSums(res$nn.idx > 0) - 1
count

