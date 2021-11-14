# HW5: dplyr
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package and use `read_csv` to load
#    `/course/data/abalone.csv` and assign it to a tibble `abalone`.
#
#    To check your answer:
#
#    The output of `print(abalone, n = 5)` is
#
#    ```
#    # A tibble: 4,177 x 10
#          X sex   length diameter height whole_weight shucked_weight
#      <dbl> <chr>  <dbl>    <dbl>  <dbl>        <dbl>          <dbl>
#    1     1 M      0.455    0.365  0.095        0.514         0.224
#    2     2 M      0.35     0.265  0.09         0.226         0.0995
#    3     3 F      0.53     0.42   0.135        0.677         0.256
#    4     4 M      0.44     0.365  0.125        0.516         0.216
#    5     5 I      0.33     0.255  0.08         0.205         0.0895
#    # . with 4,172 more rows, and 3 more variables: viscera_weight <dbl>,
#    #   shell_weight <dbl>, rings <dbl>
#    ```
#
## Do not modify this line!

library(tidyverse)
abalone <- read_csv("/course/data/abalone.csv") 

# 2. Extract a tibble `length_sex_ring` which contains the `sex`, `diameter`,
#    `height` and `rings` columns. The dataset should be filtered for
#    length strictly larger than 0.6 and be sorted by increasing `sex` and
#    decreasing `ring`.
#    To do that, you can use
#      - `filter` to select rows that have `length` larger than 0.6,
#      - `arrange` to arrange data set by sex with first `"F"` then `"I"`
#        and `"M"`, and descending order of `ring`,
#      - `dplyr::select` to select columns `sex`, `diameter`, `height` and
#        `rings`.
#    Note: by doing `dplyr::`, we enforce the use of `dplyr`'s `select` to
#    resolve function conflicts with other packages such as `MASS`.
#
#    To check your answer:
#
#    The output of `print(length_sex_ring, n = 5)` is
#
#    ```
#    # A tibble: 1,216 x 4
#      sex   diameter height rings
#      <chr>    <dbl>  <dbl> <dbl>
#    1 F        0.585  0.185    29
#    2 F        0.49   0.215    25
#    3 F        0.54   0.215    24
#    4 F        0.47   0.2      23
#    5 F        0.52   0.225    23
#    # . with 1,211 more rows
#    ```
#
## Do not modify this line!

length_sex_ring <- abalone %>% dplyr::filter(length > 0.6) %>% dplyr::select(sex, diameter, height, rings) %>% arrange(sex, desc(rings))

# 3. Extract a tibble `count_prop` of dimension 3 x 3,
#    which contains the `sex`, `count` and `prop` columns.
#    The dataset should be grouped by increasing `sex` with counted numbers
#    of each group. Then calculate the proportion of each count.
#    To do that, you can use
#      - `count` to count observations by `sex` (set the `name` argument
#        as `"count"`),
#      - `mutate` to make a new column containing the poportion per sex
#        (i.e., `count / sum(count)`) and name it `prop`.
#
#    To check your answer:
#
#    The output of `print(count_prop, n = 5)` is
#
#    ```
#    # A tibble: 3 x 3
#      sex   count  prop
#      <chr> <int> <dbl>
#    1 F      1307 0.313
#    2 I      1342 0.321
#    3 M      1528 0.366
#    ```
#
## Do not modify this line!

count_prop <- abalone %>% count(sex, name = "count") %>% mutate(prop = count/sum(count)) %>% arrange(sex)

# 4. Extract a tibble `mean_max_min` of dimension 3 x 4, which contains the
#    `sex`, `weight_mean`, `weight_max` and `weight_min` columns.
#    The dataset should be grouped by increasing `sex` and summarized by
#    finding mean, max and min of `shucked_weight`.
#    To do that, you can use
#      - `group_by` to group data set by `sex`,
#      - `summarize` to to collapse all values into three new columns:
#        `weight_mean`, `weight_max` and `weight_min`, where
#          - `weight_mean` should be the mean of `shucked_weight`,
#          - `weight_min` should be min of `shucked_weight`,
#          - `weight_max` should be max of `shucked_weight`.
#
#    To check your answer:
#
#    The output of `print(mean_max_min, n = 5)` is
#
#    ```
#    # A tibble: 3 x 4
#      sex   weight_mean weight_max weight_min
#      <chr>       <dbl>      <dbl>      <dbl>
#    1 F           0.446      1.49      0.031
#    2 I           0.191      0.774     0.001
#    3 M           0.433      1.35      0.0065
#    ```
#
## Do not modify this line!

mean_max_min <- abalone %>% group_by(sex) %>% summarize(weight_mean = mean(shucked_weight),  weight_max = max(shucked_weight),weight_min = min(shucked_weight))

# 5. Extract a tibble `filter_na` of dimension 2963 x 10,
#    which contains all columns. The dataset should be filtered for diameter
#    equal to `NA` or strictly greater than 0.36. The column `X` should be
#    renamed as `index` and you should also reorder the columns such that
#    `index`, `sex`, `length`, `diameter` and `rings` come first and then
#    the other columns appear in their original order.
#    To do that, you can use
#      - `filter` to select rows such that `diameter` is `NA` or greater
#         than 0.36,
#      - `rename` to rename `X` as `index`,
#      - `select` and `everything` to select all columns with first five
#        columns as `index`, `sex`, `length`, `diameter` and `rings`.
#
#    To check your answer:
#
#    The output of `print(filter_na, n = 5)` is
#
#    ```
#    # A tibble: 2,938 x 10
#      index sex   length diameter rings height whole_weight shucked_weight
#      <dbl> <chr>  <dbl>    <dbl> <dbl>  <dbl>        <dbl>          <dbl>
#    1     1 M      0.455    0.365    15  0.095        0.514          0.224
#    2     3 F      0.53     0.42      9  0.135        0.677          0.256
#    3     4 M      0.44     0.365    10  0.125        0.516          0.216
#    4     7 F      0.53     0.415    20  0.15         0.778          0.237
#    5     8 F      0.545    0.425    16  0.125        0.768          0.294
#    # . with 2,933 more rows, and 2 more variables: viscera_weight <dbl>,
#    #   shell_weight <dbl>
#    ```
#
## Do not modify this line!

filter_na <- abalone %>% filter(is.na(diameter)|diameter > 0.36) %>% rename(index = X) %>% dplyr::select(index, sex, length, diameter, rings, everything())

# 6. Extract a tibble `transmute_abalone` of dimension 4177 x 2,
#    which contains the `whole_weight_in_mg` and `water_weight_in_mg` columns,
#    corresponding respectively to the whole weight and water weight in
#    milligrams.
#    To do that, you can use
#      - `transmute` to only keep two variables `whole_weight_in_mg` and
#        `water_weight_in_mg`, where
#          - `whole_weight_in_mg` is `whole_weight` times 1000,
#          - `water_weight_in_mg` is `whole_weight` minus all the other
#            weights times 1000.
#    Alternatively, you can do the same in two steps using `mutate` and then
#    `select`.
#
#    To check your answer:
#
#    The output of `print(transmute_abalone, n = 5)` is
#
#    ```
#    # A tibble: 4,177 x 2
#      whole_weight_in_mg water_weight_in_mg
#                   <dbl>              <dbl>
#    1               514               38.5
#    2               226.               7.50
#    3               677               69.
#    4               516               31.5
#    5               205               21.0
#    # . with 4,172 more rows
#    ```
#
## Do not modify this line!

transmute_abalone <- abalone %>% transmute(whole_weight_in_mg = whole_weight * 1000, water_weight_in_mg = whole_weight* 1000 - shucked_weight*1000 - viscera_weight*1000 - shell_weight*1000)

# 7. Extract a tibble `first_1000_rank` of dimension 1000 x 3,
#    which contains the `diameter`, `rings` and `rings_rank` columns, sorted
#    by ascending `rings_rank`, which is a column containing the rank
#    corresponding to the value of the `rings` variable.
#    Then, select the three columns and rank on the `rings` and
#    filter for the rows corresponding to the first 1000 `rings_rank`.
#    To do that, you can use
#      - `select` to select `diameter` and `rings`,
#      - `mutate` and `row_number` to create a column `rings_rank`
#        corresponding to the ranks of the corresponding `rings`,
#      - `filter` to filter the rows such that `rings_rank` is less than or
#        equal to `1000`,
#      - `arrange` by `rings_rank`.
#
#    To check your answer:
#
#    The output of `print(first_1000_rank, n = 5)` is
#
#    ```
#    # A tibble: 1,000 x 3
#      diameter rings rings_rank
#         <dbl> <dbl>      <int>
#    1    0.055     1          1
#    2    0.1       2          2
#    3    0.1       3          3
#    4    0.09      3          4
#    5    0.12      3          5
#    # . with 995 more rows
#    ```
#
## Do not modify this line!

