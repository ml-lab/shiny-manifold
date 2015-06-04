library('ggplot2')

# Generate swiss roll and distance matrix
genSwissRoll <- function(npoints) {
  # Generate parameterizer
  tt.r <- runif(npoints)
  tt <- (3*pi/2) * (1 + 2*tt.r)
  # Points
  swissr <- list()
  swissr$x <- tt * cos(tt)
  swissr$y <- 21 * runif(npoints)
  swissr$z <- tt * sin(tt)
  # Color scale
  col.f <- colorRampPalette(c('skyblue', 'navy'))
  cols <- col.f(npoints+1)
  swissr$c <- cols[round(tt.r*npoints)+1]
  swissr$c.scale <- tt.r
  # Distance matrix
  swissr$D <- as.matrix(dist(cbind(swissr$x, swissr$y, swissr$z)))
  return(swissr)
}

# Generate toroidal solenoid and distance matrix
genSolenoid <- function(npoints) {
  noise.sigma <- 0.075
  # Parameterizer
  tt.r <- (1:npoints)/npoints
  tt <- 2*pi*tt.r^0.75
  # Points
  sol <- list()
  sol$x <- (2+cos(8*tt))*cos(tt) + noise.sigma*rnorm(npoints)
  sol$y <- (2+cos(8*tt))*sin(tt) + noise.sigma*rnorm(npoints)
  sol$z <- sin(8*tt) + noise.sigma*rnorm(npoints)
  # Color scale
  col.f <- colorRampPalette(c('skyblue', 'navy'))
  cols <- col.f(npoints+1)
  sol$c <- cols[round(tt.r*npoints)+1]
  sol$c.scale <- tt.r
  # Distance matrix
  sol$D <- as.matrix(dist(cbind(sol$x, sol$y, sol$z)))
  return(sol)
}

# Compute first two diffusion maps
diffusion.maps.2 <- function(D, alpha, epsilon) {
  A <- exp(-(D^2)/epsilon)
  p <- rowSums(A)^alpha
  Ah <- A / outer(p, p)
  dh <- rowSums(Ah)^0.5
  K <- Ah / outer(dh, dh)
  
  udv <- svd(K, nu = 3, nv = 0)
  phi <- udv$u[, 2:3] / cbind(udv$u[, 1], udv$u[, 1])
  phi[, 1] <- udv$d[2]^10 * phi[, 1]
  phi[, 2] <- udv$d[3]^10 * phi[, 2]
  return(phi)
}

# Plot first two diffusion maps
dm.plot <- function(D, alpha, epsilon, col) {
  dm <- diffusion.maps.2(D, alpha, epsilon)
  plot.df <- data.frame(dm)
  names(plot.df) <- c('x', 'y')
  plot.df$c <- col
  
  ggplot(data = plot.df, aes(x = x, y = y, color = c)) + geom_point(size = 4) +
    xlab('First diffusion map') + ylab('Second diffusion map') +
    scale_color_gradient(low='skyblue', high='navy') +
    theme(legend.position="none")
}