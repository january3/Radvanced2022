# Session 1: Keeping your code clean

**A.** Write a function for reading and checking a couple of input files.
The idea is to have a specialized function to read a particular file format
for a number of files and return it in a standardized way. The files have
four columns:

  * Identifier column
  * Three columns with gene counts (use the first one)


The files with which you can test your function are
[SAMN15934930](../Datasets/star.SAMN15934930.all_mates.gene_counts.tab),
[SAMN15934977](../Datasets/star.SAMN15934977.all_mates.gene_counts.tab) and
[SAMN15935042](../Datasets/star.SAMN15935042.all_mates.gene_counts.tab).
  
Here is what
the function is supposed to do (for now):

    * take as argument names of a few files,
    * read them,
    * return a data frame.

Document it as best as you can, add comments and placeholders.
What else can the function do?


**Example Solution.** Function for reading gene count files, optionally
with annotation.


```r

#' Read gene counts
#' 
#' Read gene counts and summarize them in a data frame
#'
#' Read gene count files from STAR (tab-separated files containing one
#' identifier column and one counts column). The columns containing the
#' identifiers are then combined in a single data frame. The order of the rows
#' is assumed to be identical in all files.
#' @param fnames Character vector with file names
#' @param annotation (optional) file with annotation data
#' @param skip by default, skip first four lines
#' @return A data frame with one identifier column and several count columns
#' @examples
#' fn <- c(
#'     "star.SAMN15934930.all_mates.gene_counts.tab",
#'     "star.SAMN15934977.all_mates.gene_counts.tab",
#'     "star.SAMN15935042.all_mates.gene_counts.tab")
#' gc <- read_gene_counts(fn)
#' @export
read_gene_counts <- function(fnames, annotation=NULL, skip=4L) {

  # if annotation is found, read it.
  if(!is.null(annotation)) {
    if(!file.exists(annotation)) {
      stop("Annotation file does not exist")
    }
    annotation <- read.table(annotation)
  }

  # For now, we do it with a for loop
  # Mind that this is not the best solution!

  # Before reading anything, check that the files
  # exist
  for(fn in fnames) {
    if(!file.exists(fn)) {
      msg <- paste("File", fn, "does not exist")
      stop(msg)
    }
  }

  # read one file in full, then
  # add other files column by column
  result <- read.table(fnames[1])

  for(fn in fnames[-1]) {
    df <- read.table(fn)
    result <- cbind(result, df[,2])
  }

  # column names from file names
  colnames(result) <- c("ID", fnames)

  # skip first few lines if necessary
  if(skip > 0) {
    result <- result[ -1:-skip, ]
  }

  # if there is an annotation, let's add it
  if(!is.null(annotation)) {
    result <- cbind(annotation, result)
  }

  return(result)
}
```


# Session 2: Writing and documenting functions
    
 * Write the following functions:

    * Adds two numbers, but check that the arguments are numeric 

```r
add_two <- function(a, b) {
  if(!is.numeric(a) || !is.numeric(b)) {
    stop("a and b must be numeric!")
  return(a + b)
}
```

    * returns a random number. It takes two parameters: number of random
       values to generate and the type of distribution (which should be:
       normal, uniform, binomial: take a look at `rnorm`, `runif`, `rbinom`).

```r
get_rand <- function(n, distribution="normal") {

  if(distribution == "uniform") {
    return(runif(n)) 
  } else if(distribution == "binomial") {
    # for binomial distribution, we need to set the
    # "size" and "p" parameters
    return(rbinom(n, 1, .5)) 
  } else if(distribution == "normal") {
    return(rnorm(n))
  } 

  stop(paste("This is not a valid distribution:", distribution))
}

```

    * takes a vector of p-values and returns the smallest p-value (but
       keep in mind that some values might be NA's!)

```r
minp <- function(x) {
  return(min(x, na.rm=TRUE))
}
```

 * What is wrong with the following statement? (NO, I don't mean `"a" + 5`) What would be the correct expression?

       if(!try(b <- "a" + 5)) {
         warning("This expression is incorrect!")
       }

```r
if(inherits(try(b <- "a" + 5), "try-error")) {
      warning("This expression is incorrect!")
}
```

 * Define your own operators for all set operations. When do you use the
    back ticks (`` ` ``)? Set operations: `setdiff`, `union`, `intersect`,
    `setequal`

```r

`%-%` <- function(a, b) {
  setdiff(a, b)
}

`%+%` <- function(a, b) {
  union(a, b)
}

`%^%` <- function(a, b) {
  intersect(a, b)
}

`%=%` <- function(a, b) {
  setequal(a, b)
}
```

