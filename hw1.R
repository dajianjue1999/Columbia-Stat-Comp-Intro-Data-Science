# HW1: warm-up
#
# 1. Create a vector `x` that contain integers between 21 and 29 included.
#
#    To check your answer:
#
#    The output of `print(x[1:3])` is
#
#    ```
#    [1] 21 22 23
#    ```
#
## Do not modify this line!

x <- 21:29
print(x[1:3])

# 2. Copy `x` row-wise into a 3 x 3 matrix `y`.
#
#    To check your answer:
#
#    The output of `print(y[1:2, 1:2])` is
#
#    ```
#         [,1] [,2]
#    [1,]   21   22
#    [2,]   24   25
#    ```
#
## Do not modify this line!

y <- matrix(x, nrow = 3, ncol = 3, byrow = TRUE)
print(y[1:2, 1:2])

# 3. Create the 3 x 3 matrix `z` as the matrix square of `y`.
#    Hint: think about the difference between `^` and `%*%`.
#
#    To check your answer:
#
#    The output of `print(z[1:2, 1:2])` is
#
#    ```
#         [,1] [,2]
#    [1,] 1590 1656
#    [2,] 1806 1881
#    ```
#
## Do not modify this line!

z <- y %*%y
print(z[1:2, 1:2])

# 4. Change the row names of `z` and  the columns of `y` to `c("a", "b", "c")`.
#
#    To check your answer:
#
#    The output of `print(y[1:2, 1:2])` is
#
#    ```
#          a  b
#    [1,] 21 22
#    [2,] 24 25
#    ```
#
#    The output of `print(z[1:2, 1:2])` is
#
#    ```
#      [,1] [,2]
#    a 1590 1656
#    b 1806 1881
#    ```
#
## Do not modify this line!

rownames(z) <- c("a", "b", "c")
colnames(y) <- c("a", "b", "c")
print(y[1:2, 1:2])
print(z[1:2, 1:2])

# 5. Assign the matrix product between the transpose of `z` and the
#    entry-wise square of `y` to a new matrix called `w`.
#    Hint: for the transpose of `z`, look at the function `t`. As for
#    the entry-wise square of `y`, think again
#    about the difference between `^` and `%*%`.
#
#    To check your answer:
#
#    The output of `print(w[1:2, 1:2])` is
#
#    ```
#               a       b
#    [1,] 3215484 3483558
#    [2,] 3349026 3628233
#    ```
## Do not modify this line!

w <- t(z) %*% (y^2)
print(w[1:2, 1:2])

# HW1: warm-up2
#
# 1. Create a vector `v1` containing the integers from -6 to 6.
#
#    To check your answer:
#
#    The output of `print(v1[1:3])` is
#
#    ```
#    [1] -6 -5 -4
#    ```
#
## Do not modify this line!

v1 <- c(-6:6)
print(v1[1:3])

# 2. Copy `v1` into a vector `v2` and add the names `'odd'`` or `'even'` based
#    on whether the corresponding element is odd or even.
#
#    To check your answer:
#
#    The output of `print(v2[1:3])` is
#
#    ```
#    even  odd even
#      -6   -5   -4
#    ```
#
## Do not modify this line!

name <- NA
i = 1
while (i <= length(v1)){
  if((v1[i] %%2 ) == 0){
    name[i] <- "even"
    i = i+1
  }
  else{
    name[i] <- "odd"
    i = i + 1 
  }
}
v2 <- v1
names(v2) <- name
print(v2[1:3])

# 3. Copy `v1` into a vector `v3` and replace all multiples of 3 (i.e.,
#    numbers that can be divided by 3) by a missing value (`NA`).
#    Hint: look at the modulo operator, that is `%%`.
#
#    To check your answer:
#
#    The output of `print(v3[1:3])` is
#
#    ```
#    [1] NA -5 -4
#    ```
#
## Do not modify this line!

v3 <- v1
v3[(v3 %% 3) == 0] <- NA
print(v3[1:3])

# 4. Assign the mean of `v3` to a variable `v4`, ignoring the `NA` when
#    computing the mean.
#    Hint: look at the function `mean` and its `na.rm` argument.
## Do not modify this line!

