library(ggplot2)
library(colorDF)
library(tidyverse)
g1 <- ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, color=Petal.Width)) + 
  geom_point()
g1

g2 <- ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point()
g2 + scale_color_discrete(labels=c(paste0(expression(italic("test")), expression(underline("I. setosa"))), "I. versicolor", "I. virginica"))



library(cowplot)
g3 <- plot_grid(g1, g2, g1, g2, labels=LETTERS[1:4], nrow=2)
g3
theme_set(theme_minimal())
summary(iris)

ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species)) + geom_point() +
  scale_color_manual(values=c("green", "red", "blue"), breaks = "setosa")


as.formula("~ a")

lm_wrapper <- function(data, x_name, y_name) {
  
  formula <- paste(y_name, "~", x_name)
  message("Using formula:", formula)
  lm(as.formula(formula), data=data)
  
}

iris[ , grep("Width", colnames(iris))]



cols <- c("Sepal.Width", "Species")
iris$cols <- "nothing"

library(tidyverse)
iris %>% select(cols)
iris %>% select(all_of(cols))


data <- data.frame(x=rnorm(100))
data$y <- rnorm(100) + data$x
plot(data$x, data$y)
lm(y ~ x, data=data)
lm_wrapper(data, "x", "y")


#' Title
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
summary.data.frame <- function(x) {
  print("Blop!")
}

x <- 1:10
class(x) <- c("set", class(x))

set(x)

set <- function(x) {
  if(!is(x, "set")) {
    class(x) <- c("set", class(x))
  }
  x  
}

set(1:10)
set(set(1:10))

methods(, "colorDF")
methods("print")

library(readxl)
library(tidyverse)

wid <- read_excel("../Datasets/WIID_19Dec2018.xlsx")
wid2015 <- wid %>% filter(year==2015 & 
                            region_un == "Europe" & 
                            population > 5e6)
wid2015sel <- wid2015  %>% 
  filter(quality=="High") %>%
  filter(!duplicated(country)) %>% 
  select(country, gini_reported, q1:q5, d1:d10)

data <- wid2015sel %>% arrange(-gini_reported) %>%
  mutate(country=factor(country, levels=unique(country))) %>%
  pivot_longer(cols=q1:q5, names_to="quantile", values_to="proportion") 

p <- data %>%
  mutate(quantile=factor(toupper(quantile), levels=paste0("Q", 5:1))) %>%
  ggplot(aes(x=country, y=proportion, fill=quantile)) + geom_col() +
    coord_flip()

library(ggthemes)
library(RColorBrewer)
p + theme_tufte() + 
  scale_fill_manual(values=
                      c(Q1="darkgreen", Q2="navyblue", Q3="salmon", Q4="ivory", Q5="gold")) +
  guides(fill=guide_legend(reverse=TRUE, title="Quantile")) +
  xlab("")

exprs <- read_csv("../Datasets/transcriptomics_results.csv")


data$quantile <- factor(data$quantile, levels=paste0("Q", 5:1))


vec <- c("Q1", "Q2", "Q3")
as.numeric(vec)
vec_fac <- factor(vec)
as.numeric(vec_fac)
vec_fac <- factor(vec, levels=paste0("Q", 3:1))
as.numeric(vec_fac)
vec_fac


factor(vec)
df <- data.frame(v1=vec, v2=factor(vec))
df


colorDF::colorDF_themes_show()
options(colorDF_theme="minimal")


df <- data.frame(response=sample(c("yes", "no"), 100, replace=TRUE))

ggplot(df, aes(x=response)) + geom_bar()

df2 <- df %>% group_by(response) %>% summarise(response=response[1], n=n())
df2

ggplot(df2, aes(x=response, y=n)) + geom_col()



x <- rnorm(10000)
y <- x + rnorm(10000)
p1 <- ggplot(NULL, aes(x=x, y=y)) + geom_point(alpha=.01) + theme_minimal() 
p1


brewer.pal(5, "Dark2")
display.brewer.all()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point(size=4) + scale_color_viridis_d() + theme_tufte()



