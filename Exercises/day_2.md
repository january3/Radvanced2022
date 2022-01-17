# Session 2/0: Rmarkdown

 1. Create an Rmarkdown document using Rstudio. Test **bold**, *italics*, 
    subscript (`a~2~`), superscript (`a^2^`)
 
 1. Insert a code block (see example code blocks in the document)

 2. Make it an HTML file, a Word document, an HTML presentation

 3. Create a table with markdown.

 4. Create an R code block with a table (you can use `kable` and `mtcars`,
    like in the lecture). Customize the table layout (check the options for
    kable in the manual).

 5. Click on the little gear to the right of your code block. How can you
    hide the output? Hide the code? Does it make sense to hide code?

 7. Extra: load the package "DT". In a code block, enter the following:
    `datatable(mtcars)`. What is the output? What happens when you type the
    same in Rstudio?

 6. Extra: load the package "pander". Apply the function `pander` to
    various data types: vectors, numbers, data frames etc. Compare the
    table output from pander and kable.


# Session 2/1: reading in tidyverse

 1. Which package from tidyverse allows you to read Excel files? Find it
    using `??`

 3. Use the package `readxl`. The function `readxl_example("deaths.xls")` returns a file name. Read
    this file using `read_excel`. How can you omit the lines at the top and at the bottom of
    the file?  (hint: `?read_excel`).
 
 2. Read the World Inequality Database file
    ([WIID_19Dec2018.xlsx](../Datasets/WIID_19Dec2018.xlsx)). This is a
    spreadsheet containing world income inequality data.

 2. Read the Excel sheet into R. How can you find out how many sheets are
    in the file (without opening it in Excel, of course! Hint:
    `?excel_sheets`).

 2. Examine the tibble produced by the `read_...` function. `q1..q5` are the
    quantiles and `d1..d10` are the deciles. I.e., `q1` equal to 9 means
    that the lower income 20% of the population owns 9% of the overall
    wealth. The Gini coefficient ranges from 0 (perfect equality) to 100%
    (perfect inequality).

 3. How many NA's are there in different columns? 



# Session 2/2: pipes and dplyr

 3. Which countries have the highest / lowest Gini coefficient? (use
    `arrange` to sort the data) Which countries had the highest / lowest
    Gini coefficient in 2016? (`filter` + `arrange`) Where is Germany on that scale?

 2. With the world inequality data base, try the following:

     * select only rows corresponding to the XXIst century
     * select only rows corresponding to the XXIst century *and* Europe
     * select only columns corresponding to quantiles and countries. Rename
       the quantiles to use uppercase
     * *reasonably* remove all incomplete rows (use `drop_na`)
     * summarize data by continent and by country
 
# Session 2/3: advanced tidyverse

 2. Using tidyverse, read, inspect and correct (if reasonable) the following files:

    * [cars.xlsx](../Data/cars.xlsx)
    * [iris.csv](../Data/iris.csv)

 2. Construct a tidyverse pipe with the following steps:

     1. Select only entries from 2016
     2. Remove duplicate entries for each country (you can use the
        `duplicated` function for that)
     3. Select the columns id, country and the quantile columns
     4. Use the `pivot_wider` function to create a long version of the table 
     5. Remove rows containing NA's using the `drop_na` function
     6. Send me your code by e-mail.

 3. Using `group_by`, `summary` and `arrange` find out for which year there
    are the most data? For which year the overall average gini coefficient
    is highest / lowest? (mind the NA's!). Plot the average Gini
    coefficient over time.

# Session 2/4: wide vs long

 1. Convert the following files to long format:

    * `iris.csv`
    * `mtcars_wide.csv`
    * `labresults_wide.csv`
    * `cars.xlsx` (tricky!)

 3. Load the world energy use data (`world_energy.tsv`). Change it from
    wide to long format.

 4. Using built-in data sets from `tidyr`, `table{1,2,3,4a,4b,5}` convert
    them from wide to long and viceversa. Use `separate` on `table5` to
    change `rate` into `cases` and `population`.





