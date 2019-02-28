g <- dados$ANO
l <- split(dados, g)
summary(l)
head(l, 1)
aq2 <- unsplit(l, g)
head(aq2)
length(l)