v4 <- mean(v3, na.rm = TRUE)

# HW1: matrix
#
# 1. Create a 10 x 10 matrix `m1` whose i-th row,j-th column element equals
#    `(i + 1) / (j + 1)`.
#    Hint: look at the `outer` function.
#
#    To check your answer:
#
#    The output of `print(m1[1:2,], digits = 3)` is
#
#    ```
#         [,1]  [,2] [,3] [,4]  [,5]  [,6]  [,7]  [,8] [,9] [,10]
#    [1,]  1.0 0.667 0.50  0.4 0.333 0.286 0.250 0.222  0.2 0.182
#    [2,]  1.5 1.000 0.75  0.6 0.500 0.429 0.375 0.333  0.3 0.273
#    ```
#
## Do not modify this line!

i <- 1:10
j <- 1:10
fun <- function(i, j) {
  z <- (i + 1)/(j+1)
  return(z)
}
m1 <- outer(i, j, fun)
print(m1[1:2,], digits = 3)

# 2. Copy `m1` into a matrix `m2` and replace the non-integer elements of `m2`
#    by 0. By "non-integer", we mean the elements such that the modulo of
#    their division by 1 is different from 0.
#    Hint: look at the `%%` operator.
#
#    To check your answer:
#
#    The output of `print(m2[1:2,], digits = 3)` is
#
#    ```
#         [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#    [1,]    1    0    0    0    0    0    0    0    0     0
#    [2,]    0    1    0    0    0    0    0    0    0     0
#    ```
#
## Do not modify this line!

m2 <- m1
m2[m2 %% 1 != 0] <- 0
print(m2[1:2,], digits = 3)

# 3. Flatten the matrix `m2` row-vise and assign it to a vector of length 100
#    named `v1`.
#    To check your answer, `all(m2[1,] == v1[1:10])` should return `TRUE`.
#
## Do not modify this line!

v1 <- as.vector(t(m2))
all(m2[1,] == v1[1:10])

# 4. Assign the unique values from `v1` sorted in decreasing order into a
#    new vector `v2` of length 6.
#    Hint: look at the `unique` and `sort` functions.
## Do not modify this line!

uniquev = unique(v1)
v2 <- sort(uniquev, decreasing = TRUE)

# HW1: matrix2
#
# 1. Set the random seed as 0 and save the random seed vector into a variable
#    `seed`.
#    Hint: look at the `set.seed` function and use the command
#    `seed <- .Random.seed` to save the seed.
#
#    To check your answer:
#
#    The output of `print(seed[1:3])` is
#
#    ```
#    [1]      10403        624 1280795612
#    ```
#
## Do not modify this line!

set.seed(0)
seed <- .Random.seed
print(seed[1:3])

# 2. Create a vector `v1` of length 30 by sampling from 1 to 30 without
#    replacement.
#    Hint: look at the `sample` or `sample.int` functions.
#
#    To check your answer:
#
#    The output of `print(head(v1))` is
#
#    ```
#    [1] 14 25  4  7  1  2
#    ```
#
## Do not modify this line!

v1 <- sample(1:30, 30,replace = FALSE,set.seed(0))
print(head(v1))

# 3. Convert the vector `v1` into a 5 x 6 matrix `m1` filled by row.
#
#    To check your answer:
#
#    The output of `print(m1[1:2, 1:4])` is
#
#    ```
#         [,1] [,2] [,3] [,4]
#    [1,]   14   25    4    7
#    [2,]   23   11   30   18
#    ```
#
## Do not modify this line!

m1 = matrix(v1, nrow = 5, ncol = 6, byrow = TRUE)
print(m1[1:2, 1:4])

# 4. Calculate the L-1 norm of matrix `m1` defined as the the maximum absolute
#    column sum of the matrix and assign it to `n1`.
#    Hint: look at the `colSum` and `max` functions.
#
## Do not modify this line!

n1 <- max(colSums(m1))

