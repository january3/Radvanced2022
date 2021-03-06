# Session 5/1

Try to solve as many of the following puzzles as you can. Note: **do not
proceed from 1 to n! Don't do everything!** Read the descriptions and
*decide* for which functions you have an idea or understand the task well
and start with one of these. Before you proceed, make sure that the
function is well documented, nicely written (variable names ok) and that it
works as expected.

If you still have time, do another one.

 1. `sprintf()` functions formats a string, replacing formats like "%s"
    with the corresponding arguments. E.g. `sprintf("%s? %s!\n", "A", "B")`
    produces `"A? B!\n"` (`\n` is the newline). You can then output it with
    `cat(sprintf(...))`.

    Write a function which combines cat and sprintf (call it "printf"),
    such that you can for example write `catf("Hi, my name is %s\n", who)`.
    Use ellipsis (...) to pass the arguments.

```r
catf <- function(...) cat(sprintf(...))
```
 
 2. Write a function which creates a boxplot combined with a beeswarm plot.
    As parameters, it should take a numeric vector and a factor.

```r
## in base R
bbplot <- function(x, f) {
  require(boxplot)
  beeswarm(x ~ f)
  boxplot(x ~ f, col=NA, add=TRUE)
}

## in ggplot
ggbbplot <- function(x, f) {
  require(ggbeeswarm)
  df <- data.frame(y=x, x=factor(f))
  ggplot(df, aes(x=x, y=y)) + geom_boxplot() + geom_quasirandom()
}
```

 3. Write a function which takes a data frame, names of two columns in that
    data frame (one for log fold changes and one for p-values) and
    significance thresholds (lfc and p-value) and returns that data frame
    filtered such that only rows with significant combinations of lfc and
    p-value are returned. So for example, if the data frame dff contains columns
    "lfc", "qval", you would be able to call 
    
        ```r
        show_sign(dff, "lfc", "qval", lfc.thr=1, pval.thr=.05)
        ```
    ...to get all the significant genes.

```r
show_sign <- function(df, lfc_name="lfc", pval_name="qval", lfc.thr=1, pval.thr=.05) {
  sel <- abs(df[[lfc_name]]) > pval.thr & df[[pval_name]] < pval.thr
  df[sel, ]
}

```

 4. Often when you run PCA with `prcomp`, prcomp complains about variables which
    have zero variance. Write a wrapper around prcomp which takes as a
    parameter gene expression data (with genes in rows and samples in
    columns), checks which genes have 0 variance and removes them, and
    finally runs prcomp and returns the prcomp object. Don't forget to
    transpose the matrix before sending to prcomp!

```r
pcafilt <- function(x, var_thr=1e-22) {
  vars <- apply(x, 1, var)
  keep <- vars > var_thr
  x <- x[keep, ]
  prcomp(t(x), scale.=TRUE)
}
```

 5. Write a replacement function for print.data.frame such that only `n`
    lines are printed, with `n` being by default 20. Shorten the data frame
    to n lines and then call `base::print.data.frame`. (you must specify
    that you print the shortened data frame with the base variant of
    print.data.frame, because otherwise you will get into an infinite loop).

```r
print.data.frame <- function(x, n=10, ...) {
  N <- nrow(x)
  if(N > n) {
    x <- x[1:n, ]
  }
  base::print.data.frame(x, ...)
}
```

 6. Write a function which matches colors to values. Given a palette of
    n colors, and a numeric vector, it returns a vector of colors such that
    the lowest value got the first color from the palette, the highest
    value got the last color from the palette, and the values in between
    got the colors in between. The result must be a character string
    containing colors of the same length as the numeric vector. Optionally,
    the function should take two additional parameters: min and max. All
    values below min should get the first color, and all values above max
    should get the last color.

 7. Write a function called `summary.character` which would be a summary
    method for character vectors. The summary should show the frequencies
    of elements in the vector (for example, if the vector contains twice
    "ctrl" it would show "ctrl: 2" or something similar).

```r
summary.character <- function(x, ...) {

  require(purrr)
  tab <- table(x)
  vec <- as.numeric(tab)
  names(vec) <- names(tab)
  vec <- sort(vec, decreasing=TRUE)
  res <- map2_chr(vec, names(vec), ~ {
    paste0(.y, ": ", .x)
  })
  res <- paste(res, collapse="\n")
  cat(res)
}
```

 8. Write a function which first saves the R history and then saves the R
    workspace (`savehistory` and `save.image`). The function should have a
    short name, so you can quickly save everything at any time.


```r
zz <- function() {
  savehistory()
  save.image()
}
```
