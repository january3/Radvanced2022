# Exercise 1/1: Keeping your code clean

Take some code that you have been working on recently. Check whether the
code is verbose, clean, commented. Add comments if necessary.


# Exercie 1/2: Writing and documenting functions
    
 * Write the following functions:

    1. Adds two numbers, but check that the arguments are numeric (use
       `is.numeric`)
    2. returns a random number. It takes two parameters: number of random
       values to generate and the type of distribution (which should be:
       normal, uniform, binomial: take a look at `rnorm`, `runif`, `rbinom`).
    3. takes a vector of p-values and returns the smallest p-value (but
       keep in mind that some values might be NA's!)
    4. Implement [Fisher's method](https://en.wikipedia.org/wiki/Fisher%27s_method) of combining probabilities 

The following should work:

```r
## expected: 22
add_two(5, 17)

## expected: 15 random numbers
get_a_random(15, "uniform")

## expected: 1e-4
min_pval(c(0.05, 0.0001, NA, 1e-3))

combine_pvals(c(0.05, 1e-9, 1, 0.7))
```
 

# Exercise 1/3

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
    * combine them
    * return a data frame.

Document it as best as you can, add comments and placeholders.
What else can the function do?

 * Optional: check the arguments. Do the files exist? Are the file names a
   character vector? Do they have the same length?
 * Optional: Use 
   [roxygen2](https://kbroman.org/pkg_primer/pages/docs.html) style
   formatting to make the
   documentation for your Session 1 function consistent.





# Exercise 1/4: R as functional language

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

 * Create a function that does the following: it takes two arguments, a
   list and a function. The return value is a list. Then, it applies the function to each element of
   that list and stores it in the returned list. You are not allowed to use
   `lapply` or `map_*` functions, use a `for` loop instead.

# Exercise 1/5: Vectorization and floating number operators

 * If you haven't done it yet, use lapply/map to read the files in your
   Session 1 function.

 * Create operators which can serve as replacement for `==`, `>` etc. for
    floating numbers. (e.g. %==% should be a function taking two arguments
    to compare)
