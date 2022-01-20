annot <- read.csv("Datasets/annotation.all.csv")

## what are the variable types?
lapply(annot, class)

## how many missing data?
count_nas <- function(x) {
  sum(is.na(x))
}

lapply(annot, function(.) sum(is.na(.)))



lapply(starwars$name, nchar)
sapply(starwars$name, nchar)
length("foo")
nchar("foo")

mtx <- matrix(rnorm(60), ncol=3)
apply(mtx, 1, mean)
apply(mtx, 2, mean)

colSums(mtx) / nrow(mtx)
colMeans(mtx)
colSD <- function(x) {
  
  
  
  apply(mtx, 2, sd)
  
  
}

colSD(mtx)
foo <- matrix(rnorm(60), ncol=3)


tapply(mtcars$mpg, mtcars$cyl, mean)
mtcars %>% group_by(cyl) %>% summarise(mean_mpg=mean(mpg))

stupid_numeric <- function(.) {
  as.integer(is.numeric(.))
}

map_lgl(starwars, ~ stupid_numeric(.) == 1)
unlist(lapply(starwars, is.numeric))


ret <- map(mtcars, ~ quantile(., c(.25, .5, .75)))
Reduce(rbind, ret)

calc_quant <- function(x) {
  ret <- quantile(x, c(.25, .5, .75))
  data.frame(Q1=ret[1], Q2=ret[2], Q3=ret[3])
}
calc_quant(mtcars[,1])

data.frame(t(quantile(mtcars[,1], c(.25, .5, .75))))

imap_dfr(mtcars, ~ data.frame(ID=.y, t(quantile(.x, c(.25, .5, .75)))))
data.frame(t(c(1,2,3)))

map(mtcars, IQR)

sw_names <- starwars$name
sw_vehcls <- starwars$vehicles
map2_chr(sw_names, sw_vehcls, 
         ~ paste0(.x, "_", length(.y)))

pmap(mtcars, ~ mean(...))
?pmap

vec <- list(last_name="Gates", first_name="Bill")
imap_chr(vec, ~ paste0(.y, ": ", .x))
imap_chr(vec, function(.x, .y) paste0(.y, ":", .x))

cars %>% class
cars %>% mutate(ID=paste0("ID", 1:n())) %>% 
  pivot_longer(speed:dist, names_to="variable_name", values_to="measurement")


cars <- read_excel("Datasets/cars.xlsx")
summary_colorDF(cars)
map_chr(cars, class)
which(is.na(as.numeric(cars$speed)))
cars$speed[9]
any(is.na(as.numeric(gsub(" .*", "", cars$speed))))

grepl("c^at$", c("c^at", "meercat", "cat", "category", "cAt"))

input <- "name:Janłary     last_name:Weiner"

gsub("name:([a-zA-Z]*[^ ]) +last_name:(.*)", "\\2 \\1", input)

identifiers <- c("S001 ID9835", "S002-ID12363", "S003_ID84755")

gsub("[^[:alnum:]]", "_", identifiers)

foo <- read.table(text="
2
3
a")

foo[,1] <- factor(foo[,1])

class(foo[[1]])
foo

index <- foo[1:2, 1]
index

LETTERS[index]

tibble(foo)
summary_colorDF(foo)

mb <- read_excel("Datasets/meta_data_botched.xlsx")

summary_colorDF(mb) %>% print(100)

which(mb$Timepoint == "D 1")
mb$Timepoint[76] <- "D1"

table(mb$ARM, mb$PLACEBO)
mb$PLACEBO[ mb$PLACEBO == "0"] <- "NO"
mb$PLACEBO[ mb$PLACEBO == "1"] <- "YES"
#
unique(mb$ARM)

transl_vec <- c(P="PLACEBO", PLACEBO="PLACEBO", control="PLACEBO")
transl_vec[ mb$ARM ]

unique(mb$AGE)

gsub("^A..", "AGRIPPAL", "A")

nas <- which(is.na(as.numeric(mb$AGE)))
mb$AGE[nas]
as.numeric(gsub(" ", "", gsub("^([0-9 ]*).*", "\\1", mb$AGE[nas])))

mb_clean <- mb %>%
  mutate(Timepoint=gsub(".*([01]) *$", "D\\1", Timepoint)) %>%
  mutate(ARM=gsub("^(P.*|control)$", "PLACEBO", ARM)) %>%
  mutate(ARM=gsub("^F.*", "FLUAD", ARM)) %>%
  mutate(ARM=gsub("^A.*", "AGRIPPAL", ARM)) %>%
  mutate(AGE=
           as.numeric(gsub(" ", "", gsub("^([0-9 ]*).*", "\\1", AGE)))) 



a <- 1

foo <- function(a) {
  
  a <<- 10
  
  
}

foo(a)
a

library(colorDF)

summary_colorDF
print
print(mtcars)
print(starwars)
print
class(starwars)
typeof(starwars)

print.data.frame(starwars)

library(colorDF)
colorDF:::print.colorDF(starwars)
