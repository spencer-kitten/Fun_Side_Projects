a <- list()
b <- list()
c <- list()
d <- list()
e <- list()

mine_d <- 281*5280/(70000*3)

mines<- 200
merch <- 100
for(i in seq(0,mines)){
	a[i] <- i*35
	b[i] <- i*35 + 35/4
	c[i] <- i*35 + 35/3
	d[i] <- i*35 + 35/2
	e[i] <- i*35 + 35/1
}
max_dist <- as.numeric(e[length(e)])
dataa <- matrix(rep(0,mines))
datab <- matrix(rep(0,mines))
datac <- matrix(rep(0,mines))
datad <- matrix(rep(0,mines))
datae <- matrix(rep(0,mines))


for(i in seq(0,merch)){
	merch <- runif(1)*max_dist
	for(j in seq(1,length(a))){
		kill1 <- as.numeric(a[j]) + 20
		kill2 <- as.numeric(a[j]) - 20
		if(merch >= kill2 && merch <= kill1){
			a[j] <- NULL
			dataa[j]<-1
			break
		}
	}
}

mine_pop <- mines - cumsum(dataa)
plot(mines - cumsum(dataa),ylab = "# mines")

fitmodel <- nls(mine_pop~SSlogis(mine_pop, Asym, xmid, scal))