# 5. Calculate the L-infinity norm of matrix `m1` defined as the maximum
#    absolute row sum of the matrix and assign it to `n2`.
#    Hint: look at the `rowSum` and `max` functions.
#
## Do not modify this line!

n2 <- max(rowSums(m1))

# 6. Calculate the Frobenius norm of matrix `m1` defined as the square root of
#    the sum of the squares of its elements and assign it to `n3`.
#    Hint: look at the `sqrt` and `sum` functions.
## Do not modify this line!

n3 <- sqrt(sum(m1^2))

# HW1: factor
#
# 1. Create two factors `f1` and `f2` containing respectively the numbers
#    from 1 to 100 included and from 1 to 20 included.
#
#    To check your answer:
#
#    The output of `print(f1[1:10], max.levels = 5)` is
#
#    ```
#     [1] 1  2  3  4  5  6  7  8  9  10
#    100 Levels: 1 2 3 4 ... 100
#    ```
#
#    The output of `print(f2[1:10], max.levels = 5)` is
#
#    ```
#     [1] 1  2  3  4  5  6  7  8  9  10
#    20 Levels: 1 2 3 4 ... 20
#    ```
#
## Do not modify this line!

f1 <- factor(1:100)
f2 <- factor(1:20)
print(f1[1:10], max.levels = 5)
print(f2[1:10], max.levels = 5)

# 2. Concatenate these two factors into a new factor `f3` of length 120
#    containing the elements of `f1` first and then those of `f2`.
#
#    To check your answer:
#
#    The output of `print(f3[1:10], max.levels = 5)` is
#
#    ```
#     [1] 1  2  3  4  5  6  7  8  9  10
#    100 Levels: 1 2 3 4 ... 100
#    ```
#
## Do not modify this line!

f3 <- c(f1, f2)
print(f3[1:10], max.levels = 5)

# 3. Create a table `t1` giving the number of times each number appear in `f3`.
#    Hint: look at the function `table`.
#
#    To check your answer:
#
#    The output of `print(t1[1:22])` is
#
#    ```
#    f3
#     1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22
#     2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  1  1
#    ```
#
## Do not modify this line!

t1 <- table(f3)
print(t1[1:22])

# 4. Create a factor `f4` corresponding to a "reversed" version of `f1` where
#    both the elements and levels are decreasing.
#    Hint: start by copying `f1` into `f4` and then modify its levevels
#    directly using the `levels` and `rev` functions.
#
#    To check your answer:
#
#    The output of `print(f4[1:10], max.levels = 5)` is
#
#    ```
#     [1] 100 99  98  97  96  95  94  93  92  91
#    100 Levels: 100 99 98 97 ... 1
#    ```
## Do not modify this line!

f4 <- factor(rev(f1), rev(levels(f1)))
print(f4[1:10], max.levels = 5)


#    Hint: same as for part 1. above, but pay attention to the `exclude`
#    argument of the `order` function.
#
#    To check your answer:
#
#    The output of `print(f3[1:10], max.levels = 5)` is
#
#    ```
#     [1] <NA> <NA> <NA> <NA> a    b    c    d    e    f
#    27 Levels: a < b < c < d < ... < <NA>
#    ```
#
## Do not modify this line!

f3 <- ordered(c(rep(NA,4),letters),exclude = "")
print(f3[1:10], max.levels = 5)

# 4. Create and ordered factor `f4` by copying `f1` but deleting the element
#    corresponding to the letter `"c"` and dropping the level `"c"`.
#    Hint: look at the function `droplevels`.
#
#    To check your answer:
#
#    The output of `print(f4[1:10], max.levels = 5)` is
#
#    ```
#     [1] a b d e f g h i j k
#    25 Levels: a < b < d < e < ... < z
#    ```
## Do not modify this line!

f4 <- f1[f1!="c"]
f4 <- droplevels(f4,exclude ="c")
print(f4[1:10], max.levels = 5)

# HW1: list
#
# 1. Create a list `l1` of length 26 consisting of the 26 lowercase letters
#    from `'a'` to `'z'`.
#    Hint: check the variable `letters`.
#
#    To check your answer:
#
#    The output of `str(l1, list.len = 2)` is
#
#    ```
#    List of 26
#     $ : chr "a"
#     $ : chr "b"
#      [list output truncated]
#    ```
#
## Do not modify this line!

