# Loada required libraries 
library(plotrix)



##################
# Section for modeling lost contact
n_ent <- 500
xx <- runif(n_ent, min = -11, max = -10)
yy <- runif(n_ent, min = -1, max = 1) 

#plot(xx,yy,xlim = c(-10,10), ylim = c(-10,10))
#grid()

crs <- rnorm(n_ent, mean = 0, sd = .1)
spd <- runif(n_ent)*.05 + .05
spd <- abs(spd)


#i <- 1
#ttmax <- 150
#while (i < ttmax){
#	xx <- xx + cos(crs)*spd
#	yy <- yy + sin(crs)*spd
#	i <- i + 1
#	#plot(xx,yy,xlim = c(-10,10), ylim = c(-10,10))
#	grid()
#}
####################


# Define boundary functions for trapeziod ecasement 
left <- function(start,speed,time) {
	f <- (-speed)*time + start
	return(f)
}

right <- function(start,speed,time) {
	f <- (speed)*time + start
	return(f)
}

top <- function(start,speed,time) {
	intercept <- speed*time + start 
	slope <- 4/15
	data <- c(slope,intercept)
	return(data)
}

bottom <- function(start,speed,time) {
	intercept <- -speed*time + start 
	slope <- -4/15
	data <- c(slope,intercept)
	return(data)
}


# Initialize time and define max time of simulation 
t <- 0
t_max <- 200

# Initialize speed of plotted dots and of submarine 
# Dot speed sould be zero for most cases...
dot_spd <- 0.1
sub_speed <- .5

# Generate random points for visualization 
x <- runif(1000 + dot_spd*40000, min = -(dot_spd*t_max + 10), max = (dot_spd*t_max + 10))
y <- runif(1000 + dot_spd*40000, min = -(dot_spd*t_max + 10), max = (dot_spd*t_max + 10))
dot_spd <- -dot_spd

# Define starting position of submarine 
sub_x <- 2
sub_y <- 5
turn.point <- c()

# Initialize vectors to store detected dots 
red_x <- c()
red_y <- c()
red_crs <- c()
red_spd <- c()

# Main simulation funciton 
while (t < t_max) {

	# Adust x position of dots
	#x <- x - dot_spd
	#red_x <- red_x - dot_spd

	xx <- xx + cos(crs)*spd
	yy <- yy + sin(crs)*spd
	if (!is.null(red_crs)){
		red_x <- red_x + cos(red_crs)*red_spd
		red_y <- red_y + sin(red_crs)*red_spd
	}

	# Plot dots & grid
	plot(xx,yy,xlim = c(-10,10), ylim = c(-10,10))
	grid()

	# Update ecasement 
	speed <- 0
	abline(v = left(-3,speed,t), col = 'red')
	abline(v = right(3,speed,t), col = 'red')
	abline(a = top(8/3,speed,t)[2], b = top(8/3,speed,t)[1], col = 'red')
	abline(a = bottom(-8/3,speed,t)[2], b = bottom(-8/3,speed,t)[1], col = 'red')

	# Draw submarine 
	draw.circle(sub_x,sub_y,radius = 1)
	
	# Verify detection proximity... can be more efficient 
	i <- 1
	while (i <= length(xx)) {
		dist <- c()
		if (xx[i] < sub_x +1 && xx[i] > sub_x - 1){
			dist <- sqrt((xx[i] - sub_x)^2 + (yy[i] - sub_y)^2)
			if (dist <= 1) {
				red_x <- append(red_x,xx[i])
				red_y <- append(red_y,yy[i])
				red_crs <- append(red_crs,crs[i])
				red_spd <- append(red_spd,spd[i])
			}
		}
		i <- i + 1
	}
	
	# Recolor detected points as red
	points(red_x,red_y, col = 'red')

	# Update position of submarine

	## Too low
	too_low <- bottom(-8/3,speed,t)[1]*sub_x + bottom(-8/3,speed,t)[2]
	
	if (sub_y - 1 < too_low){
		turn.point <- append(turn.point,sub_x)
		#sub_x <- sub_x - abs(sub_speed)
		if (sub_x - 1 < turn.point[1]) {
			turn.point <- c()
			
		}
		if (sub_speed > 0) {
			sub_speed <- -sub_speed
		}
		
	}

	## Too high 
	too_high <- top(8/3,speed,t)[1]*sub_x + top(8/3,speed,t)[2]
	
	if (sub_y + 1 > too_high){
		turn.point <- append(turn.point,sub_x)
		#sub_x <- sub_x - abs(sub_speed)
		if (sub_x - 1 < turn.point[1]) {
			turn.point <- c()
			
		}
		if (sub_speed < 0) {
			sub_speed <- -sub_speed
		}
		
	}
	sub_y <- sub_y - sub_speed

	# Increment time and wait for visualization 
	t <- t + 1
	Sys.sleep(.1)
}


#########################################################################################
#################################################################################

