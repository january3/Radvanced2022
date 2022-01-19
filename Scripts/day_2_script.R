
#' simple implementation of lapply using a for loop
#' 
#' simple_lapply applies the function func to each element of a list, 
#' stores them, and returns them as a list
#' @value a list of the same length as input_list
#' @param input_list a list with some elements
#' @param func a function 
simple_lapply <- function(input_list, func) {
  ret <- list()

  for(i in 1:length(input_list)) {
    ret[[i]] <- func(input_list[[i]])
  }
  
  names(ret) <- names(input_list)

  ret
}


test_data <- list(a=c(1, 2, 3), b=c(10, 19), c=c(10, 100, 100))
simple_lapply(test_data, mean)

test_data[["a"]]
test_data[ "a" ]
test_data[ c("a", "c")]
test_data[ 1:2 ]

sel <- lapply(test_data, length)
sel <- unlist(sel)
sel <- sel > 2
test_data[ sel ]

test_data[ ]

is.list(test_data[["a"]])
is.list(test_data["a"])


test_data$a

test_data[["a name"]] <- c(1, 10, 100)
test_data$`a name`

df <- data.frame(ID=c("A", "B", "C"), a=c(1,2,3), b=c(10, 100, 1000))
df[["a"]]
df[, "a"]

mm <- matrix(rnorm(10), ncol=2)
mm[, 1]
mm[1, ]

vec <- 1:10
vec[1] <- "a"
vec

df[ , 1]
df[ , 1:2]

mm[ , 1:2]

df[[1]]

class(df[ 1, ])
class(df[ , 1])



nonzerov <- function(df) {
  vars <- lapply(df, var)
  
  sel <- vars > 0  
  
  df[ , sel]
  
}

colorDF(starwars)


df1 <- data.frame(a=rnorm(5), b=rep(0, 5), c=rep(10, 5))
df_nv <- nonzerov(df1)
print(dim(df_nv))

starwars
print(starwars, n=Inf)
print(test_data)


fn <- "Datasets/WIID_19Dec2018.xlsx"
excel_sheets(fn)
wiid <- read_excel(fn)

sum(is.na(wiid$q1))

lapply(wiid, function(x) sum(is.na(x)))
count_na <- function(x) sum(is.na(x))
lapply(wiid, count_na)

print(summary_colorDF(wiid, numformat="graphics"), n=Inf)

colorDF_themes_show()
options(colorDF_theme="minimal")


b <- func1(a)
c <- func2(b)
d <- func3(c)

d <- func3(func2(func1(a)))

d <- a %>% func1 %>% func2 %>% func3

wiid_ger <- wiid[ wiid$country == "Germany", ]
wiid_ger <- filter(wiid, country == "Germany")
country
wiid_ger <- with(wiid, wiid[ country == "Germany", ])

wiid_ger <- select(filter(wiid, country == "Germany"), year, gini_reported)
wiid_ger <- wiid %>% filter(country == "Germany") %>% select(year, gini_reported)

library(magrittr)
wiid %<>% filter(country == "Germany")



test_data %>% { Reduce(c, .) }
`%>%`(test_data, { Reduce(c, .) })
Reduce(c, test_data)
reduce(test_data, c) ## make sure there is no c variable!

test_data %>% reduce(c)

`%>%` <- function(data, expresssion) {
  . <- data
  
  
  
}
 

`+`(2, 4)



nums <- 3:9

r_numbers <- lapply(nums, function(.) rnorm(.)) %>% set_names(paste0("RN", nums))
names(r_numbers) <- paste0("RN", nums)


avg_mass_summary <- starwars %>% 
  group_by(homeworld) %>% 
  filter(!is.na(mass)) %>%  
  summarise(avg_body_mass=mean(mass)) %>%
  arrange(desc(avg_body_mass))

starwars[ , c("name", "homeworld")]

sel <- lapply(starwars, is.numeric)
starwars[ , sel == TRUE ]
as.data.frame(starwars)[ , sel ]

sel <- grep("^h", colnames(starwars))
starwars[ , sel ]

starwars %>% select(starts_with("h"))
starwars %>% select(where(is.numeric))

starwars %>% select(where(is.character)) %>% select(where(any(is.na)))

no_na <- function(x) !any(is.na(x))
any_na(c(1, 2, 3, NA))
starwars %>% select(where(is.character)) %>% 
  select(where(~ !any(is.na(.))))

df
df[ c(TRUE, TRUE, FALSE),  ]
df[ c(1, 2), ]

df %>% filter(c(TRUE, TRUE, FALSE))
df %>% slice(c(1,2)) %>% pull("b")

df[["b"]]
`[[`(df, "b")

#! incorrect!
wiid %>% filter(region_un == "Europe" && year == 2016)

c(TRUE, FALSE) && c(TRUE, TRUE)
c(TRUE, FALSE) &  c(TRUE, TRUE)

wiid %>% drop_na(country, year, gini_reported, q1:q5, d1:d10) %>% 
  summary_colorDF %>% print(n=Inf)

ret <- wiid %>% group_by(region_un) %>% 
  drop_na(gini_reported) %>%
  filter(year == 2016) %>%
  select(country, region_un, gini_reported, quality) %>%
  mutate(quality=factor(quality, levels=c("High", "Average", "Low", "Not known"))) %>%
  arrange(quality) %>%
  filter(!duplicated(country)) %>%
  summarise(n=n(),
            mean_gini=mean(gini_reported),
            median_gini=median(gini_reported),
            iqr_low=quantile(gini_reported, .25),
            iqr_top=quantile(gini_reported, .75))

sel <- duplicated(c(1, 1, 2))
c(1, 1, 2)[ !sel ]
unique(c(1,1,2))