l1 = as.list(letters)
str(l1, list.len = 2)

# 2. Create a list `l2` of length 26 consisting of the 26 numbers from 1 to 26.
#
#    To check your answer:
#
#    The output of `str(l2, list.len = 2)` is
#
#    ```
#    List of 26
#     $ : int 1
#     $ : int 2
#      [list output truncated]
#    ```
#
## Do not modify this line!

l2 <- as.list(1:26)
str(l2, list.len = 2)

# 3. Combine `l1` and `l2` into a new list `l3` with 2 elements: the first
#    is `l1` and the second is `l2`.
#
#    To check your answer:
#
#    The output of `str(l3, list.len = 2)` is
#
#    ```
#    List of 2
#     $ :List of 26
#      ..$ : chr "a"
#      ..$ : chr "b"
#      .. [list output truncated]
#     $ :List of 26
#      ..$ : int 1
#      ..$ : int 2
#      .. [list output truncated]
#    ```
#
## Do not modify this line!

l3 <- list(l1,l2)
str(l3, list.len = 2)

# 4. Combine `l1` and `l2` into a new list `l4` with 52 elements:
#    the first 26 elements are the elements of `l1` and the next 26 are the
#    elements of `l2`.
#
#    To check your answer:
#
#    The output of `str(l4, list.len = 2)` is
#
#    ```
#    List of 52
#     $ : chr "a"
#     $ : chr "b"
#      [list output truncated]
#    ```
## Do not modify this line!

l4 <- c(l1,l2)
str(l4, list.len = 2)

# HW1: list2
#
# 1. Create a list `l1` consist of 52 components from `'a'` to `'z'` and
#    `'A'` to `'Z'`.
#    Hint: check the variables `letters` and `LETTERS`.
#
#    To check your answer:
#
#    The output of `str(l1, list.len = 2)` is
#
#    ```
#    List of 52
#     $ : chr "a"
#     $ : chr "b"
#      [list output truncated]
#    ```
#
## Do not modify this line!

l1 <- as.list(c(letters,LETTERS))
str(l1, list.len = 2)

# 2. Convert the list `l1` into an atomic vector `x1` using `unlist()`.
#
#    To check your answer:
#
#    The output of `print(head(x1))` is
#
#    ```
#    [1] "a" "b" "c" "d" "e" "f"
#    ```
#
#    The output of `print(tail(x1))` is
#
#    ```
#    [1] "U" "V" "W" "X" "Y" "Z"
#    ```
#
## Do not modify this line!

x1 <- unlist(l1)
print(head(x1))
print(tail(x1))

# 3. Convert the list `l1` into a 13 x 4 matrix `l2` filling by column
#    by first copying `l1` into `l2` and then setting the `dim` attribute.
#
#    To check your answer:
#
#    The output of `str(l2, list.len = 2)` is
#
#    ```
#    List of 52
#     $ : chr "a"
#     $ : chr "b"
#      [list output truncated]
#     - attr(*, "dim")= int [1:2] 13 4
#    ```
#
#    The output of `print(typeof(l2))` is
#
#    ```
#    [1] "list"
#    ```
#
#    The output of `print(l2[1:3, 1:2])` is
#
#    ```
#         [,1] [,2]
#    [1,] "a"  "n"
#    [2,] "b"  "o"
#    [3,] "c"  "p"
#    ```
#
## Do not modify this line!

l2 <- l1
dim(l2)<- c(13,4)
str(l2, list.len = 2)
print(typeof(l2))
print(l2[1:3, 1:2])

# 4. Convert the vector `x1` into a 13 x 4 matrix `l3` filling by column
#    using `matrix()`.
#
#    To check your answer:
#
#    The output of `str(l3, list.len = 2)` is
#
#    ```
#     chr [1:13, 1:4] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" ...
#    ```
#
#    The output of `print(typeof(l3))` is
#
#    ```
#    [1] "character"
#    ```
#
#    The output of `print(l3[1:3, 1:2])` is
#
#    ```
#         [,1] [,2]
#    [1,] "a"  "n"
#    [2,] "b"  "o"
#    [3,] "c"  "p"
#    ```
## Do not modify this line!

