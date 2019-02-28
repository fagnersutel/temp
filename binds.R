df1 <- data.frame(a=rnorm(100), b=rnorm(100), not=rnorm(100))
df2 <- data.frame(a=rnorm(100), b=rnorm(100))

bind1 <- bind1 <- df1[, names(df1) %in% names(df2)]
bind2 <- bind1 <- df1[, names(df2) %in% names(df1)]

rbind(bind1, bind2)

data15$DATA = NULL
data15$HORA = NULL
data13 = data13[,sort(names(data13))]
data15 = data15[,sort(names(data15))]
dim(data13)
dim(data15)
aa = names(data13)
length(aa)
bb = names(data15)
length(bb)
aabb = cbind(aa, bb)
aabb
teste = rbind(data13, data15)
dim(teste)
bind1 <- bind1 <- data15[, names(data15) %in% names(data13)]
bind2 <- bind1 <- data15[, names(data13) %in% names(data13)]

final <- rbind(bind1, bind2)
dim(data13)
dim(data15)
dim(data13) + dim(data15)

data13 = data13[,sort(names(data13))]
data15 = data15[,sort(names(data15))]

final = rbind(data13, data15)
