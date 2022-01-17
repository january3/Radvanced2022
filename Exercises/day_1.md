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




# Session 2: Writing and documenting functions
    
 * Write the following functions:

    1. Adds two numbers, but check that the arguments are numeric 
    2. returns a random number. It takes two parameters: number of random
       values to generate and the type of distribution (which should be:
       normal, uniform, binomial: take a look at `rnorm`, `runif`, `rbinom`).
    3. takes a vector of p-values and returns the smallest p-value (but
       keep in mind that some values might be NA's!)

The following should work:

```r
## expected: 22
add_two(5, 17)

## expected: 15 random numbers
get_a_random(15, "uniform")

## expected: 1e-4
min_pval(c(0.05, 0.0001, NA, 1e-3))
```
 
 * What is wrong with the following statement? (NO, I don't mean `"a" + 5`) What would be the correct expression?

    if(!try(b <- "a" + 5)) {
      warning("This expression is incorrect!")
    }

 * With the function from Session 1,

    * test whether the file exists (`file.exists()`), throw an error if it does not (you can
      use `try`, `tryCatch`, you can use `stop`; you can also use `warning`...)
    * test whether the columns contain NA's (and how many), warn if there
      are any NAs in the ID column
    * test whether the file really has two columns
    * test whether IDs are unique and values numeric
    * return a data frame containing two columns (ID's and numbers)
    
 * Use 
   [roxygen2](https://kbroman.org/pkg_primer/pages/docs.html) style
   formatting to make the
   documentation for your Session 1 function consistent.



# Session 3: R as functional language

 * Define your own operators for all set operations. When do you use the
    back ticks (`` ` ``)? Set operations: `setdiff`, `union`, `intersect`,
    `setequal`

 * Create a function called `%=>%`. The function should take two
   arguments: (i) a data set, (ii) a function. Then, it should call the
   function with the data set as argument. The following should be
   equivalent:

         mtcars %=>% head
         head(mtcars)

 * With the function from Session 1, add a named argument, by default
   `NULL`. If defined, your function should read a file (e.g. 
   [this one](../Datasets/annotation.all.csv)) and add an annotation to the
   output.

# Session 4: Vectorization and floating number operators

 * If you haven't done it yet, use lapply/map to read the files in your
   Session 1 function.

 * Create operators which can serve as replacement for `==`, `>` etc. for
    floating numbers. (e.g. %==% should be a function taking two arguments
    to compare)