first_1000_rank <- abalone %>% dplyr::select(diameter, rings) %>% mutate(rings_rank = row_number(rings)) %>%filter(rings_rank<=1000)%>%arrange(rings_rank)

# 8. Extract a tibble `n_distinct_rings_by_sex` of dimension 3 x 2,
#    which contains the `sex` and `distinct_rings` columns.
#    The dataset should be grouped by `sex` and then summarized to
#    count distinct rings in each group.
#    To do that, you can use
#      - `group_by` to group data set by `sex`,
#      - `summarize` and `n_distinct` to build a new column called
#        `distinct_rings` counting the number of distinct rings of each group.
#
#    To check your answer:
#
#    The output of `print(n_distinct_rings_by_sex, n = 5)` is
#
#    ```
#    # A tibble: 3 x 2
#      sex   distinct_rings
#      <chr>          <int>
#    1 F                 23
#    2 I                 21
#    3 M                 24
#    ```
## Do not modify this line!

n_distinct_rings_by_sex <- abalone %>% group_by(sex) %>% summarize(distinct_rings = n_distinct(rings))



#    The output of `print(ea_na_75_85, n = 5)` is
#
#    ```
#    # A tibble: 15 x 5
#      country           gdp_percap life_expect population region
#      <chr>                  <dbl>       <dbl>      <dbl> <chr>
#    1 Hong Kong SAR, C.     58618.        84.2    7336600 East Asia & Pac.
#    2 Japan                 42281.        84.0  126994511 East Asia & Pac.
#    3 Macao SAR, China     105420.        83.8     612167 East Asia & Pac.
#    4 Singapore             87833.        82.8    5607283 East Asia & Pac.
#    5 Australia             46012.        82.5   24210809 East Asia & Pac.
#    # . with 10 more rows
#    ```
#
## Do not modify this line!

ea_na_75_85 <- longevity %>% filter(region %in% c("East Asia & Pacific","North America")) %>% filter(life_expect >= 75 & life_expect <=85) %>% arrange(desc(life_expect))

#   4. From `longevity` again, extract a tibble `top_10_perc_us` of dimension
#    19 x 6 that contains the `country`, `gdp_percap`, `life_expect`,
#    `population`, `region` and `perc_rank` columns, where
#    `perc_rank` is a new column corresponding to the percentile rank for
#    `life_expect` (hint: use `percent_rank()`). The dataset should be sorted
#    by decreasing `perc_rank` and filtered for countries with top 10%
#    `perc_rank` (i.e., `perc_rank` >= 0.9), plus `"United States"` (whose rank
#    may lie outside the top 10%).
#    To do this, you can use
#      - `mutate()` to create a new column `perc_rank`,
#      - `arrange()` to sort the result by `perc_rank` descendingly,
#      - `filter()` to find the countries in the top 10% `perc_rank` plus
#        `"United States"`.
#
#    To check your answer:
#
#    The output of `print(top_10_perc_us, n = 5)` is
#
#    ```
#    # A tibble: 19 x 6
#      country      gdp_percap life_expect population region      perc_rank
#      <chr>             <dbl>       <dbl>      <dbl> <chr>           <dbl>
#    1 Hong Kong S.     58618.        84.2    7336600 East Asia .     1.
#    2 Japan            42281.        84.0  126994511 East Asia .     0.994
#    3 Macao SAR, .    105420.        83.8     612167 East Asia .     0.989
#    4 Switzerland      63889.        82.9    8372413 Europe & C.     0.983
#    5 Spain            36305.        82.8   46484533 Europe & C.     0.977
#    # . with 14 more rows
#    ```
#
## Do not modify this line!

top_10_perc_us <- longevity %>% mutate(perc_rank = percent_rank(life_expect)) %>% arrange(desc(perc_rank)) %>% filter(perc_rank>=0.9 | country %in% "United States")

# 5. From `nations`, extract a tibble `gdp_by_region` of dimension 189 x 3
#    that contains the `region`, `year` and `total_gdp` columns, where
#    `total_gdp` is a new column containing the total real GDP by
#    `region` and `year`, with real GDP being the product of `gdp_percap` and
#    `population`. The unit of `total_gdp` should be trillions of dollars
#    (hint: divide the result by 1000000000000).
#    To do this, you can use
#      - `mutate()` to create a new column `gdp` to find the total GDP
#        (i.e., the product of `gdp_percap` and `population`),
#      - `group_by()` to group data by `region` and `year`,
#      - `summarize()` to `sum` the values of the total GDP and convert
#        in trillions of dollars (hint: set `na.rm = TRUE` when taking sum
#        since there might be NA's),
#
#    To check your answer:
#
#    The output of `print(gdp_by_region, n = 5)` is
#
#    ```
#    # A tibble: 189 x 3
#    # Groups:   region [7]
#      region               year total_gdp
#      <chr>               <dbl>     <dbl>
#    1 East Asia & Pacific  1990      5.59
#    2 East Asia & Pacific  1991      6.10
#    3 East Asia & Pacific  1992      6.57
#    4 East Asia & Pacific  1993      7.11
#    5 East Asia & Pacific  1994      7.71
#    # . with 184 more rows
#    ```
#
## Do not modify this line!

gdp_by_region <- nations %>% mutate(gdp = gdp_percap * population) %>% group_by(region, year)%>% summarize(total_gdp = sum(gdp, na.rm = TRUE)/1000000000000)

# 6. From `nations`, extract a tibble `p_countries` of dimension 5 x 2
#    that contains `income` and `p` columns. The dataset should be
#    contain data from 2016 and `p` should be a new column
#    containing the proportions of countries with `life_expect` over 70 by
#    `income`.
#    Hint: count for countries that satisfy the condition, then divide
#    by the total count using `n()`.
#    To do this, you can use
#      - `filter()` filter select rows corresponding to 2016,
#      - `group_by()` to group data by `income`,
#      - `summarize()` to find the proportions of countries with `life_expect`
#        over 70. (hint: set `na.rm = TRUE` when taking sum
#        since there might be NA's),
#
#    To check your answer:
#
#    The output of `print(p_countries, n = 5)` is
#
#    ```
#    # A tibble: 5 x 2
#      income                  p
#      <chr>               <dbl>
#    1 High income         0.841
#    2 Low income          0.118
#    3 Lower middle income 0.426
#    4 Not classified      0
#    5 Upper middle income 0.849
#    ```
## Do not modify this line!

p_countries <- nations %>% filter(year == 2016) %>% group_by(income) %>% summarise(p = sum(life_expect > 70, na.rm = TRUE)/n())


# HW5: dplyr3
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package as well as the `airquality` dataset and
#    assign it to a tibble `airquality` using `as_tibble`.
#
#    To check your answer:
#
#    The output of `print(airquality, n = 5)` is
#
#    ```
#    # A tibble: 153 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <int>   <int> <dbl> <int> <int> <int>
#    1    41     190   7.4    67     5     1
#    2    36     118   8      72     5     2
#    3    12     149  12.6    74     5     3
#    4    18     313  11.5    62     5     4
#    5    NA      NA  14.3    56     5     5
#    # . with 148 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
airquality <- as_tibble(airquality)

# 2. Replace the NA values in `Ozone` column from `airquality` by the mean
#    of the non NA values and save the result into tibble
#    `airquality_replace_na`.
#    To do that, you can use
#      - `replace_na` to replace the NA values with `mean` to compute the mean
#        for the non NA values.
#
#    To check your answer:
#
#    The output of `print(airquality_replace_na, n = 5)` is
#
#    ```
#    # A tibble: 153 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <dbl>   <int> <dbl> <int> <int> <int>
#    1  41       190   7.4    67     5     1
#    2  36       118   8      72     5     2
#    3  12       149  12.6    74     5     3
#    4  18       313  11.5    62     5     4
#    5  42.1      NA  14.3    56     5     5
#    # . with 148 more rows
#    ```
#
## Do not modify this line!

airquality_replace_na <- airquality %>% replace_na(list(Ozone = mean(airquality$Ozone, na.rm = TRUE)))

# 3. Remove the rows that contain NA values in `Solar.R` column from
#    `airquality_replace_na` and save the result into `airquality_remove_na`.
#    To do that, you can use `drop_na`.
#
#    To check your answer:
#
#    The output of `print(airquality_remove_na, n = 5)` is
#
#    ```
#    # A tibble: 146 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <dbl>   <int> <dbl> <int> <int> <int>
#    1    41     190   7.4    67     5     1
#    2    36     118   8      72     5     2
#    3    12     149  12.6    74     5     3
#    4    18     313  11.5    62     5     4
#    5    23     299   8.6    65     5     7
#    # . with 141 more rows
#    ```
#
## Do not modify this line!