l3 <- matrix(x1, nrow = 13, ncol = 4, byrow = FALSE)
str(l3, list.len = 2)
print(typeof(l3))
print(l3[1:3, 1:2])

# HW1: tibble
#
# 1. Load `mtcars` and transform it into a tibble called `t1`.
#    Hint: by default, `mtcars` is a data frame. You can convert it into a
#    tibble by loading the `tibble` package and using the `as_tibble()`
#    function.
#
#    To check your answer:
#
#    The output of `print(t1, n = 6)` is
#
#    ```
#    # A tibble: 32 x 11
#        mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#    1  21       6   160   110  3.9   2.62  16.5     0     1     4     4
#    2  21       6   160   110  3.9   2.88  17.0     0     1     4     4
#    3  22.8     4   108    93  3.85  2.32  18.6     1     1     4     1
#    4  21.4     6   258   110  3.08  3.22  19.4     1     0     3     1
#    5  18.7     8   360   175  3.15  3.44  17.0     0     0     3     2
#    6  18.1     6   225   105  2.76  3.46  20.2     1     0     3     1
#    # . with 26 more rows
#    ```
#
## Do not modify this line!

library(tibble,mtcars)
t1 <- as_tibble(mtcars)
print(t1, n = 6)

# 2. Create a tibble `t2` which contains all the rows of `t1` such that the
#    miles per gallon (`mpg`) is stricly higher than 22
#
#    To check your answer:
#
#    The output of `print(t2, n = 6)` is
#
#    ```
#    # A tibble: 9 x 11
#        mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#    1  22.8     4 108      93  3.85  2.32  18.6     1     1     4     1
#    2  24.4     4 147.     62  3.69  3.19  20       1     0     4     2
#    3  22.8     4 141.     95  3.92  3.15  22.9     1     0     4     2
#    4  32.4     4  78.7    66  4.08  2.2   19.5     1     1     4     1
#    5  30.4     4  75.7    52  4.93  1.62  18.5     1     1     4     2
#    6  33.9     4  71.1    65  4.22  1.84  19.9     1     1     4     1
#    # . with 3 more rows
#    ```
#
## Do not modify this line!

t2 <- t1[t1$mpg>22,]
print(t2, n = 6)

# 3. Create a tibble `t3` that contains all the values of `t1` rounded after
#    the first decimal.
#
#    To check your answer:
#
#    The output of `print(t3, n = 6)` is
#
#    ```
#    # A tibble: 32 x 11
#        mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#    1  21       6   160   110   3.9   2.6  16.5     0     1     4     4
#    2  21       6   160   110   3.9   2.9  17       0     1     4     4
#    3  22.8     4   108    93   3.9   2.3  18.6     1     1     4     1
#    4  21.4     6   258   110   3.1   3.2  19.4     1     0     3     1
#    5  18.7     8   360   175   3.1   3.4  17       0     0     3     2
#    6  18.1     6   225   105   2.8   3.5  20.2     1     0     3     1
#    # . with 26 more rows
#    ```
#
## Do not modify this line!

t3 <- round(t1,1)
print(t3, n = 6)

# 4. Copy `t1` into a tibble `t4` and add a new column `vsam` corresponding to
#    the sum between its two columns `vs` and `am`.
#
#    To check your answer:
#
#    The output of `print(t4, n = 6)` is
#
#    ```
#    # A tibble: 32 x 12
#        mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb  vsam
#      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#    1  21       6   160   110  3.9   2.62  16.5     0     1     4     4     1
#    2  21       6   160   110  3.9   2.88  17.0     0     1     4     4     1
#    3  22.8     4   108    93  3.85  2.32  18.6     1     1     4     1     2
#    4  21.4     6   258   110  3.08  3.22  19.4     1     0     3     1     1
#    5  18.7     8   360   175  3.15  3.44  17.0     0     0     3     2     0
#    6  18.1     6   225   105  2.76  3.46  20.2     1     0     3     1     1
#    # . with 26 more rows
#    ```
## Do not modify this line!

