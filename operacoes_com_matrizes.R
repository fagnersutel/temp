smoke <- matrix(c(1, 2, 1, 0, 0, 1, 2, 1),ncol=4,byrow=TRUE)
smoke
colnames(smoke) <- c("0","1","2", "3")
rownames(smoke) <- c("0","1")
smoke <- as.table(smoke)
smoke

barplot(smoke,legend=T,beside=T,main='Smoking Status by SES')
plot(smoke,main="Smoking Status By Socioeconomic Status")

margin.table(smoke)
margin.table(smoke,1)
margin.table(smoke,2)

smoke/margin.table(smoke)
margin.table(smoke,1)/margin.table(smoke)
margin.table(smoke,2)/margin.table(smoke)


prop.table(smoke)
prop.table(smoke,1)
prop.table(smoke,2)

summary(smoke)

expected <- as.array(margin.table(smoke,1)) %*% t(as.array(margin.table(smoke,2))) / margin.table(smoke)
expected


chi <- sum((expected - as.array(smoke))^2/expected)
chi



mosaicplot(smoke)
help(mosaicplot)

mosaicplot(smoke,main="Smokers",xlab="Status",ylab="Economic Class")


mosaicplot(smoke,main="Smokers",xlab="Status",ylab="Economic Class")
mosaicplot(smoke,sort=c(2,1))


mosaicplot(smoke,main="Smokers",xlab="Status",ylab="Economic Class")
mosaicplot(smoke,dir=c("v","h"))


set_pri = c(2.0, 2.5, 2.9, 3.3, 4.1, 4.3, 7.0)
analfa = c(17.5, 18.5, 19.5, 22.2, 26.5, 16.6, 36.6)
analfa = as.double(analfa)
set_pri = as.double(set_pri)
reg1 <- lm(analfa~set_pri) 
summary(reg1)

plot(set_pri, analfa)
abline(reg1)
 