airquality_remove_na <- airquality_replace_na %>% drop_na(Solar.R)

# 4. Extract the columns `Wind`, `Temp`, `Month`, and `Day` from
#    `airquality_remove_na`` and save the result into
#    `airquality_selected`. To do that, you can use `select`.
#
#    To check your answer:
#
#    The output of `print(airquality_selected, n = 5)` is
#
#    ```
#    # A tibble: 146 x 4
#       Wind  Temp Month   Day
#      <dbl> <int> <int> <int>
#    1   7.4    67     5     1
#    2   8      72     5     2
#    3  12.6    74     5     3
#    4  11.5    62     5     4
#    5   8.6    65     5     7
#    # . with 141 more rows
#    ```
#
## Do not modify this line!

airquality_selected <- airquality_remove_na %>% dplyr::select(Wind, Temp, Month, Day)

# 5. Extract from `airquality_selected` rows that correspond to data from July
#    onwards and save the result into `airquality_filtered`.
#    To do that, you can use `filter`.
#
#    To check your answer:
#
#    The output of `print(airquality_filtered, n = 5)` is
#
#    ```
#    # A tibble: 89 x 4
#       Wind  Temp Month   Day
#      <dbl> <int> <int> <int>
#    1   4.1    84     7     1
#    2   9.2    85     7     2
#    3   9.2    81     7     3
#    4  10.9    84     7     4
#    5   4.6    83     7     5
#    # . with 84 more rows
#    ```
#
## Do not modify this line!

airquality_filtered <- airquality_selected %>% filter(Month %in% c(7,8,9,10,11,12))

# 6. From `airquality_filtered`, create a new tibble `airquality_wind`
#    by modifying the `Wind` column so that:
#      - when the value is in `[1,9)`, the new value is `7.4`;
#      - when the value is in `[9,20]`, the new value is `11.5`;
#      - otherwise replace the value by `21`.
#    Save the result into `airquality_wind`.
#    To do that, you can combine
#      - `mutate` to modify the `Wind` column,
#      - and `case_when` as a generalized vectorized if.
#
#    To check your answer:
#
#    The output of `print(airquality_wind, n = 5)` is
#
#    ```
#    # A tibble: 89 x 4
#       Wind  Temp Month   Day
#      <dbl> <int> <int> <int>
#    1   7.4    84     7     1
#    2  11.5    85     7     2
#    3  11.5    81     7     3
#    4  11.5    84     7     4
#    5   7.4    83     7     5
#    # . with 84 more rows
#    ```
#
## Do not modify this line!

airquality_wind <- airquality_filtered %>% mutate(Wind = case_when(
  Wind >= 1 & Wind < 9 ~ 7.4,
  Wind >= 9 & Wind <= 20 ~ 11.5,
  Wind < 1 & Wind > 20 ~ 21
))

# 7. From `airquality_wind`, create a new tibble `airquality_temp`
#    by modifying the `Temp` column so that tthe temperature is in Celsius
#    instead of Fahrenheit.
#    Note: you can use the following conversion `(x - 32) * 5 / 9`.
#
#    To check your answer:
#
#    The output of `print(airquality_temp, n = 5)` is
#
#    ```
#    # A tibble: 89 x 4
#       Wind  Temp Month   Day
#      <dbl> <dbl> <int> <int>
#    1   7.4  28.9     7     1
#    2  11.5  29.4     7     2
#    3  11.5  27.2     7     3
#    4  11.5  28.9     7     4
#    5   7.4  28.3     7     5
#    # . with 84 more rows
#    ```
#
## Do not modify this line!

airquality_temp <- airquality_wind %>% mutate(Temp = (Temp - 32)*5/9)

# 8. Compute the average temperature for each month from `airquality_temp` and
#    save the result into `airquality_mean_temp`, where the column
#    corresponding to the temperature is called `mean_temp`.
#    To do that, you can use
#     - `group_by` to group by `month`,
#     - `summarize` and `mean` to compute mean values.
#
#    To check your answer:
#
#    The output of `print(airquality_mean_temp, n = 5)` is
#
#    ```
#    # A tibble: 3 x 2
#      Month mean_temp
#      <int>     <dbl>
#    1     7      28.8
#    2     8      28.8
#    3     9      24.9
#    ```
## Do not modify this line!

airquality_mean_temp <- airquality_temp %>% group_by(Month)%>%summarize(mean_temp = mean(Temp))


# HW5: dplyr4
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package as well as the `billboard` dataset.
#
#    To check your answer:
#
#    The output of `print(billboard, n = 5)` is
#
#    ```
#    # A tibble: 317 x 79
#      artist track date.entered   wk1   wk2   wk3   wk4   wk5   wk6   wk7
#      <chr>  <chr> <date>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#    1 2 Pac  Baby. 2000-02-26      87    82    72    77    87    94    99
#    2 2Ge+h. The . 2000-09-02      91    87    92    NA    NA    NA    NA
#    3 3 Doo. Kryp. 2000-04-08      81    70    68    67    66    57    54
#    4 3 Doo. Loser 2000-10-21      76    76    72    69    67    65    55
#    5 504 B. Wobb. 2000-04-15      57    34    25    17    17    31    36
#    # . with 312 more rows, and 69 more variables: wk8 <dbl>, wk9 <dbl>,
#    #   wk10 <dbl>, wk11 <dbl>, wk12 <dbl>, wk13 <dbl>, wk14 <dbl>,
#    #   wk15 <dbl>, wk16 <dbl>, wk17 <dbl>, wk18 <dbl>, wk19 <dbl>,
#    #   wk20 <dbl>, wk21 <dbl>, wk22 <dbl>, wk23 <dbl>, wk24 <dbl>,
#    #   wk25 <dbl>, wk26 <dbl>, wk27 <dbl>, wk28 <dbl>, wk29 <dbl>,
#    #   wk30 <dbl>, wk31 <dbl>, wk32 <dbl>, wk33 <dbl>, wk34 <dbl>,
#    #   wk35 <dbl>, wk36 <dbl>, wk37 <dbl>, wk38 <dbl>, wk39 <dbl>,
#    #   wk40 <dbl>, wk41 <dbl>, wk42 <dbl>, wk43 <dbl>, wk44 <dbl>,
#    #   wk45 <dbl>, wk46 <dbl>, wk47 <dbl>, wk48 <dbl>, wk49 <dbl>,
#    #   wk50 <dbl>, wk51 <dbl>, wk52 <dbl>, wk53 <dbl>, wk54 <dbl>,
#    #   wk55 <dbl>, wk56 <dbl>, wk57 <dbl>, wk58 <dbl>, wk59 <dbl>,
#    #   wk60 <dbl>, wk61 <dbl>, wk62 <dbl>, wk63 <dbl>, wk64 <dbl>,
#    #   wk65 <dbl>, wk66 <lgl>, wk67 <lgl>, wk68 <lgl>, wk69 <lgl>,
#    #   wk70 <lgl>, wk71 <lgl>, wk72 <lgl>, wk73 <lgl>, wk74 <lgl>,
#    #   wk75 <lgl>, wk76 <lgl>
#    ```
#
## Do not modify this line!

library(tidyverse)

# 2. Let's take a look at the `billboard` data: notice that there are 79
#    columns in total, with 76 columns representing the rankings of each week.
#    Put the week name into one column called `week` and store the ranking
#    into another column called `rank`, keep the first three column names,
#    save the new tibble into `t1`, which will have 24,092 rows and 5 columns.
#    To do that, you can use `pivot_longer` and `starts_with`.
#    Hint: pay attention to the `cols`, `names_to` and `values_to` arguments.
#
#    To check your answer:
#
#    The output of `print(t1, n = 5)` is
#
#    ```
#    # A tibble: 24,092 x 5
#      artist track                   date.entered week   rank
#      <chr>  <chr>                   <date>       <chr> <dbl>
#    1 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk1      87
#    2 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk2      82
#    3 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk3      72
#    4 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk4      77
#    5 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk5      87
#    # . with 24,087 more rows
#    ```
#
## Do not modify this line!

t1 <- billboard %>% pivot_longer(starts_with("wk"),
                                 names_to = "week",
                                 values_to = "rank")