t4 <- t1
t4$vsam <- t4$vs + t4$am
print(t4, n = 6)

# HW1: tibble2
#
# 1. Load the data frame `airquality` and transform it into a tibble assigned
#    to the variable `t1`.
#    Hint: by default, `airquality` is a data frame. You can convert it into a
#    tibble by loading the `tibble` package and using the `as_tibble()`
#    function.

#    To check your answer:
#
#    The output of `print(t1, n = 6)` is
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
#    6    28      NA  14.9    66     5     6
#    # . with 147 more rows
#    ```
#
## Do not modify this line!

library(graphics)
t1 <- as_tibble(airquality)
print(t1, n = 6)

# 2. Calculate the total number of missing values (i.e., `NA`) for each
#    column in the data frame and assign it into a vector `v1`.
#    Make sure that `v1` has the same names as the column names of `t1`.
#    Hint: combine `is.na` to transform `t1` into a matrix containing
#    `TRUE` if the corresponding element of `t1` is `NA` and `FALSE` otherwise.
#    Then, look at the function `colSum`.
#
#    To check your answer:
#
#    The output of `print(v1[1:3])` is
#
#    ```
#      Ozone Solar.R    Wind
#         37       7       0
#    ```
#
## Do not modify this line!

v1 <- colSums(is.na(t1))
print(v1[1:3]) 

# 3. Create `t2` by copying `t1` and removing all rows  which have `NA` values
#    in any column.
#    Hint: look at the function `na.omit`.
#
#    To check your answer:
#
#    The output of `print(t2, n = 6)` is
#
#    ```
#    # A tibble: 111 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <int>   <int> <dbl> <int> <int> <int>
#    1    41     190   7.4    67     5     1
#    2    36     118   8      72     5     2
#    3    12     149  12.6    74     5     3
#    4    18     313  11.5    62     5     4
#    5    23     299   8.6    65     5     7
#    6    19      99  13.8    59     5     8
#    # . with 105 more rows
#    ```
#
## Do not modify this line!

t2 <- na.omit(t1)
print(t2, n = 6)

# 4. Create `t3` by copying `t1` and sorting the rows according to the
#    (increasing) values of the column `Temp` and then by those of the
#    column `Wind`.
#    Hint: look at the `order` function and notice that the `...` argument
#    can be a sequence of several vectors of the same length.
#    To check your answer:
#
#    The output of `print(t3, n = 6)` is
#
#    ```
#    # A tibble: 153 x 6
#      Ozone Solar.R  Wind  Temp Month   Day
#      <int>   <int> <dbl> <int> <int> <int>
#    1    NA      NA  14.3    56     5     5
#    2    NA      NA   8      57     5    27
#    3    NA      66  16.6    57     5    25
#    4     6      78  18.4    57     5    18
#    5    18      65  13.2    58     5    15
#    6    NA     266  14.9    58     5    26
#    # . with 147 more rows
#    ```
## Do not modify this line!

t3 <- t1[order(t1$Temp,t1$Wind,na.last = TRUE, decreasing = FALSE),]
print(t3, n = 6)

# HW1: distributions
#
# In this exercise, you'll learn how to work with distributions in R.
#




# 0. Read the documentation regarding distributions in R, which you can access
#    using `?Distributions`.
#
# 1. Set the random seed as 0 and save the random seed vector into a variable
#    `seed`.
#    Hint: look at the `set.seed` function and use the command
#    `seed <- .Random.seed` to save the seed.
#
#    To check your answer:
#
#    The output of `print(seed[1:3])` is
#
#    ```
#    [1]      10403        624 1280795612
#    ```
#
## Do not modify this line!

set.seed(0)
seed <- .Random.seed
print(seed[1:3])

# 2. Assign to a variable `prob1` the probability that at least 2 students in the class
#    have the same birthday.
#    Hint: as of the writing of this exercise, there are 42 registered students.
#
#    To check your answer:
#
#    The output of `print(prob1, digits = 3)` is
#
#    ```
#    [1] 0.914
#    ```
#
## Do not modify this line!

