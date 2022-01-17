# Session 4/1

 1. Using the WIID data set, reproduce the example from lecture for another
    selection of years / regions (maybe not for countries, but for regions
    or subregions?) Can you think of another representation?

    (clear)

 2. Using the mtcars data set and any graphics system, create a box plot 
    showing mpg depending on the number of cylinders (cyl). The latter
    should be treated as a category, not a continuous variable! (in ggplot:
    use the `geom_boxplot()` geom).

```r
boxplot(mpg ~ cyl, data=mtcars)
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + geom_boxplot()
```

 3. Load the [transcriptomics_results.csv](https://raw.githubusercontent.com/january3/Radvanced2020/master/Data/transcriptomics_results.csv) data set. 
    This is a data set derived from
    [this](https://www.nature.com/articles/s41598-019-56994-8) paper,
    showing transcriptomic responses to the vaccination at different
    timepoints. Using whatever tools (base R, `ggplot() + geom_point()`)
    plot the log fold changes on day 1 vs log fold changes on day 2. 

```r
tv <- read_csv("Datasets/transcriptomics_results.csv")
plot(tv$logFC.F.D1, tv$logFC.F.D2)
plot(tv$logFC.F.D1, tv$logFC.F.D2, pch=19, col="#33333333", 
  xlab="Log2 FC on day 1", ylab="Log2FC on day 2")
abline(0, 1, col="grey")
ggplot(tv, aes(x=logFC.F.D1, y=logFC.F.D2)) +
  geom_point(color="#33333333") +
  xlab("Log2 FC on day 1") + ylab("Log2FC on day 2") +
  geom_abline(intercept=0, slope=1, color="grey")
```

 4. Create an additional column to the transcriptomic data set. Fill it with
    either "TRUE" (a gene is significant on day 1) or "FALSE" (a gene is not
    significant). Define significance in terms of log fold change *and*
    p-value (i.e., a gene is significant if the absolute lfc is above a
    threshold *and* p-value is below a threshold).

 5. Create a volcano plot (i.e., log fold change on x axis, -log10(p-value)
    on y axis) showing in red genes which are significant on day 1. (for
    example, with ggplot2, use the color esthetics with the "sign" column
    you created in the previous step)

```r
## with arrange(sign), the color plots will be plotted last
tv <- tv %>% mutate(sign=abs(logFC.F.D1) > 1 & qval.F.D1 < .05) %>%
  arrange(sign) 
ggplot(tv, aes(x=logFC.F.D1, y=-log10(qval.F.D1), color=sign)) + 
  geom_point(alpha=.8) +
  scale_color_manual(values=c("grey", scales::muted("red")))
```

 6. Using a similar approach, color (or symbol) code genes which are:
     * not significant on Day 1 *and* Day 2
     * significant only on Day 1
     * significant only on Day 2
     * significant on both days

 *As above*

# Session 4/2

 1. Repeat first two exercises from 4/1 using different color schemes.
 2. Use a gradient color scale to represent fold changes on the
    transcriptomic data plot.

```r
ggplot(tv, aes(x=logFC.F.D1, y=-log10(qval.F.D1), color=logFC.F.D1)) + 
  geom_point(alpha=.8) +
  scale_color_gradient2(low="blue", mid="#CCCCCC", high="red", name="Log2 Fold Change, Day 1")
```


 3. A "disco score" has been defined ([Domaszewska et al.](https://www.nature.com/articles/s41598-017-11812-x)) to combine
    information from two log fold changes and two p-values:

    <img
    src="https://render.githubusercontent.com/render/math?math=D_{\textrm{score}}=LFC_1\cdot LFC_2\cdot(-\log_10(q_1) - \log_10(q_2))">

    Calculate the disco score for Day 1 / Day 2 in the transcriptomic
    results table.

```r
tv <- tv %>% 
  mutate(disco=logFC.F.D1 * logFC.F.D2 * (-log10(qval.F.D1) -log10(qval.F.D2))) %>%
  arrange(abs(disco))
```

 4. Plot the log fold changes on day 1 vs log fold changes on day 2 and
    color them by the disco score

```r
## trim the disco
tv <- tv %>% mutate(disco_trim=ifelse(abs(disco) > 10, 10 * sign(disco), disco))
ggplot(tv, aes(x=logFC.F.D1, y=logFC.F.D2, color=disco_trim)) +
  geom_point(alpha=.5) +
  scale_color_gradient2(low="blue", mid="#CCCCCC", high="red", name="DISCO score") +
  xlab("Log2 FC on day 1") + ylab("Log2FC on day 2") +
  geom_abline(intercept=0, slope=1, color="grey")
```

# Session 4/3 (optional, send me the e-mail with the results)

 1. Create an alternative "summary" function for a data frame, such that if
    I type "summary(mtcars)" I will see the result of that function.
 2. Create a new class: sets. Define print and summary functions for this
    class.
 3. Use `+.sets` and `-.sets` etc. to define set operations on the set
    class.

# Session 4/4

 1. The data set [expression_data_vaccination_example.xlsx](https://raw.githubusercontent.com/january3/Radvanced2021/master/Datasets/expression_data_vaccination_example.xlsx) 
    (large file!) contains raw data (microarray log signals) of gene expression in human
    subjects who were vaccinated with an influenza vaccine on day 0. The
    excel file contains numerous sheets; figure out what they are (one of
    them is the expression matrix containing the actual data).  
 
 2. Using t.test and lapply (or map), find the genes with the largest
    significant differences on day 1. Hint: for a gene in row 1 of the
    expression matrix, you need to figure out which samples are from day 0,
    which are from day 1, and then run `t.test(expr[1, day0], expr[1, day1])`.
    Another hint: t.test returns a list. One of the elements of that list
    is a p.value. Use padjust to correct the p-values for multiple testing.

 3. Use a beeswarm (beeswarm package for base R, ggbeeswarm with the
    `geom_beeswarm` for the ggplot2) representation to show the differences
    between day 0 and day 1 for the genes with the lowest p-value.