# 3. We can notice that, in `t1`,
#      - the rank includes a lot of `NA` values,
#      - the `wk` in front of each `week` is redundant.
#    So let's do the same as in the previous question, but this time
#    additionally dropping the `NA` values and changing `wk{number}` to
#    `{number}` for the `week` column as well.
#    Hint: to do so, you can start from `billboard` dataset and use
#    `pivot_longer` again, but further paying attention to the `names_prefix`
#    and `values_drop_na` arguments.
#    Save your result into `t2`.
#
#    To check your answer:
#
#    The output of `print(t2, n = 5)` is
#
#    ```
#    # A tibble: 5,307 x 5
#      artist track                   date.entered week   rank
#      <chr>  <chr>                   <date>       <chr> <dbl>
#    1 2 Pac  Baby Don't Cry (Keep... 2000-02-26   1        87
#    2 2 Pac  Baby Don't Cry (Keep... 2000-02-26   2        82
#    3 2 Pac  Baby Don't Cry (Keep... 2000-02-26   3        72
#    4 2 Pac  Baby Don't Cry (Keep... 2000-02-26   4        77
#    5 2 Pac  Baby Don't Cry (Keep... 2000-02-26   5        87
#    # . with 5,302 more rows
#    ```
#
## Do not modify this line!

t2 <- billboard %>% pivot_longer(starts_with("wk"),
                                 names_to = "week",
                                 values_to = "rank",
                                 names_prefix = "wk",
                                 values_drop_na = TRUE)

# 4. From `t2`, we now want to check the highest weekly rank increase.
#    For example, for the first track `Baby Don't Cry (Keep...`, its weekly
#    ranking is 87, 82, 72, 77, 87, 94, 99, so the highest rank increase will
#    be 82-72=10 from week 2 to week 3. For each track, compute its highest
#    rank increase, and save the answer in the column `highest_rank_increase`.
#    To do that, you can use
#      - `mutate` and `lag` to calculate the rank difference,
#      - `filter` to filter out the information for week 1 (because week 1 is
#        the first week for which the song has a rank thus there is no rank
#        increase),
#      - `group_by` to group the data by `artist`, `track`, and `date.entered`,
#      - `summarize` to find out the maximum of rank difference and call this
#        column `highest_rank_increase`,
#      - `arrange` to sort by descending `highest_rank_increase`.
#    Save your answer into `t2_rank`.
#
#    To check your answer:
#
#    The output of `print(t2_rank, n = 5)` is
#
#    ```
#    # A tibble: 313 x 4
#    # Groups:   artist, track [313]
#      artist         track                date.entered highest_rank_incre.
#      <chr>          <chr>                <date>                     <dbl>
#    1 Kenny G        Auld Lang Syne (The. 1999-12-25                    82
#    2 Martin, Ricky  Shake Your Bon-Bon   1999-11-20                    63
#    3 Sisqo          Incomplete           2000-06-24                    53
#    4 Houston, Whit. I Learned From The . 2000-02-19                    43
#    5 Destiny's Chi. Say My Name          1999-12-25                    39
#    # . with 308 more rows
#    ```
#
## Do not modify this line!

t2_rank <- t2 %>% mutate(rank_increase = lag(rank)-rank) %>% filter(week != 1) %>% group_by(artist, track, date.entered)%>% summarize(highest_rank_increase = max(rank_increase)) %>% arrange(desc(highest_rank_increase))

# 5. Coming back to `t2`, we now want to have the `year`, `month` and `date`
#    information seperately. We can thus use `seperate` function to seperate
#    the `date.entered` into `year`, `month`, and `date`, e.g.
#    `2000-02-26` becomes `2000`, `02`, and `26`.
#    Save your result into `t3`.
#
#    To check your answer:
#
#    The output of `print(t3, n = 5)` is
#
#    ```
#    # A tibble: 5,307 x 7
#      artist track                   year  month date  week   rank
#      <chr>  <chr>                   <chr> <chr> <chr> <chr> <dbl>
#    1 2 Pac  Baby Don't Cry (Keep... 2000  02    26    1        87
#    2 2 Pac  Baby Don't Cry (Keep... 2000  02    26    2        82
#    3 2 Pac  Baby Don't Cry (Keep... 2000  02    26    3        72
#    4 2 Pac  Baby Don't Cry (Keep... 2000  02    26    4        77
#    5 2 Pac  Baby Don't Cry (Keep... 2000  02    26    5        87
#    # . with 5,302 more rows
#    ```
#
## Do not modify this line!

t3 <- t2 %>% separate(date.entered, into = c("year", "month", "date"))

# 6. Use `group_by` to group `t3` by `artist`, `track` and `month`.
#    Then, use `summarize` to add another column called `highest_rank`,
#    which represent the highest rank for each song and save your result into
#    `t4` which will have 317 rows and 4 columns.
#
#    To check your answer:
#
#    The output of `print(t4, n = 5)` is
#
#    ```
#    # A tibble: 317 x 4
#    # Groups:   artist, track [317]
#      artist       track                   month highest_rank
#      <chr>        <chr>                   <chr>        <dbl>
#    1 2 Pac        Baby Don't Cry (Keep... 02              72
#    2 2Ge+her      The Hardest Part Of ... 09              87
#    3 3 Doors Down Kryptonite              04               3
#    4 3 Doors Down Loser                   10              55
#    5 504 Boyz     Wobble Wobble           04              17
#    # . with 312 more rows
#    ```
#
## Do not modify this line!

t4 <- t3 %>% group_by(artist, track, month) %>% summarize(highest_rank = min(rank))

# 7. Let's go back to the original `billborad`. We now want to look at the
#    highest ranks of the songs in their first week of entering the top 100
#    and save the result into `t5`.
#    To do that, you can use
#      - `filter` to filter out the `NA` values in `wk1` if there's any,
#      - `arrange` to sort them by acending week 1 rank,
#      - `select` to include only the columns  `artist`, `track`,
#         `date.entered` and `wk1_rank`.
#
#    To check your answer:
#
#    The output of `print(t5, n = 5)` is
#
#    ```
#    # A tibble: 317 x 4
#      artist                         track           date.entered wk1_rank
#      <chr>                          <chr>           <date>          <dbl>
#    1 "Santana"                      Maria, Maria    2000-02-12         15
#    2 "Hanson"                       This Time Arou. 2000-04-22         22
#    3 "Pink"                         There U Go      2000-03-04         25
#    4 "Carey, Mariah"                Crybaby         2000-06-24         28
#    5 "Elliott, Missy \"Misdemeanor. Hot Boyz        1999-11-27         36
#    # . with 312 more rows
#    ```
#
## Do not modify this line!

t5 <- billboard %>% filter(!is.na(wk1))%>%arrange(wk1) %>% rename(wk1_rank = wk1) %>% select(artist, track, date.entered, wk1_rank)

# 8. Now, let's use `t1` to compute the average rank per artist for the
#    songs released in 2000 and save your result into `t6`.
#    To do that, you can use
#      - `filter` and `startsWith` to filter out the songs released in 1999,
#      - `group_by` to group by artist,
#      - `summarize` to calculate the average rank of songs for each  artist.
#
#    To check your answer:
#
#    The output of `print(t6, n = 5)` is
#
#    ```
#    # A tibble: 204 x 2
#      artist       avg_rank
#      <chr>           <dbl>
#    1 2 Pac            85.4
#    2 2Ge+her          90
#    3 3 Doors Down     37.6
#    4 504 Boyz         56.2
#    5 98^0             37.6
#    # . with 199 more rows
#    ```
## Do not modify this line!

t6 <- t1 %>% filter(startsWith(as.character(date.entered), "2000")) %>% group_by(artist) %>% summarize(avg_rank = mean(rank, na.rm = TRUE))

# HW5: dplyr5
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package and use `read_csv` to load
#    `/course/data/citybike.csv` and assign it to a tibble `trips`.
#
#    To check your answer:
#
#    The output of `print(trips, n = 5)` is
#
#    ```
#    # A tibble: 100,000 x 15
#      tripduration starttime stoptime  start station .  start station .
#             <dbl> <chr>     <chr>               <dbl> <chr>
#    1         5945 8/5/2016. 8/5/201.              228 E 48 St & 3 Ave
#    2         1494 8/3/2016. 8/3/201.              460 S 4 St & Wythe .
#    3          826 8/30/201. 8/30/20.             3301 Columbus Ave & .
#    4          278 8/15/201. 8/15/20.             3256 Pier 40 - Hudso.
#    5          729 8/8/2016. 8/8/201.              347 Greenwich St & .
#    # . with 99,995 more rows, and 10 more variables:  start station
#    #   latitude  <dbl>,  start station longitude  <dbl>,  end station
#    #   id  <dbl>,  end station name  <chr>,  end station
#    #   latitude  <dbl>,  end station longitude  <dbl>, bikeid <dbl>,
#    #   usertype <chr>,  birth year  <dbl>, gender <dbl>
#    ```
#
## Do not modify this line!

library(tidyverse)
trips <- read_csv("/course/data/citybike.csv")

