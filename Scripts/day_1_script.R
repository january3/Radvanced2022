my_variable <- 10

my_variable

mv1

exp(42)
exp("forty two")
result <- exp("forty two")
result <- try(exp("forty two"))

## safer version of exp
## gracefully catches errors
safe_exp <- function(x) {
  result <- try(exp(x))
  
  if(inherits(result, "try-error")) {
    message("Danger Will, the exp operation was not successful!")
    result <- NA
  }
  return(result)

}

ret <- safe_exp("forty two")


mess_it_up <- function(n=3) {
  ret <- rnorm(n)
  names(ret) <- LETTERS[1:n]
  ret
}

n <- 3
ret <- rnorm(n)
names(ret) <- LETTERS[1:n]

a <- b <- c <- 3
a



myfunction <- function(x, operation="sum") {
  
  operation <- match.arg(operation, c("sum", "sd", "mean"))
  
  if(operation == "sum") {
    ret <- sum(x)
  } else if(operation == "mean") {
    ret <- mean(x)
  }
  
  return(ret)
}

myfunction(1:100, "su")

ellipsis_check <- function(pi=3, ...) {
  arguments <- list(...)
  print(str(arguments))
  
  message("Found ", length(arguments), " arguments")
  
  data.frame(Name=names(arguments))
}

ellipsis_check(a=1, pi=pi, weather="bad")



argument <- "uniform"
foo <- switch(argument,
        uniform=runif,
        normal=rnorm)
foo(10)
foo



a <- 10

modify_a <- function() {
  a <<- a + 10
}

a
modify_a()
a

min_pval <- function(pvals) {
  
  min(pvals, na.rm = TRUE)
  
}




## Combine p-values using Fisher's method
## argument pval: a vector of p-values
## formula: chisq_2k = -2 * sum(log(pvals))
## returns: a combined p-valus
combine_pvals <- function(pvals) {
  
  
  if(!is.numeric(pvals)) {
    stop("pvals must be a numeric vector")
  }
  
  # calculate the Chi squared value according to Fisher's formula
  chi_stat <- -2 * sum(log(pvals))
  
  # read the probability for n * 2 degrees of freedom
  pchisq(chi_stat, df=length(pvals) * 2, lower.tail=FALSE)
}

stupid_divide <- function(a, b) {
  if(!(is.numeric(a) && is.numeric(b))) {
    stop("both arguments must be numeric")
  }
  
  # ... lots of stuff is happening
  
  a/b
  
  # lots and lots of other stuff
}

"+"(1, 2)
1 + 2

"<-"(alabel, "avalue")

a <- function(x) { print(paste("Hello", x)) }
a("Bill")
b <- a
b("Robert")

a <- (function(x) { print(paste("Hello", x)) })
a("Holla")


2 + 3
a <- 2
a + 3

(function(x) { print(paste("Hello", x)) })("Wicked")
a <- (function(x) { print(paste("Hello", x)) })
a("Wicked")



df1 <- data.frame(ID=LETTERS[1:2], value=c(10, 123))
df2 <- data.frame(ID=LETTERS[10:11], value=c(101, 13))
df3 <- data.frame(ID=LETTERS[3:4], value=c(1110, 123123))

df12 <- rbind(df1, df2)
rbind(df12, df3)

dfs <- list(df1, df2, df3)
Reduce(rbind, dfs)


"%M%" <- function(a, b) { setdiff(a, b) }

set1 <- c(1:4)
set2 <- c(2,3)
setdiff(set1, set2)
set1 %M% set2


intersect(set1, set2)
union(set1, set2)

print(length(1/"a"))

# example 2
f <- function(a=1/"a") { print(18) }
f()

# example 3
f <- function(a=bqwer) { bqwer <- 18 ; print(a) }
f()


Reduce(c, 1)


df1 <- data.frame(ID=c("A", "A", "B"), val=c(1, 13, 17))
df2 <- data.frame(ID=c("A", "C"), val=c(22, 44))
merge(df1, df2)
?Reduce




#' Combine RNA-Seq counts from different STAR count files
#' @param fnames a character vector with file names
#' @value a data frame (count matrix) from the files combined
#' 

combine_star_count <- function(fnames) {
  
  # make sure the files exist
  stopifnot(all(file.exists(fnames)))
  
  # read the files
  count_list <- lapply(fnames, read.table)  
  
  # merge the data
  merge_V1 <- function(a, b) {
    merge(a, b, by="V1")
  }
  
  ret <- Reduce(merge_V1, count_list)  
  colnames(ret) <- c("ID", fnames)
  ret  
}

df1 <- read.table("Datasets/star.SAMN15934930.all_mates.gene_counts.tab")
df2 <- read.table("Datasets/star.SAMN15934977.all_mates.gene_counts.tab")

foo <- merge(df1, df2, by="V1")

out <- combine_star_count(c("Datasets/star.SAMN15934930.all_mates.gene_counts.tab", 
                            "Datasets/star.SAMN15934977.all_mates.gene_counts.tab",
                            "Datasets/star.SAMN15935042.all_mates.gene_counts.tab"))