pal_func <- colorRampPalette(c("blue", "green", "black", "salmon"))
plot(1:10, pch=19, cex=2, col=pal_func(10))

training_results.barplot<-structure(list(a = c(1L, 2L, 1L, 8L, 3L, 4L, 5L, 6L, 7L, 1L, 
                                               1L, 1L), b = c(1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 3L, 3L
                                               ), c = c(1L, 2L, 3L, 4L, 5L, 1L, 2L, 3L, 4L, 5L, 1L, 2L), name = structure(1:12, .Label = c("1+1+1", 
                                                                                                                                           "1+1+2", "1+1+3", "1+1+4", "1+1+5", "1+2+1", "1+2+2", "1+2+3", 
                                                                                                                                           "1+2+4", "1+2+5", "1+3+1", "1+3+2"), class = "factor"), corr = c(66.63, 
                                                                                                                                                                                                            66.66, 66.81, 66.57, 66.89, 66.63, 66.82, 66.74, 67, 66.9, 66.68, 
                                                                                                                                                                                                            66.76), acc = c(59.15, 59.29, 59.42, 59.08, 59.34, 59.1, 59.45, 
                                                                                                                                                                                                                            59.31, 59.5, 59.19, 59.16, 59.23), H = c(4167L, 4169L, 4178L, 
                                                                                                                                                                                                                                                                     4163L, 4183L, 4167L, 4179L, 4174L, 4190L, 4184L, 4170L, 4175L
                                                                                                                                                                                                                            ), D = c(238L, 235L, 226L, 223L, 226L, 240L, 228L, 225L, 226L, 
                                                                                                                                                                                                                                     230L, 227L, 226L), S = c(1849L, 1850L, 1850L, 1868L, 1845L, 1847L, 
                                                                                                                                                                                                                                                              1847L, 1855L, 1838L, 1840L, 1857L, 1853L), I = c(468L, 461L, 
                                                                                                                                                                                                                                                                                                               462L, 468L, 472L, 471L, 461L, 465L, 469L, 482L, 470L, 471L), 
                                         N = c(6254L, 6254L, 6254L, 6254L, 6254L, 6254L, 6254L, 6254L, 
                                               6254L, 6254L, 6254L, 6254L), wer = c(40.85, 40.71, 40.58, 
                                                                                    40.92, 40.66, 40.9, 40.55, 40.69, 40.5, 40.81, 40.84, 40.77
                                               )), .Names = c("a", "b", "c", "name", "corr", "acc", "H", 
                                                              "D", "S", "I", "N", "wer"), class = "data.frame", row.names = c("1", 
                                                                                                                              "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"))
training_results.barplot$a2 <- factor(training_results.barplot$a,
                                      labels = c("1", "2", "3", "4", "5", "Best", "Suggested", "Worst"))
ggplot(training_results.barplot, mapping = aes(x = name, y = wer, fill = a2))  + 
  geom_bar(stat = "identity") +
  scale_fill_manual(breaks = c("Best", "Suggested", "Worst"),
                    values = c("#555555", "#777777", "#555555", "#777777", 
                               "#555555", "green", "orange", "red")) 



exprs <- read_csv("../Datasets/transcriptomics_results.csv")
exprs %>% summary
exprs_byday <- exprs %>% pivot_longer(cols=starts_with(c("log", "q"))) %>% 
  separate(name, sep="\\.D", into=c("name", "day")) %>%
  pivot_wider(id_cols=all_of(c("day", "ProbeName")), names_from="name", values_from="value")

exprs_byday %>% ggplot(aes(x=logFC.F, y=-log10(qval.F), color=day, alpha=qval.F < 0.01)) + 
 scale_alpha_discrete(values=c("FALSE"=0.005, "TRUE"=0.5)) +  geom_point()



x <- rnorm(1e5)
plot(density(x))

ggplot(data.frame(x=x), aes(x)) + geom_density()




data <- read_csv("C:\\Users\January\.....\file.csv")

data <- read_csv("../Data/file.csv")


pval <- 0.01238887
sprintf("p-value: %.2f", pval)
format.pval(pval, digits=2)
library(glue)
glue("pval: {format.pval(pval, digits=2)}")