# 2. Use `rename_all` and `str_replace_all` to replace the spaces in column
#    names with underscores `_`. This will make it easier to manipulate those
#    columns.
#
#    To check your answer:
#
#    The output of `print(trips, n = 5)` is
#
#    ```
#    # A tibble: 100,000 x 15
#      tripduration starttime stoptime start_station_id start_station_n.
#             <dbl> <chr>     <chr>               <dbl> <chr>
#    1         5945 8/5/2016. 8/5/201.              228 E 48 St & 3 Ave
#    2         1494 8/3/2016. 8/3/201.              460 S 4 St & Wythe .
#    3          826 8/30/201. 8/30/20.             3301 Columbus Ave & .
#    4          278 8/15/201. 8/15/20.             3256 Pier 40 - Hudso.
#    5          729 8/8/2016. 8/8/201.              347 Greenwich St & .
#    # . with 99,995 more rows, and 10 more variables:
#    #   start_station_latitude <dbl>, start_station_longitude <dbl>,
#    #   end_station_id <dbl>, end_station_name <chr>,
#    #   end_station_latitude <dbl>, end_station_longitude <dbl>,
#    #   bikeid <dbl>, usertype <chr>, birth_year <dbl>, gender <dbl>
#    ```
#
## Do not modify this line!

trips <- trips %>% rename_all(funs(str_replace_all(names(trips)," ","_")))

# 3. Find the largest and smallest birth year of people that took trips
#    in August 2016. Assign the result to a tibble `years` with only two columns
#    `min_birth_year` and `max_birth_year` (in this order), and only one row.
#    To do that, you can use
#      - `summarize()`, `min()` and `max()` - make sure you use the
#        `na.rm` argument of `min()` and `max()` wisely.
#
#    To check your answer:
#
#    The output of `print(years, n = 0)` is
#
#    ```
#    # A tibble: 1 x 2
#    # . with 1 more row, and 2 variables: min_birth_year <dbl>,
#    #   max_birth_year <dbl>
#    ```
#
## Do not modify this line!

years <- trips %>% summarize(min_birth_year = min(birth_year, na.rm = TRUE), max_birth_year = max(birth_year, na.rm = TRUE))

# 4. Find all trips that started or ended on Broadway. Assign the result to
#    tibble `broadway`, which should be similar to `trips`, but only contain
#    the trips that started or ended on Broadway.
#    To do that, you can use
#      - `filter()` and `str_detect()`.
#
#    To check your answer:
#
#    The output of `print(broadway, n = 5)` is
#
#    ```
#    # A tibble: 18,603 x 15
#      tripduration starttime stoptime start_station_id start_station_n.
#             <dbl> <chr>     <chr>               <dbl> <chr>
#    1          826 8/30/201. 8/30/20.             3301 Columbus Ave & .
#    2         2440 8/28/201. 8/28/20.             3147 E 85 St & 3 Ave
#    3          660 8/16/201. 8/16/20.              362 Broadway & W 37.
#    4         1458 8/1/2016. 8/1/201.              321 Cadman Plaza E .
#    5          534 8/6/2016. 8/6/201.              536 1 Ave & E 30 St
#    # . with 18,598 more rows, and 10 more variables:
#    #   start_station_latitude <dbl>, start_station_longitude <dbl>,
#    #   end_station_id <dbl>, end_station_name <chr>,
#    #   end_station_latitude <dbl>, end_station_longitude <dbl>,
#    #   bikeid <dbl>, usertype <chr>, birth_year <dbl>, gender <dbl>
#    ```
#
## Do not modify this line!

broadway <- trips %>% filter(str_detect(start_station_name,"Broadway")| str_detect(end_station_name,"Broadway"))

# 5. Create a `trips_counts` tibble that contains the counts of each
#    possible trip (one possible trip = one starting station and one ending
#    station). It should contain three columns: `start_station_name`,
#    `end_station_name` and `count`.
#    To do that, you can use
#      - `group_by()` to group by `start_station_name` and `end_station_name`,
#      - `summarize()` along with `n()` to compute the counts across groups.
#
#    To check your answer:
#
#    The output of `print(trips_counts, n = 5)` is
#
#    ```
#    # A tibble: 46,115 x 3
#    # Groups:   start_station_name [564]
#      start_station_name end_station_name count
#      <chr>              <chr>            <int>
#    1 1 Ave & E 16 St    1 Ave & E 16 St      3
#    2 1 Ave & E 16 St    1 Ave & E 18 St      4
#    3 1 Ave & E 16 St    1 Ave & E 30 St      9
#    4 1 Ave & E 16 St    1 Ave & E 44 St      1
#    5 1 Ave & E 16 St    1 Ave & E 68 St      2
#    # . with 46,110 more rows
#    ```
#
## Do not modify this line!

trips_counts <- trips %>% group_by(start_station_name, end_station_name) %>% summarize(count = n())

# 6. Extract from `trips_counts` a tibble `frequent_trips` containing the 10
#    most frequent station-to-station trips.
#    To do that, you can use
#      - `arrange` and `desc` to re-order `trips_counts` in descending order
#         of `count`,
#      - `head()` to retain only the 10 first elements.
#
#    To check your answer:
#
#    The output of `print(frequent_trips, n = 5)` is
#
#    ```
#    # A tibble: 10 x 3
#    # Groups:   start_station_name [6]
#      start_station_name      end_station_name        count
#      <chr>                   <chr>                   <int>
#    1 Central Park S & 6 Ave  Central Park S & 6 Ave     73
#    2 Central Park S & 6 Ave  5 Ave & E 88 St            62
#    3 E 7 St & Avenue A       Cooper Square & E 7 St     48
#    4 Central Park S & 6 Ave  5 Ave & E 73 St            46
#    5 Centre St & Chambers St Centre St & Chambers St    46
#    # . with 5 more rows
#    ```
## Do not modify this line!

frequent_trips <- trips_counts %>% arrange(desc(count))%>%head(10)

# HW5: dplyr6
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package and use `read_csv` to load
#    `/course/data/airbnb.csv` and assign it to a tibble `airbnb`.
#
#    To check your answer:
#
#    The output of `print(airbnb, n = 5)` is
#
#    ```
#    # A tibble: 48,895 x 16
#         id name  host_id host_name neighbourhood_g. neighbourhood
#      <dbl> <chr>   <dbl> <chr>     <chr>            <chr>
#    1  2539 Clea.    2787 John      Brooklyn         Kensington
#    2  2595 Skyl.    2845 Jennifer  Manhattan        Midtown
#    3  3647 THE .    4632 Elisabeth Manhattan        Harlem
#    4  3831 Cozy.    4869 LisaRoxa. Brooklyn         Clinton Hill
#    5  5022 Enti.    7192 Laura     Manhattan        East Harlem
#    # . with 48,890 more rows, and 10 more variables: latitude <dbl>,
#    #   longitude <dbl>, room_type <chr>, price <dbl>,
#    #   minimum_nights <dbl>, number_of_reviews <dbl>,
#    #   last_review <date>, reviews_per_month <dbl>,
#    #   calculated_host_listings_count <dbl>, availability_365 <dbl>
#    ```
#
## Do not modify this line!

library(tidyverse)
airbnb <- read_csv("/course/data/airbnb.csv")

# 2. We want to find the most expensive neighbourhood of NYC, so we need a
#    tibble containing the following information:
#      - `neighbourhood`, the name of the neighbourhood,
#      - `avg_price`, the average price of the apartments in that
#        neighbourhood,
#      - `price_rank`, the quantile of the average price of that neighbourhood,
#        among all neighbourhoods. E.g., if a neighbourhood is the second most
#        expensive of 5 neighbourhoods, its percent rank will be 0.75.
#    To do that, you can use
#        - `drop_na()` to remove the NAs,
#        - `group_by()` to group the apts by neighourhood,
#        - `summarize()` to calculate the average price of each neighbourhood,
#        - `mutate()` and `percent_rank()` to calculate the quantile of
#          each neighbourhood saved in column `price_rank`.
#    Save the result into `nyc_price`.
#
#    To check your answer:
#
#    The output of `print(nyc_price, n = 5)` is
#
#    ```
#    # A tibble: 218 x 3
#      neighbourhood avg_price price_rank
#      <chr>             <dbl>      <dbl>
#    1 Allerton           90.6     0.438
#    2 Arden Heights      67.2     0.0968
#    3 Arrochar          118.      0.659
#    4 Arverne           159.      0.802
#    5 Astoria           116.      0.645
#    # . with 213 more rows
#    ```
#
## Do not modify this line!

nyc_price <- airbnb %>% drop_na() %>% group_by(neighbourhood) %>% summarize(avg_price = mean(price)) %>% mutate(price_rank = percent_rank(avg_price))

