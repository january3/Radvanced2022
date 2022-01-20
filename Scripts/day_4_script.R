library(ggplot2)
library(colorDF)
library(tidyverse)
g1 <- ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length)) + geom_point()
g1

as.formula("~ a")

lm_wrapper <- function(data, x_name, y_name) {
  
  formula <- paste(y_name, "~", x_name)
  message("Using formula:", formula)
  lm(as.formula(formula), data=data)
  
  
}

data <- data.frame(x=rnorm(100))
data$y <- rnorm(100) + data$x
plot(data$x, data$y)
lm(y ~ x, data=data)
lm_wrapper(data, "x", "y")