prob1 <-pbirthday(42, classes = 365, coincident = 2)

# 3. Let $X$ have a normal distribution with a mean of 0 and a variance of 2.
#    Assign to a variable `prob2` the probability that $X$ is between 0 and 3.
#    Hint: pay attention to the documention of the parameter `sd` in `?Normal`.
#    Furthermore, use the fact that
#    $P(a \leq X \leq b) = P(X <\leq b) - P(X \leq a)$.
#
#    To check your answer:
#
#    The output of `print(prob2, digits = 3)` is
#
#    ```
#    [1] 0.483
#    ```
#
## Do not modify this line!

prob2 <- pnorm(3, mean = 0, sd = sqrt(2))-pnorm(0, mean = 0, sd = sqrt(2))

# 4. Let Y have an exponential distribution with mean equal to 3.
#    Assign to `sample_exp` a sample of 10 random variates drawn from the
#    distribution of Y.
#    Hint: you can look on wikipedia for the relationship between the mean
#    and the parameter `rate` in R's `?Exponential`.
#    ```
#
#    To check your answer:
#
#    The output of `print(sample_exp, digits = 3)` is
#
#    ```
#     [1] 0.552 0.437 0.419 1.308 8.685 3.689 1.619 2.870 0.441 4.172
#    ```
## Do not modify this line!

sample_exp<-rexp(10, rate = 1/3)

# HW1: sample3
#
# Estimate the probability to have 5 'heads' in a row
#
# 1. Set the random seed as 0 and save the random seed vector into a variable
#    `seed`.
#    Hint: look at the `set.seed` function and use the command
#    `seed <- .Random.seed` to save the seed.
#
#    To check your answer:
#
#    The output of `print(seed[1:3])` is
#
#    ```
#    [1]      10403        624 1280795612
#    ```
#
## Do not modify this line!

set.seed(0)
seed <- .Random.seed
print(seed[1:3])

# 2. Use `rbinom` to sample a vector `random_seq` of 5'0000 random numbers
#    equal to 0 ('heads') or 1 ('tails') with probability of 0.5.
#    Hint: if you use `sample`, the test unfortunately won't pass here.
#
#    To check your answer:
#
#    The output of `str(random_seq)` is
#
#    ```
#     int [1:50000] 1 0 0 1 1 0 1 1 1 1 ...
#    ```
#
## Do not modify this line!

random_seq <- rbinom(50000, 1, 0.5)
str(random_seq)

# 3. Reshape `random_seq` into a matrice `random_mat` of shape 5 x 10000.
#    Make sure that the transformation of `random_seq` into a matrix happen
#    column-wise!
#
#    To check your answer:
#
#    The output of `print(random_mat[, 1:4])` is
#
#    ```
#         [,1] [,2] [,3] [,4]
#    [1,]    1    0    0    1
#    [2,]    0    1    0    0
#    [3,]    0    1    0    1
#    [4,]    1    1    1    1
#    [5,]    1    1    0    0
#    ```
#
## Do not modify this line!

random_mat <- matrix(random_seq, c(5,10000),byrow = FALSE)
print(random_mat[, 1:4])

# 4. Sum `random_mat` over its rows to get a vector `random_sum` of length 10'000.
#    Hint : check the functions `rowSums` and `colSums`.
#
#    To check your answer:
#
#    The output of `str(random_sum)` is
#
#    ```
#     num [1:10000] 3 4 1 3 3 1 1 4 4 3 ...
#    ```
#
## Do not modify this line!

random_sum <- colSums(random_mat)
str(random_sum)

# 5. Assign to a variable `prob` the number of elements of `random_sum` equal
#    to 0 and divide it by 10000.
#    You get an estimate of the probability of having 5 heads in a row!
#
#    To check your answer:
#
#    The output of `print(prob, digits = 3)` is
#
#    ```
#    [1] 0.0305
#    ```
## Do not modify this line!

prob <- sum(random_sum == 0)/10000
print(prob, digits = 3)