# 3. Using `nyc_price`, find the top 10% most expensive neighbourhoods and
#    report them in alphabetical order.
#    Save the result tibble to `nyc_10percent`.
#    To do that, you can use
#         - `filter()` function to filter the `price_rank`,
#         - `arrange()` to reorder the neighbourhoods.
#
#    To check your answer:
#
#    The output of `print(nyc_10percent, n = 5)` is
#
#    ```
#    # A tibble: 22 x 3
#      neighbourhood      avg_price price_rank
#      <chr>                  <dbl>      <dbl>
#    1 Breezy Point            195       0.917
#    2 Brooklyn Heights        202.      0.922
#    3 Chelsea                 222.      0.940
#    4 Cobble Hill             193.      0.912
#    5 Financial District      219.      0.935
#    # . with 17 more rows
#    ```
#
## Do not modify this line!

nyc_10percent <- nyc_price %>% filter(price_rank >= 0.9) %>% arrange(neighbourhood)

# 4. Calculate the median price and median availability days of each room type
#    and save the result into `by_type`.
#    To do that, you can use
#       - `group_by()` to group the apartments by room type,
#       - `select()` to select columns `price` and `availability_365`,
#       - `summarize_if()` and `is.numeric` to calculate the median of each
#         group (pay attention to NAs).
#
#    To check your answer:
#
#    The output of `print(by_type, n = 1)` is
#
#    ```
#    # A tibble: 3 x 3
#      room_type       price availability_365
#      <chr>           <dbl>            <dbl>
#    1 Entire home/apt   160               42
#    # . with 2 more rows
#    ```
#
## Do not modify this line!

by_type <- airbnb %>% group_by(room_type) %>% dplyr::select(price, availability_365) %>% summarize_if(is.numeric,median,na.rm = TRUE)

# 5. To know the per room types count and proportions in different
#    neighbourhood, we need a tibble containing the following information:
#      - `neighbourhood`, as before,
#      - `room_type`, the type of room,
#      - `count`, the total number observations per room type/neighbourhood,
#      - `prop`, the corresponding proportion of each room type among all
#        the rooms in that neighbourhood.
#    Save the result tibble into `neighbourhood_room`.
#    To do that, you can use
#       - `group_by()` to group the apartments,
#       - `count()` to count the number of apartments in each group,
#       - `sum()` to sum the number of apartments in each group,
#       - `mutate()` to calculate the proportion and add new columnn `prop`.
#
#    To check your answer:
#
#    The output of `print(neighbourhood_room, n = 5)` is
#
#    ```
#    # A tibble: 15 x 4
#    # Groups:   neighbourhood_group [5]
#      neighbourhood_group room_type       count   prop
#      <chr>               <chr>           <int>  <dbl>
#    1 Bronx               Entire home/apt   379 0.347
#    2 Bronx               Private room      652 0.598
#    3 Bronx               Shared room        60 0.0550
#    4 Brooklyn            Entire home/apt  9559 0.475
#    5 Brooklyn            Private room    10132 0.504
#    # . with 10 more rows
#    ```
#
## Do not modify this line!

neighbourhood_room <- airbnb %>% group_by(neighbourhood_group)%>% count(room_type, name = "count") %>% mutate(prop = count/sum(count))

# 6. We want to convert `neighbourhood_group` into a new tibble
#   `neighbourhood_room_wider` that is nicer for reporting,
#    that is showing in three separate columns the proportion of each room
#    type within each neighbourhood.
#    To do that, you can use
#       - `select()` to remove the `count` column,
#       - `pivot_wider()` to make the tibble wider.
#
#    To check your answer:
#
#    The output of `print(neighbourhood_room_wider, n = 5)` is
#
#    ```
#    # A tibble: 5 x 4
#    # Groups:   neighbourhood_group [5]
#      neighbourhood_group  Entire home/apt   Private room   Shared room
#      <chr>                           <dbl>          <dbl>         <dbl>
#    1 Bronx                           0.347          0.598        0.0550
#    2 Brooklyn                        0.475          0.504        0.0205
#    3 Manhattan                       0.609          0.368        0.0222
#    4 Queens                          0.370          0.595        0.0349
#    5 Staten Island                   0.472          0.504        0.0241
#    ```
## Do not modify this line!

neighbourhood_room_wider <- neighbourhood_room %>% dplyr::select(-count) %>% pivot_wider(names_from = room_type,
                                                                                         values_from = prop)
# HW5: tidyr
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package and use `read_csv` to load
#    `/course/data/useR2016.csv` and assign it to a tibble `useR2016`.
#
#    To check your answer:
#
#    The output of `print(useR2016, n = 5)` is
#
#    ```
#    # A tibble: 455 x 48
#      Q2    Q3     Q7     Q8     Q11   Q12   Q13   Q13_B Q13_C Q13_D Q13_E
#      <chr> <chr>  <chr>  <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#    1 Men   > 35   Docto. Acade. > 10. Yes   I us. I wr. I wr. <NA>  <NA>
#    2 Men   > 35   Maste. Non-a. 2-5 . Yes   <NA>  <NA>  <NA>  <NA>  <NA>
#    3 Women 35 or. Maste. Non-a. < 2 . No    I us. <NA>  <NA>  <NA>  <NA>
#    4 Men   35 or. Docto. Acade. <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#    5 Men   35 or. Maste. Non-a. 2-5 . Yes   I us. I wr. I wr. <NA>  <NA>
#    # . with 450 more rows, and 37 more variables: Q13_F <chr>,
#    #   Q14 <chr>, Q15 <chr>, Q15_B <chr>, Q15_C <chr>, Q15_D <chr>,
#    #   Q16 <chr>, Q17 <chr>, Q17_B <chr>, Q18 <chr>, Q19 <chr>,
#    #   Q19_B <chr>, Q19_C <chr>, Q19_D <chr>, Q19_E <chr>, Q19_F <chr>,
#    #   Q19_G <lgl>, Q19_H <chr>, Q20 <chr>, Q20_B <chr>, Q21 <chr>,
#    #   Q22 <chr>, Q22_B <chr>, Q23 <chr>, Q24 <chr>, Q24_B <chr>,
#    #   Q24_C <chr>, Q24_D <chr>, Q24_E <chr>, Q24_F <chr>, Q24_G <chr>,
#    #   Q24_H <chr>, Q24_I <lgl>, Q24_J <chr>, Q24_K <chr>, Q24_L <chr>,
#    #   Q25 <dbl>
#    ```
#
## Do not modify this line!

library(tidyverse)
useR2016 <- read_csv("/course/data/useR2016.csv")

# 2. Use `select` to select columns `Q2` to `Q13_F` except `Q12`, as well as
#    column `Q25`, and save the result into a tibble `t1`.
#
#    To check your answer:
#
#    The output of `print(t1, n = 5)` is
#
#    ```
#    # A tibble: 455 x 12
#      Q2    Q3     Q7     Q8     Q11   Q13   Q13_B Q13_C Q13_D Q13_E Q13_F
#      <chr> <chr>  <chr>  <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#    1 Men   > 35   Docto. Acade. > 10. I us. I wr. I wr. <NA>  <NA>  <NA>
#    2 Men   > 35   Maste. Non-a. 2-5 . <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#    3 Women 35 or. Maste. Non-a. < 2 . I us. <NA>  <NA>  <NA>  <NA>  <NA>
#    4 Men   35 or. Docto. Acade. <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>
#    5 Men   35 or. Maste. Non-a. 2-5 . I us. I wr. I wr. <NA>  <NA>  <NA>
#    # . with 450 more rows, and 1 more variable: Q25 <dbl>
#    ```
#
## Do not modify this line!

t1 <- useR2016 %>% select(Q2:Q13_F,-Q12,Q25)

# 2. From `t1`, build a tibble `t1_longer` of dimension 1767 x 8,
#    which contains columns `Q2`, `Q3`, `Q7`, `Q8`, `Q11`, `Q25`, `cases`
#    and `comments`, where
#      -  `cases` correspond to the column names `Q13`, `Q13_B`, `Q13_C`,
#         `Q13_D`, `Q13_E`,  `Q13_F`,
#      - `comments` are the values contained in these columns,
#    without the `NA` values.
#    To do that, you can use
#      - `pivot_longer` on columns `Q13` to `Q13_F`, with
#        - `names_to` as `"cases"`,
#        - `values_to` as `"comments"`,
#        - and dropping all NAs (hint: look at the `values_drop_na` argument).
#
#    To check your answer:
#
#    The output of `print(t1_longer, n = 5)` is
#
#    ```
#    # A tibble: 1,767 x 8
#      Q2    Q3      Q7        Q8     Q11     Q25 cases comments
#      <chr> <chr>   <chr>     <chr>  <chr> <dbl> <chr> <chr>
#    1 Men   > 35    Doctorat. Acade. > 10.   442 Q13   I use functions fr.
#    2 Men   > 35    Doctorat. Acade. > 10.   442 Q13_B I write R code des.
#    3 Men   > 35    Doctorat. Acade. > 10.   442 Q13_C I write R function.
#    4 Women 35 or . Masters . Non-a. < 2 .   118 Q13   I use functions fr.
#    5 Men   35 or . Masters . Non-a. 2-5 .   650 Q13   I use functions fr.
#    # . with 1,762 more rows
#    ```
#
## Do not modify this line!

t1_longer <- t1 %>% pivot_longer(cols = c(Q13, Q13_B, Q13_C, Q13_D, Q13_E, Q13_F),
                                 names_to = "cases",
                                 values_to = "comments",
                                 values_drop_na = TRUE)

# 3. From `t1_longer`, build a tibble `t1_longer_rename` of dimension 1767 x 8
#    by using `rename()` on the following columns:
#      - `Q2` as `sex`,
#      - `Q3` as `age`,
#      - `Q7` as `degree`,
#      - `Q8` as `academic_status`,
#      - `Q11` as `experience`,
#      - `Q25` as `value`.
#
#    To check your answer:
#
#    The output of `print(t1_longer_rename, n = 5)` is
#
#    ```
#    # A tibble: 1,767 x 8
#      sex   age    degree academic_status experience value cases comments
#      <chr> <chr>  <chr>  <chr>           <chr>      <dbl> <chr> <chr>
#    1 Men   > 35   Docto. Academic        > 10 years   442 Q13   I use fu.
#    2 Men   > 35   Docto. Academic        > 10 years   442 Q13_B I write .
#    3 Men   > 35   Docto. Academic        > 10 years   442 Q13_C I write .
#    4 Women 35 or. Maste. Non-academic    < 2 years    118 Q13   I use fu.
#    5 Men   35 or. Maste. Non-academic    2-5 years    650 Q13   I use fu.
#    # . with 1,762 more rows
#    ```
#
## Do not modify this line!

t1_longer_rename <- t1_longer %>% rename(sex = Q2, age = Q3, degree = Q7, academic_status = Q8, experience = Q11, value = Q25)

# 4. From `t1_longer_rename`, extract a tibble `separate_drop_redundant`  which
#    doesn't contain the column `cases` anymore but instead contain the
#    column `category`:
#     - equal to `A` if `cases` is `Q13`,
#     - `B` if `cases` is `Q13_B`,
#     - `C` if `cases` is `Q13_C`.
#    To do that you can separate `cases` into 2 columns called `case_name`
#    and `category`, fill in NAs with `A` in `category`, and then delete
#    `case_name`.
#    More specifically, you can use
#      - `separate` to separate column `cases` into `case_name` and `category`
#        (hint: set `fill` as `right` and look at the `sep` argument).
#      - `replace_na` with `list(category = 'A')` to replace all NAs in
#        `category` to `A`,
#      - `select` to drop column `case_name`.
#
#    To check your answer:
#
#    The output of `print(separate_drop_redundant, n = 5)` is
#
#    ```
#    # A tibble: 1,767 x 8
#      sex   age   degree academic_status experience value category
#      <chr> <chr> <chr>  <chr>           <chr>      <dbl> <chr>
#    1 Men   > 35  Docto. Academic        > 10 years   442 A
#    2 Men   > 35  Docto. Academic        > 10 years   442 B
#    3 Men   > 35  Docto. Academic        > 10 years   442 C
#    4 Women 35 o. Maste. Non-academic    < 2 years    118 A
#    5 Men   35 o. Maste. Non-academic    2-5 years    650 A
#    # . with 1,762 more rows, and 1 more variable: comments <chr>
#    ```
#
## Do not modify this line!

separate_drop_redundant <- t1_longer_rename %>% separate(cases, into = c("case_name", "category"), fill = "right", sep = "_") %>% replace_na(list(category = 'A')) %>% select(-case_name)

# 5. From `separate_drop_redundant`, extract a tibble `filter_na_unite` which
#    does not contain any NAs in `age` and `experience` (i.e., NAs are
#    filtered out). Then unite `age` and `experience` into  a column
#    `age_and_experience` separated by ` && `.
#    To do that, you can use:
#      - `filter` to filter out NAs in `age` and `experience` from
#        `separate_drop_redundant`,
#      - `unite` to unite `age` and `experience` into `age_and_experience`,
#        (hint: look at the `sep` argument).
#
#    To check your answer:
#
#    The output of `print(filter_na_unite, n = 5)` is
#
#    ```
#    # A tibble: 1,662 x 7
#      sex   age_and_experie. degree academic_status value category
#      <chr> <chr>            <chr>  <chr>           <dbl> <chr>
#    1 Men   > 35 && > 10 ye. Docto. Academic          442 A
#    2 Men   > 35 && > 10 ye. Docto. Academic          442 B
#    3 Men   > 35 && > 10 ye. Docto. Academic          442 C
#    4 Women 35 or under && . Maste. Non-academic      118 A
#    5 Men   35 or under && . Maste. Non-academic      650 A
#    # . with 1,657 more rows, and 1 more variable: comments <chr>
#    ```
#
## Do not modify this line!

filter_na_unite <- separate_drop_redundant %>% filter(!is.na(age)&!is.na(experience)) %>% unite(age_and_experience, age, experience, sep = " && ")

# 6. From `filter_na_unite`, extract a tibble `first_100_rank` which
#    contain the 100 datapoints with highest `value`, as well as
#    a column `row_number` that gives the rank of each datapoint
#    (with 1 being the lowest `value` and 100 the highest)
#    To do that, you can use
#      - `mutate` and `row_number` to rank `value`
#         (naming the new column as `row_number`).
#      - `filter` to filter out `row_number` less than or equal to 100.
#
#    To check your answer:
#
#    The output of `print(first_100_rank, n = 5)` is
#
#    ```
#    # A tibble: 100 x 8
#      sex   age_and_experie. degree academic_status value category
#      <chr> <chr>            <chr>  <chr>           <dbl> <chr>
#    1 Men   > 35 && 5-10 ye. Docto. Non-academic       52 C
#    2 Men   > 35 && > 10 ye. Docto. Academic           18 A
#    3 Men   > 35 && > 10 ye. Docto. Academic           18 B
#    4 Men   > 35 && > 10 ye. Docto. Academic           18 C
#    5 Men   > 35 && > 10 ye. Docto. Academic           18 D
#    # . with 95 more rows, and 2 more variables: comments <chr>,
#    #   row_number <int>
#    ```
#
## Do not modify this line!

first_100_rank <- filter_na_unite %>% mutate(row_number = row_number(value)) %>% filter(row_number <= 100)

# 7. From `t1_longer_rename`, extract a tibble `experience_percentage` which
#    contains a `sex` column and 4 additional columns representing the
#    percentage of people per experience level, and 2 rows for
#    `Men` and `Women`.
#    The dataset should be grouped by `sex` with counted numbers
#    of each experience level. Then the counts can be normalized into
#    percentages.
#    Some tidying will make a nice table to show the final numbers.
#    To do that, you can use
#      - `drop_na` to drop NAs on `t1_longer_rename`,
#      - `group_by` using the `sex` variable,
#      - `count` to count the cases per experience level and use
#        the name argument as `count`,
#      - `mutate` to normalize the `count` column into a percentage
#        using `count / sum(count) * 100`,
#      - `pivot_wider` to convert from a long table into a wide table.
#
#    To check your answer:
#
#    The output of `print(experience_percentage, n = 5)` is
#
#    ```
#    # A tibble: 2 x 5
#    # Groups:   sex [2]
#      sex    < 2 years   > 10 years   2-5 years   5-10 years
#      <chr>       <dbl>        <dbl>       <dbl>        <dbl>
#    1 Men          6.90         36.0        25.0         32.1
#    2 Women       17.3          23.0        25.5         34.2
#    ```
## Do not modify this line!

experience_percentage <- t1_longer_rename %>% drop_na() %>% group_by(sex) %>% count(experience, name = "count") %>% mutate(count_per = count / sum(count) * 100) %>% select(-count)%>% pivot_wider(names_from = experience, values_from = count_per)


# HW5: tidyr2
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package and use `read_csv` to load
#    `/course/data/activities.csv` and assign it to a tibble `activities`.
#    In this dataset, each record is an observation (keyed by `id` and `trt`,
#    i.e., treatment group) whose score has been recorded at two times (`T1`
#    and `T2`) for three actions (`work`, `play` and `talk`).
#
#    To check your answer:
#
#    The output of `print(activities, n = 5)` is
#
#    ```
#    # A tibble: 10 x 8
#         id trt   work.T1 play.T1 talk.T1 work.T2 play.T2 talk.T2
#      <dbl> <chr>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#    1     1 cnt     0.652   0.865  0.536   0.275    0.354  0.0319
#    2     2 cnt     0.568   0.615  0.0931  0.229    0.936  0.114
#    3     3 tr      0.114   0.775  0.170   0.0144   0.246  0.469
#    4     4 tr      0.596   0.356  0.900   0.729    0.473  0.397
#    5     5 tr     NA       0.406  0.423   0.250    0.192  0.834
#    # . with 5 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
activities <- read_csv("/course/data/activities.csv")

# 2. Recall the three rules for a tidy dataset. What is the issue here?
#    We have variables stored in multiple columns!
#    From the `activities` tibble, extract a tibble `act_longer` of
#    dimension 60 x 4 that contains the `id`, `trt`, `var` and `score` columns:
#    `var` is a new column that collects the six columns for `work`, `play` and
#    `talk`, while `score` is the corresponding score. The dataset should be
#    sorted by increasing `id` and `trt`.
#    To do this, you can use
#      - `pivot_longer()` to gather the six `work.T1` to `talk.T2`.
#
#    To check your answer:
#
#    The output of `print(act_longer, n = 5)` is
#
#    ```
#    # A tibble: 60 x 4
#         id trt   var     score
#      <dbl> <chr> <chr>   <dbl>
#    1     1 cnt   work.T1 0.652
#    2     1 cnt   play.T1 0.865
#    3     1 cnt   talk.T1 0.536
#    4     1 cnt   work.T2 0.275
#    5     1 cnt   play.T2 0.354
#    # . with 55 more rows
#    ```
#
## Do not modify this line!

act_longer <- activities %>% pivot_longer(cols = work.T1:talk.T2,
                                          names_to = "var",
                                          values_to = "score")

# 3. What is the issue now? Two variables are stored in a single column!
#    From `act_longer`, extract a tibble `act_separated` of dimension 60 x 5
#    that contains the `id`, `trt`, `action`, `time` and `score` columns.
#    `action` and `time` are two new columns that are separated from
#    `act_longer$var`.
#    To do this, you can use `separate()` to separate `var` in `act_longer`.
#
#    To check your answer:
#
#    The output of `print(act_separated, n = 5)` is
#
#    ```
#    # A tibble: 60 x 5
#         id trt   action time  score
#      <dbl> <chr> <chr>  <chr> <dbl>
#    1     1 cnt   work   T1    0.652
#    2     1 cnt   play   T1    0.865
#    3     1 cnt   talk   T1    0.536
#    4     1 cnt   work   T2    0.275
#    5     1 cnt   play   T2    0.354
#    # . with 55 more rows
#    ```
#
## Do not modify this line!

act_separated <- act_longer %>% separate(var, into = c("action", "time"))

# 4. Is this dataset finally tidy? Not quite, we still have observations
#    stored in multiple rows.
#    From `act_separated`, extract a tibble `act_wider` of dimension 20 x 6
#    that contains the `id`, `trt`, `time`, `play`, `talk` and `work` columns.
#    `play`, `talk` and `work` are three new columns that are spread from
#    `act_separated$action`.
#    To do this, you can use `pivot_wider()` to spread `action` in
#    `act_separated` over multiple columns.
#
#    To check your answer:
#
#    The output of `print(act_wider, n = 5)` is
#
#    ```
#    # A tibble: 20 x 6
#         id trt   time   work  play   talk
#      <dbl> <chr> <chr> <dbl> <dbl>  <dbl>
#    1     1 cnt   T1    0.652 0.865 0.536
#    2     1 cnt   T2    0.275 0.354 0.0319
#    3     2 cnt   T1    0.568 0.615 0.0931
#    4     2 cnt   T2    0.229 0.936 0.114
#    5     3 tr    T1    0.114 0.775 0.170
#    # . with 15 more rows
#    ```
#
## Do not modify this line!

act_wider <- act_separated %>% pivot_wider(names_from = action, values_from = score)

# 5. There is one missing value in `act_wider`. Use the function `is.na` and
#    `which()` to locate the column index of the missing value
#    (hint: `arr.ind = TRUE` might be useful). Store the result
#    into a new variable `col_ix`, which should just be an integer.
## Do not modify this line!

col_ix <- which(is.na(act_wider), arr.ind = TRUE)[1,2]

# 6. Use the function `fill()` to backward fill the missing value in
#    `act_wider` (hint: in the `up` direction).
#    Use the `col_ix` you find in question 5.
#    Store the result into a tibble `act_filled`.
#
#    To check your answer:
#
#    The output of `print(sum(act_filled[, col_ix]), digits = 2)` is
#
#    ```
#    [1] 7.2
#    ```
## Do not modify this line!

act_filled <- act_wider %>% fill(col_ix, .direction = "up")
print(sum(act_filled[, col_ix]), digits = 2)

# HW5: tidyr3
#
# Do NOT use a `for`, `while`, or `repeat` loop!
# Whenever using `select()`, make sure to write `dplyr::select()` to avoid
# conflicts with other packages.
#
# 1. Load the `tidyverse` package and use `read_csv` to load
#    `/course/data/warpbreaks.csv` and assign it to a tibble `warpbreaks`.
#
#    To check your answer:
#
#    The output of `print(warpbreaks, n = 5)` is
#
#    ```
#    # A tibble: 70 x 3
#      breaks wool  tension
#       <dbl> <chr> <chr>
#    1     26 A     L
#    2     30 A     L
#    3     NA A     L
#    4     25 A     L
#    5     70 A     L
#    # . with 65 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
warpbreaks <- read_csv("/course/data/warpbreaks.csv")

# 2. Now let's clean the data, we can see a lot of missing values or values
#    which don't make any sense in each of the three columns.
#    Filter out all the `NA` values, as well as the observations such that
#      - `wool` is neither `A` mor `B`,
#      - `tension` is neither `L`, nor `M`, nor `H`,
#    and the rows which has negative or extreme (>100) `breaks` values.
#    Then change the columns order into `wool`, `tension`, `breaks`.
#    To complete this, you can use:
#      - `drop_na` to filter out all the `NA` values,
#      - `filter` to remove the relevant rows,
#      - `select` to change the columns order into `wool`, `tension`, `breaks`.
#    Save your answer into a tibble `t1` which has 49 rows and 3 columns.
#
#    To check your answer:
#
#    The output of `print(t1, n = 5)` is
#
#    ```
#    # A tibble: 49 x 3
#      wool  tension breaks
#      <chr> <chr>    <dbl>
#    1 A     L           26
#    2 A     L           30
#    3 A     L           25
#    4 A     L           70
#    5 A     L           52
#    # . with 44 more rows
#    ```
#
## Do not modify this line!

t1 <- warpbreaks %>% drop_na() %>% filter(wool %in% c("A", "B") & tension %in% c("L","M","H") & breaks < 100 & breaks > 0 ) %>% dplyr::select(wool, tension, breaks)

# 3. Use `count` to count the number of rows for each combination of
#    (`wool`,`tension`) and save the into `t2` which should include 6 rows
#    and 3 columns: `wool`, `tension` and `n`.
#
#    To check your answer:
#
#    The output of `print(t2, n = 5)` is
#
#    ```
#    # A tibble: 6 x 3
#      wool  tension     n
#      <chr> <chr>   <int>
#    1 A     H           8
#    2 A     L           8
#    3 A     M           8
#    4 B     H           9
#    5 B     L           8
#    # . with 1 more row
#    ```
#
## Do not modify this line!

t2 <- t1 %>% count(wool,tension, name = "n")

# 4. Use `pivot_wider` on `t1` to
#      - spread the column `tension` into three columns `L`, `M` and `H`,
#      - fill in the values with the sum of `breaks` for each combination of
#        (`wool`,`tension`).
#    Hint: use the argument `values_fn = list(breaks = sum)`.
#
#    To check your answer:
#
#    The output of `print(t3, n = 1)` is
#
#    ```
#    # A tibble: 2 x 4
#      wool      L     M     H
#      <chr> <dbl> <dbl> <dbl>
#    1 A       347   195   197
#    # . with 1 more row
#    ```
#
## Do not modify this line!

t3 <- t1 %>% pivot_wider(names_from = tension, values_from = breaks, values_fn = list(breaks = sum))

# 5. Use `pivot_longer` on `t3` to create  a tibble `t4` of 6 rows
#    with columns `wool`, `tension` and `sum_of_breaks` by gathering the
#    columns `L`, `M` and `H`.
#
#    To check your answer:
#
#    The output of `print(t4, n = 5)` is
#
#    ```
#    # A tibble: 6 x 3
#      wool  tension sum_of_breaks
#      <chr> <chr>           <dbl>
#    1 A     L                 347
#    2 A     M                 195
#    3 A     H                 197
#    4 B     L                 223
#    5 B     M                 220
#    # . with 1 more row
#    ```
## Do not modify this line!

t4 <- t3 %>% pivot_longer(cols = c(L,M,H),
                          names_to = "tension",
                          values_to = "sum_of_breaks")

