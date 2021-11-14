# HW2: choices2
#
# 1. Implement a function `is_prime` that checks if an integer is a prime
#    number or not. `is_prime` should
#      - take one parameter named `num`,
#      - return `TRUE` if `num` is a prime number,
#      - return `FALSE` otherwise.
#    Do not use functions from other package!
#
#    To check your answer:
#
#    The output of `print(sapply(1:10, is_prime))` is
#
#    ```
#     [1] FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE
#    ```
#
## Do not modify this line!

is_prime <- function(num){
  prime = FALSE
  if(num > 1){
    prime = TRUE
    for( i in 2:(num - 1)){
      if(num %% i == 0){
        prime = FALSE
      }
    }
  }
  if(num == 2){
    prime = TRUE
  }
  return(prime)
}

# 2. Use a `for` loop to create an integer vector `x` containing the all prime
#    numbers from 1 to 100. To check your answer, `print(x[1:3])` outputs
#    `[1] 2 3 5`.
#    Hint: use your `is_prime` function inside the `for` loop.
#
#    To check your answer:
#
#    The output of `print(x[1:3])` is
#
#    ```
#    [1] 2 3 5
#    ```
#
## Do not modify this line!

x <- vector()
n = 1
for(i in seq_along(1:100)){
  if(is_prime(i)){
    x[n] = i
    n = n + 1
  }
}

# 3. How many prime numbers are greater than 30 but less than 80?
#    Save the answer into scalar `a`.
#
#    Hint: use `x` along with the `sum` function.
#
## Do not modify this line!

a <- sum(sapply((31:79),is_prime))

# 4. Calculate the sum of the 2nd, 4th, 6th... prime numbers below 100.
#    Save the answer into scalar `b`.
#
#    Hint: use `x` along with the `sum` function and the `%%` operator.
#
## Do not modify this line!

b <- sum(x[seq(2, length(x), 2)])

# HW2: choices3
#
# In this exercise, we will create a function to do unit conversion between
# lbs and kg. The function should have two arguments:
#   - `mass`, a number (or vector of numbers)
#   - `unit`, a string of length one, either `"kg"`, `"lbs"`.
# For the purpose of exercise, 1 lbs = 0.45 kg.
#
# 1. Write a function `f1` with such property using `if`,`else`.
#    For now, do not worry about incorrect unit or mass values.
#
#    To check your answer:
#
#    The output of `print(f1(1:3, "kg"), digits = 2)` is
#
#    ```
#    [1] 2.2 4.4 6.7
#    ```
#
#    The output of `print(f1(1:3, "lbs"), digits = 2)` is
#
#    ```
#    [1] 0.45 0.90 1.35
#    ```
#
## Do not modify this line!

f1 <- function(mass, unit){
  if(unit == "kg"){
    return(mass / 0.45)
  }
  else{
    return(mass * 0.45)
  }
}

# 2. Write a function `f2` that is similar to `f1` but throws the error
#    `"Invalid Unit"` if `unit` is neither `"kg"` nor `"lbs"`.
#
#    Hint: look at the function `stop()`.
#
#    To check your answer:
#
#    The output of `print(f2(1:3, "kg"), digits = 2)` is
#
#    ```
#    [1] 2.2 4.4 6.7
#    ```
#
#    The output of `print(f2(1:3, "lbs"), digits = 2)` is
#
#    ```
#    [1] 0.45 0.90 1.35
#    ```
#
#    The output of `f2(1:3, "abc")` is
#
#    ```
#    Error in f2(1:3, "abc"): Invalid Unit
#    ```
#
## Do not modify this line!

f2 <- function(mass, unit){
  if(unit == "kg"){
    return(mass / 0.45)
  }
  else if(unit == "lbs"){
    return(mass * 0.45)
  }
  else{
    stop("Invalid Unit")
  }
}

# 3. Write a function `f3.` that is similar to `f2` but throws the error
#    `"Negative Mass"` if any of the elements in `mass` is negative.
#    The check for the negative mass should come prior to that for the unit.
#
#    To check your answer:
#
#    The output of `print(f3(1:3, "kg"), digits = 2)` is
#
#    ```
#    [1] 2.2 4.4 6.7
#    ```
#
#    The output of `print(f3(1:3, "lbs"), digits = 2)` is
#
#    ```
#    [1] 0.45 0.90 1.35
#    ```
#
#    The output of `f3(1:3, "abc")` is
#
#    ```
#    Error in f3(1:3, "abc"): Invalid Unit
#    ```
#
#    The output of `f3(-c(1:3), "kg")` is
#
#    ```
#    Error in f3(-c(1:3), "kg"): Negative Mass
#    ```
#
#    The output of `f3(-c(1:3), "abc")` is
#
#    ```
#    Error in f3(-c(1:3), "abc"): Negative Mass
#    ```
## Do not modify this line!

f3 <- function(mass, unit){
  if(any(mass < 0)){
    stop("Negative Mass")
  }
  else if(unit == "kg"){
    return(mass / 0.45)
  }
  else if(unit == "lbs"){
    return(mass * 0.45)
  }
  else{
    stop("Invalid Unit")
  }
}

# HW2: function
#
# 1. Create a function `f` that
#      - takes two positive integers `m` and `n` as input,
#      - outputs a named list including the quotient `q` and the remainder `r`,
#        that is two numbers such that `m = qn + r` if `m` is greater than `n`,
#        or `n = qm +r` if `n` is greater than `m`.
#
#    To check your answer:
#
#    The output of `str(f(3, 2))` is
#
#    ```
#    List of 2
#     $ q: num 1
#     $ r: num 1
#    ```
#
#    The output of `str(f(4, 2))` is
#
#    ```
#    List of 2
#     $ q: num 2
#     $ r: num 0
#    ```
#
#    The output of `str(f(5, 2))` is
#
#    ```
#    List of 2
#     $ q: num 2
#     $ r: num 1
#    ```
#
#    The output of `str(f(3, 3))` is
#
#    ```
#    List of 2
#     $ q: num 1
#     $ r: num 0
#    ```
#
#    The output of `str(f(4, 3))` is
#
#    ```
#    List of 2
#     $ q: num 1
#     $ r: num 1
#    ```
#
#    The output of `str(f(5, 3))` is
#
#    ```
#    List of 2
#     $ q: num 1
#     $ r: num 2
#    ```
#
## Do not modify this line!

f <- function(m, n){
  if(m < 0 | n < 0){
    stop("Need Positive input")
  }
  else if((m%%1)!=0 | (n%%1)!=0){
    stop("Need Integer")
  }
  else if(m > n){
    r <-  m %% n
    q <-  (m - r)/n
  }
  else if(m < n){
    r <- n %% m
    q <- (n - r)/m
  }
  return(as.list(data.frame(q,r)))
}

# 2. Create a function `gcd` that
#      - takes two positive integers `m` and `n` as input,
#      - outputs their greatest common divisor.
#    The function must include a `while` loop!
#    Hint: use Euclid's algorithm.
#
#    To check your answer:
#
#    The output of `print(sapply(seq(1, 16, 2), function(j) gcd(20, j)))` is
#
#    ```
#    [1] 1 1 5 1 1 1 1 5
#    ```
#
#    The output of `print(sapply(seq(1, 16, 2), function(j) gcd(30, j)))` is
#
#    ```
#    [1]  1  3  5  1  3  1  1 15
#    ```
#
## Do not modify this line!

gcd <- function(m, n){
  if(m < 0 | n < 0){
    stop("Need Positive input")
  }
  else if((m%%1)!=0 | (n%%1)!=0){
    stop("Need Integer")
  }
  while(n){
    temp = n
    n = m %% n
    m = temp
  }
  return(m)
}

# 3. Create a function `co_prime` that
#      - takes two positive integers `m` and `n` as input,
#      - outputs whether they are coprime numbers or not, that is
#          - `TRUE` if they are coprime,
#          - `FALSE` if they have common divisors.
#    For example:
#    Hint: use the `gcd` function defined previously.
#
#    To check your answer:
#
#    The output of `print(sapply(1:10, function(j) co_prime(j, 6)))` is
#
#    ```
#     [1]  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE
#    ```
#
#    The output of `print(sapply(1:10, function(j) co_prime(j, 20)))` is
#
#    ```
#     [1]  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE
#    ```
#
## Do not modify this line!

co_prime <- function(m, n){
  if(gcd(m, n)!=1){
    return(FALSE)
  }
  else{
    return(TRUE)
  }
}

# 4. Create a function `lcm` that
#      - takes two positive integers `m` and `n` as input,
#      - outputs their lowest common multiple.
#    Hint: use the `gcd` function defined previously.
#
#    To check your answer:
#
#    The output of `print(sapply(1:5, function(j) lcm(j, 1)))` is
#
#    ```
#    [1] 1 2 3 4 5
#    ```
#
#    The output of `print(sapply(1:5, function(j) lcm(j, 2)))` is
#
#    ```
#    [1]  2  2  6  4 10
#    ```
#
#    The output of `print(sapply(1:5, function(j) lcm(j, 3)))` is
#
#    ```
#    [1]  3  6  3 12 15
#    ```
#
#    The output of `print(sapply(1:5, function(j) lcm(j, 4)))` is
#
#    ```
#    [1]  4  4 12  4 20
#    ```
## Do not modify this line!

lcm <- function(m, n){
  gcd <- gcd(m, n)
  return((m/gcd)*(n/gcd)*gcd)
}

# HW2: function2
#
# 1. Create a function `f1` that
#      - takes an input (numeric) vector `v` and an integer `a`,
#      - and returns `TRUE` if `a` appears in `v` and `FALSE` otherwise.
#    Note that the answer should include a `for` loop.
#
#    To check your answer:
#
#    The output of `print(c(f1(1:10, 1), f1(1:10, 2), f1(1:10, 11)))` is
#
#    ```
#    [1]  TRUE  TRUE FALSE
#    ```
#
## Do not modify this line!

f1 <- function(v, a){
  ans = FALSE
  for(i in seq_along(v)){
    if(a == v[i]){
      ans = TRUE
    }
  }
  return(ans)
}

# 2. Create a function `f2` that
#      - takes an input (numeric) vector `v` and an integer `a`,
#      - and returns how many times `a` appears in `v`
#    Note that:
#      - If `a` does not appear in `v`, `f2` should return `0`.
#      - The answer should include a `for` loop.
#
#    To check your answer:
#
#    The output of `print(sapply(1:4, function(x) f2(c(1, 1, 1, 2, 2, 3), x)))` is
#
#    ```
#    [1] 3 2 1 0
#    ```
#
## Do not modify this line!

f2 <- function(v, a){
  num = 0
  for(i in seq_along(v)){
    if(a == v[i]){
      num = num + 1
    }
  }
  return(num)
}

# 3. Create a function `f3` that
#      - takes an input (numeric) vector `v` and an integer `a`,
#      - and returns where does `a` appear in `v`.
#    Note that:
#      - If `a` does not appear in `v`, `f3` should return `NA`.
#      - The answer should include a `for` loop.
#
#    To check your answer:
#
#    The output of `sapply(1:4, function(x) print(f3(c(3, 3, 3, 2, 2, 1), x)))` is
#
#    ```
#    [1] 6
#    [1] 4 5
#    [1] 1 2 3
#    NULL
#    ```
#
## Do not modify this line!

f3 <- function(v, a){
  index = NULL
  n = 1
  for(i in seq_along(v)){
    if(a == v[i]){
      index[n] = i
      n = n + 1
    }
  }
  if(length(index) == 0){
    return(NULL)
  }
  else{
    return(index)
  }
}

# 4. Create a function `f4` that
#      - takes an input (numeric) vector `v` and an integer `a`,
#      - and returns the `TRUE` if there are two numbers in `v` that
#        sum up to `a`, and `FALSE` otherwise.
#    Note that the answer should include a `for` loop.
#    Hint: let `i = 1`. If there exist a complementary index `j` such that
#    `v[1] + v[j] == a`, then `f1(v[2:n], a - v[1])` must return `TRUE`.
#    If not, then `v[1]` can be excluded, and one can proceed by looking for
#    the complementary of `v[2]` by checking whether `f1(v[3:n], a - v[2])`
#    returns `TRUE`. This idea can be iterated by written `f4` as a loop over
#    `f1(v[(i+1):n], a - v[i])`.
#
#    To check your answer:
#
#    The output of `print(sapply(c(1, 2, 3, 4, 20), function(x) f4(1:10, x)))` is
#
#    ```
#    [1] FALSE FALSE  TRUE  TRUE FALSE
#    ```
## Do not modify this line!

f4 <- function(v, a){
  ans = FALSE
  for(i in 1:(length(v)-1)){
    val = f1(v[(i+1):length(v)], a - v[i])
    if(val == TRUE){
      ans = TRUE
    }
  }
  return(ans)
}

# HW2: function3
#
# 1. Create a function `f1` that
#     - takes an input string `s`
#     - and returns `TRUE` if `s` is an palindrome, otherwise `FALSE`,
#    The answer should include a `for` loop.
#    Hint: use the function `strsplit`.
#
#    To check your answer:
#
#    The output of `print(c(f1(s = "abba"), f1(s = "abcba"), f1(s = "abcd")))` is
#
#    ```
#    [1]  TRUE  TRUE FALSE
#    ```
#
## Do not modify this line!

f1 <- function(s){
  news <- unlist(strsplit(s, ""))
  rev <- ""
  for (i in seq_along(news)){
    rev <- paste(rev,news[length(news)-i+1],sep = "")
  }
  return(rev == s)
}

# 2. Create a function `f2` that
#      - takes two input strings `s1` and `s2`,
#      - and returns `TRUE` if `s1` is a palindrome of `s2`.
#    The answer should include a `for` loop.
#
#    To check your answer:
#
#    The output of `print(f2(s1 = "abcd", s2 = "dcba"))` is
#
#    ```
#    [1] TRUE
#    ```
#
#    The output of `print(f2(s1 = "abcd", s2 = "defg"))` is
#
#    ```
#    [1] FALSE
#    ```
#
## Do not modify this line!

f2 <- function(s1,s2){
  news1 <- unlist(strsplit(s1, ""))
  rev <- ""
  for (i in seq_along(news1)){
    rev <- paste(rev,news1[length(news1)-i+1],sep = "")
  }
  return(rev == s2)
}

# 3. Create a function `f3` that
#    - takes an input string `s`,
#    - and returns a named list with 3 components
#        - `num`: the number of [0, 9] digits in `s`,
#        - `l`: the number of lower-case letters in `s`,
#        - `L`: the number of upper-case letters in `s`.
#    The answer should include a `for` loop.
#
#    To check your answer:
#
#    The output of `str(f3("123"))` is
#
#    ```
#    List of 3
#     $ num: num 3
#     $ l  : num 0
#     $ L  : num 0
#    ```
#
#    The output of `str(f3("123ab"))` is
#
#    ```
#    List of 3
#     $ num: num 3
#     $ l  : num 2
#     $ L  : num 0
#    ```
#
#    The output of `str(f3("123abA"))` is
#
#    ```
#    List of 3
#     $ num: num 3
#     $ l  : num 2
#     $ L  : num 1
#    ```
#
## Do not modify this line!

f3 <- function(s){
  news <- unlist(strsplit(s, ""))
  num = 0
  l <- 0
  L = 0
  for (i in seq_along(news)){
    if (news[i] %in% as.character(0:9)){
      num = num + 1
    }
    else if(news[i]==tolower(news[i])){
      l = l + 1
    }
    else{
      L = L + 1
    }
  }
  return(as.list(data.frame(num, l, L)))
}


# 4. Create a function `f4` that
#      - takes an input string `s`,
#      - changes
#          - all the upper-case letters into lower-case ones,
#          - all the lower-case letters into upper-case ones,
#      - and leave digits untouched.
#    Hint: use the functions `strsplit` and `paste`.
#
#    To check your answer:
#
#    The output of `print(c(f4("123"), f4("123ab"), f4("123AB"), f4("123abCD")))` is
#
#    ```
#    [1] "123"     "123AB"   "123ab"   "123ABcd"
#    ```
## Do not modify this line!

f4 <- function(s){
  news <- unlist(strsplit(s, ""))
  trans = list()
  temp = ""
  for (i in seq_along(news)){
    if (news[i] %in% as.character(0:9)){
      trans[i] = news[i]
    }
    else if(news[i]==tolower(news[i])){
      trans[i]= toupper(news[i])
    }
    else{
      trans[i] = tolower(news[i])
    }
    temp = paste(temp, trans[i], sep = "")
  }
  return(temp) 
}

# HW4: io
#
# In this exercise, we will get familiar with the different types of
# outputs such as `print`, `sprintf`, `message`, etc.
#
# 1. Create a function `my_print(x)` that
#      - takes as argument an object `x`,
#      - prints the object using `print` with 3 significant digits and
#        with the `NA`s replaced by `N/A`.
#    Hint: look-up the arguments `digits` and `na.print`.
#
#    To check your answer:
#
#    The output of `set.seed(0); my_print(runif(3))` is
#
#    ```
#    [1] 0.897 0.266 0.372
#    ```
#
#    The output of `set.seed(0); my_print(c(runif(3), NA))` is
#
#    ```
#    [1] 0.897 0.266 0.372   N/A
#    ```
#
## Do not modify this line!

my_print= function(x){
  print(x, na.print = "N/A",digits = 3)
}

# 2. Create a function `my_format(x)` that
#      - takes as argument an object `x`,
#      - formats the object using `format` with numeric values right-justified
#        valued to a common width and in scientific.
#    Hint: look-up the arguments `trim` and `scientific`.
#
#    To check your answer:
#
#    The output of `set.seed(0); print(my_format(runif(3) * 10^(1:3)))` is
#
#    ```
#    [1] "8.966972e+00" "2.655087e+01" "3.721239e+02"
#    ```
#
#    The output of `print(my_format(1:5 * 10^(1:5)))` is
#
#    ```
#    [1] "1e+01" "2e+02" "3e+03" "4e+04" "5e+05"
#    ```
#
#    The output of `print(my_format(c(1.5, 2:5) * 10^(1:5)))` is
#
#    ```
#    [1] "1.5e+01" "2.0e+02" "3.0e+03" "4.0e+04" "5.0e+05"
#    ```
#
#    The output of `print(my_format(c(1.5, 2.24, 3:5) * 10^(1:5)))` is
#
#    ```
#    [1] "1.50e+01" "2.24e+02" "3.00e+03" "4.00e+04" "5.00e+05"
#    ```
#
## Do not modify this line!

my_format = function(x){
  format(x, trim = FALSE, scientific = TRUE)
}

# 3. Create a function `convert(x)` that
#      - takes as argument an object `x`,
#      - checks that `x` is a character and throws an error using `stopifnot`
#        otherwise,
#      - coerces `x` into a `numeric`,
#      - outputs `"Converted successfully."` as a `message()` if no `NA`s have
#        been introduced by the conversion,
#      - and returns the converted `x` invisibly afterwards.
#
#    To check your answer:
#
#    The output of `convert("1")` is
#
#    ```
#    Converted successfully.
#
#    ```
#
#    The output of `print(convert("1") == 1)` is
#
#    ```
#    Converted successfully.
#    [1] TRUE
#    ```
#
#    The output of `convert(1)` is
#
#    ```
#    Error in convert(1): is.character(x) is not TRUE
#    ```
#
#    The output of `convert("abc")` is
#
#    ```
#    Warning message: In convert("abc") : NAs introduced by coercion
#    ```
#
## Do not modify this line!

convert <- function(x){
  stopifnot(is.character(x))
  if(!is.na(as.numeric(x))){
    x <- as.numeric(x)
    message("Converted successfully.")
    return(invisible(x))
  }
  else{
    as.numeric(x)
  }
}

# 4. Write a function `wake_up(hour, minute, ampm)` that
#      - takes two integers `hour` and `minute`, and a string `ampm`
#        as arguments,
#      - and returns returns a string `"I wake up at <hour>:<minute> <AMPM>."`
#        using `sprintf`.
#    Note: Make sure `<hour>` and `<minute>` have 2 significant digits!
#    You are forbidden to use `paste()` or `format()`.
#
#    To check your answer:
#
#    The output of `print(wake_up(8, 5, "am"))` is
#
#    ```
#    [1] "I wake up at 08:05 am."
#    ```
#
#    The output of `print(wake_up(08, 05, "am"))` is
#
#    ```
#    [1] "I wake up at 08:05 am."
#    ```
## Do not modify this line!

wake_up <- function(hour, minute, ampm){
  sprintf("I wake up at %02d:%02d %s.", hour, minute, ampm)
}


# HW3: map
#
# In the whole exercise, we'll apply `map` variants on the `iris` dataset.
# Do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `purrr` and `tibble` packages.
#    Then, combine the `map` and `summary` functions to get a summary of
#    each variable in the `iris` dataset and assign the result to a list
#    `iris_summary`.
#
#    To check your answer:
#
#    The output of `str(iris_summary)` is
#
#    ```
#    List of 5
#     $ Sepal.Length: 'summaryDefault' Named num [1:6] 4.3 5.1 5.8 5.84 6.4 ...
#      ..- attr(*, "names")= chr [1:6] "Min." "1st Qu." "Median" "Mean" ...
#     $ Sepal.Width : 'summaryDefault' Named num [1:6] 2 2.8 3 3.06 3.3 ...
#      ..- attr(*, "names")= chr [1:6] "Min." "1st Qu." "Median" "Mean" ...
#     $ Petal.Length: 'summaryDefault' Named num [1:6] 1 1.6 4.35 3.76 5.1 ...
#      ..- attr(*, "names")= chr [1:6] "Min." "1st Qu." "Median" "Mean" ...
#     $ Petal.Width : 'summaryDefault' Named num [1:6] 0.1 0.3 1.3 1.2 1.8 ...
#      ..- attr(*, "names")= chr [1:6] "Min." "1st Qu." "Median" "Mean" ...
#     $ Species     : Named int [1:3] 50 50 50
#      ..- attr(*, "names")= chr [1:3] "setosa" "versicolor" "virginica"
#    ```
#
#    The output of `print(iris_summary[[1]])` is
#
#    ```
#       Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#      4.300   5.100   5.800   5.843   6.400   7.900
#    ```
#
## Do not modify this line!

library(purrr)
library(tibble)
iris_summary <- map(iris, summary)

# 2. Using `typeof` and `map_chr`, find the types of each column in `iris` and
#    store the result into a vector `iris_types`.
#
#    To check your answer:
#
#    The output of `print(iris_types[1:3])` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length
#        "double"     "double"     "double"
#    ```
#
## Do not modify this line!

iris_types <-map_chr(iris, typeof)

# 3. Use `keep` and `is.numeric` to extract from `iris` a data frame containing
#    its numeric columns. Convert the result from `data.frame` to `tibble` and
#    save it into `iris_numeric`.
#
#    To check your answer:
#
#    The output of `print(iris_numeric, n = 4)` is
#
#    ```
#    # A tibble: 150 x 4
#      Sepal.Length Sepal.Width Petal.Length Petal.Width
#             <dbl>       <dbl>        <dbl>       <dbl>
#    1          5.1         3.5          1.4         0.2
#    2          4.9         3            1.4         0.2
#    3          4.7         3.2          1.3         0.2
#    4          4.6         3.1          1.5         0.2
#    # . with 146 more rows
#    ```
#
## Do not modify this line!

iris_numeric=as.tibble(keep(iris,is.numeric)) 

# 4. Use `map_dbl` and `var` on `iris_numeric` to compute variances of
#    the numeric columns of `iris` and save the result into a vector
#    named `iris_var`.
#
#    To check your answer:
#
#    The output of `print(iris_var, digits = 3)` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length  Petal.Width
#           0.686        0.190        3.116        0.581
#    ```
#
## Do not modify this line!

iris_var <- map_dbl(iris_numeric, var)

# 5. Use `detect_index` on `iris_var` to find the index of the first column of
#    `iris_numeric` where the variance is larger than three and
#    save the result in an integer vector called `large_var`.
## Do not modify this line!

large_var <- detect_index(iris_var, ~.>3)

# 6. Use `map_dbl` and `mean` on `iris_numeric` to compute trimmed means of
#    the numeric columns of `iris` with the fraction of trimmed observations
#    trimmed equal to `0.01` and save the result into a vector
#    named `iris_trim1`.
#
#    To check your answer:
#
#    The output of `print(iris_trim1, digits = 4)` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length  Petal.Width
#           5.840        3.055        3.755        1.198
#    ```
#
## Do not modify this line!

iris_trim1 <- map_dbl(iris_numeric, mean, trim = 0.01)

# 7. Use `map2_dbl` and `mean` on `iris_numeric` to compute trimmed means of
#    the numeric columns of `iris` with the fraction of trimmed observations
#    trimmed equal to `c(0.01, 0.05, 0.1, 0.2)` and save the result into a
#    vector named `iris_trim2`.
#
#    To check your answer:
#
#    The output of `print(iris_trim2, digits = 4)` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length  Petal.Width
#           5.840        3.050        3.760        1.202
#    ```
#
## Do not modify this line!

iris_trim2 <- map2_dbl(iris_numeric,c(0.01, 0.05, 0.1, 0.2), mean)

# 8. Use `modify_at` and `mean` to replace the values in the columns
#    `Petal.Length` and `Petal.Width` by their respective mean and save
#    the resulting `tibble` as `iris_modif`.
#
#    To check your answer:
#
#    The output of `print(iris_modif, n = 5)` is
#
#    ```
#    # A tibble: 150 x 4
#      Sepal.Length Sepal.Width Petal.Length Petal.Width
#             <dbl>       <dbl>        <dbl>       <dbl>
#    1          5.1         3.5         3.76        1.20
#    2          4.9         3           3.76        1.20
#    3          4.7         3.2         3.76        1.20
#    4          4.6         3.1         3.76        1.20
#    5          5           3.6         3.76        1.20
#    # . with 145 more rows
#    ```
## Do not modify this line!

iris_modif <- modify_at(iris_numeric, c("Petal.Length", "Petal.Width"), mean)

# HW3: reduce
#
# In this exercise, we'll use `reduce` and `accumulate` to create more
# complex functions.
# Do NOT use:
#   - a `for`, `while`, or `repeat` loop,
#   - any of the `map` variants,
#   - any of the `apply` variants.
#
# 1. Load the `purrr` package and use `reduce` to create a function `times`
#    that
#      - takes as argument an integer vector `v`,
#      - outputs the same as `prod(v)`  but without using `prod`.
#    Hint: something similar was done in the slides to mimick the behavior
#    of `sum`.
#
#    To check your answer:
#
#    The output of `print(times(2:4))` is
#
#    ```
#    [1] 24
#    ```
#
#    The output of `set.seed(0); print(times(runif(5)))` is
#
#    ```
#    [1] 0.04609361
#    ```
#
## Do not modify this line!

library(purrr)
times <- function(v){
  reduce(v, `*`)
}

# 2. Use `accumulate` to create a function `cumtimes` that
#      - takes as argument an integer vector `v`,
#      - outputs the same as `rev(cumprod(rev(v)))` but without using `rev` or
#        `cumprod`.
#    Hint: same as before, but pay attention to th `.dir` argument of
#    `accumulate`.
#
#    To check your answer:
#
#    The output of `print(cumtimes(2:4))` is
#
#    ```
#    [1] 24 12  4
#    ```
#
#    The output of `set.seed(0); print(cumtimes(runif(5)))` is
#
#    ```
#    [1] 0.04609361 0.05140377 0.19360486 0.52026989 0.90820779
#    ```
#
## Do not modify this line!

cumtimes <- function(v){
  accumulate(v, `*`, .dir = "backward")
}

# 3. Use `times` to create a function `my_factorial` that
#      - takes as argument an integer `n`,
#      - outputs the factorial of `n`.
#    Do NOT use the `factorial` function from base R or your own `my_factorial`
#    in a recursive call.
#    Hint: use directly the formula of the factorial.
#
#    To check your answer:
#
#    The output of `print(c(my_factorial(2), my_factorial(3), my_factorial(4)))` is
#
#    ```
#    [1]  2  6 24
#    ```
#
## Do not modify this line!

my_factorial <- function(n){
  if(n == 0){
    a = as.integer(1)
    return(a)
  }
  else{
    times(1:n)
  }
}

# 4. Use `reduce` to create a function `union_list` that
#      - takes as argument a list `l` (you can assume that all the components
#        of `l` are integer vectors, but potentially of different lengths),
#      - outputs the `union` of the vectors in `l` (i.e., the vector composed
#        of the unique values of the vectors in `l`).
#    Do NOT use the `flatten`, `unlist` or `unique` functions.
#
#    To check your answer:
#
#    The output of `print(union_list(list(1:3, 1:3, 4:6)))` is
#
#    ```
#    [1] 1 2 3 4 5 6
#    ```
#
#    The output of `print(union_list(list(1:3, 4:6, 7:9)))` is
#
#    ```
#    [1] 1 2 3 4 5 6 7 8 9
#    ```
#
## Do not modify this line!

union_list <- function(l){
  reduce(l, union)
}

# 5. Use `accumulate` to create a function `cumpaste0` that
#      - takes as arguments
#          - a character vector `x`,
#          - a single character `sep` taking the default value `"-"`,
#      - outputs an accumulated version of `paste0` as exemplified below.
#
#    To check your answer:
#
#    The output of `print(cumpaste0(letters[1:3]))` is
#
#    ```
#    [1] "a"     "a-b"   "a-b-c"
#    ```
#
#    The output of `print(cumpaste0(letters[1:3], sep = "..."))` is
#
#    ```
#    [1] "a"         "a...b"     "a...b...c"
#    ```
## Do not modify this line!

cumpaste0 <- function(x, sep = "-"){
  accumulate(x, sep = sep, paste)
}

# HW3: error handling
#
# In this exercise, we will focus on functions allowing to handle errors.
# We'll follow something similar to the slides 52-56 of lecture 3.
# Do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `purrr` package, and combine `keep` and `is.numeric` to extract
#    from `iris` a data frame containing its numeric columns and assign it
#    to `iris_numeric`.
#    Then, use `map_dbl` twice to assign respectively to `m1a` and `m2a`
#    vectors containing the per-columns `max` and `mean` of `iris_numeric`.
#
#    To check your answer:
#
#    The output of `print(head(iris_numeric))` is
#
#    ```
#      Sepal.Length Sepal.Width Petal.Length Petal.Width
#    1          5.1         3.5          1.4         0.2
#    2          4.9         3.0          1.4         0.2
#    3          4.7         3.2          1.3         0.2
#    4          4.6         3.1          1.5         0.2
#    5          5.0         3.6          1.4         0.2
#    6          5.4         3.9          1.7         0.4
#    ```
#
#    The output of `print(m1a, digits = 1)` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length  Petal.Width
#               8            4            7            2
#    ```
#
#    The output of `print(m2a, digits = 1)` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length  Petal.Width
#               6            3            4            1
#    ```
#
## Do not modify this line!

library(purrr)
iris_numeric<- keep(iris, is.numeric)
m1a <- map_dbl(iris_numeric, max)
m2a <- map_dbl(iris_numeric, mean)

# 2. Next, let's proceed as if we didn't know the columns for which we
#    can't compute the max and/or mean:
#      - Use `map` and `safely` to calculate the maximum of each column, but
#        including the invalid columns as well, and assign the result to `y1`.
#      - Use `map` and `quietly` to calculate the mean of each column, but
#        including the invalid columns as well, and assign the result to `y2`.
#    Hint: see slide 53 of lecture 3.
#
#    To check your answer:
#
#    The output of `str(y1, nchar.max = 30)` is
#
#    ```
#    List of 5
#     $ Sepal.Length:List of 2
#      ..$ result: num 7.9
#      ..$ error : NULL
#     $ Sepal.Width :List of 2
#      ..$ result: num 4.4
#      ..$ error : NULL
#     $ Petal.Length:List of 2
#      ..$ result: num 6.9
#      ..$ error : NULL
#     $ Petal.Width :List of 2
#      ..$ result: num 2.5
#      ..$ error : NULL
#     $ Species     :List of 2
#      ..$ result: NULL
#      ..$ error :List of 2
#      .. ..$ message: chr "'max' not mea"| __truncated__
#      .. ..$ call   : language Summary.factor(| __truncated__ ...
#      .. ..- attr(*, "class")= chr [1:3] "simpleError" "error" "condition"
#    ```
#
#    The output of `str(y2, nchar.max = 30)` is
#
#    ```
#    List of 5
#     $ Sepal.Length:List of 4
#      ..$ result  : num 5.84
#      ..$ output  : chr ""
#      ..$ warnings: chr(0)
#      ..$ messages: chr(0)
#     $ Sepal.Width :List of 4
#      ..$ result  : num 3.06
#      ..$ output  : chr ""
#      ..$ warnings: chr(0)
#      ..$ messages: chr(0)
#     $ Petal.Length:List of 4
#      ..$ result  : num 3.76
#      ..$ output  : chr ""
#      ..$ warnings: chr(0)
#      ..$ messages: chr(0)
#     $ Petal.Width :List of 4
#      ..$ result  : num 1.2
#      ..$ output  : chr ""
#      ..$ warnings: chr(0)
#      ..$ messages: chr(0)
#     $ Species     :List of 4
#      ..$ result  : num NA
#      ..$ output  : chr ""
#      ..$ warnings: chr "argument is n"| __truncated__
#      ..$ messages: chr(0)
#    ```
#
## Do not modify this line!

y1 <- map(iris, safely(max))
y2 <- map(iris, quietly(mean))

# 3. Then, let's use `transpose()` on both `y1` and `y2` to extract
#      - `error` from the former and assign it to `error_log`,
#      - `warning` from the later and assign it to `warning_log`.
#    Hint: see slides 54-55 of lecture 3.
#
#    To check your answer:
#
#    The output of `str(error_log, nchar.max = 30)` is
#
#    ```
#    List of 5
#     $ Sepal.Length: NULL
#     $ Sepal.Width : NULL
#     $ Petal.Length: NULL
#     $ Petal.Width : NULL
#     $ Species     :List of 2
#      ..$ message: chr "'max' not mea"| __truncated__
#      ..$ call   : language Summary.factor(| __truncated__ ...
#      ..- attr(*, "class")= chr [1:3] "simpleError" "error" "condition"
#    ```
#
#    The output of `str(warning_log, nchar.max = 30)` is
#
#    ```
#    List of 5
#     $ Sepal.Length: chr(0)
#     $ Sepal.Width : chr(0)
#     $ Petal.Length: chr(0)
#     $ Petal.Width : chr(0)
#     $ Species     : chr "argument is n"| __truncated__
#    ```
#
## Do not modify this line!

error_log <- transpose(y1)$error
warning_log <- transpose(y2)$warning

# 4. Now, use `map_lgl` and `is_empty` on `error_log` to extract a logical
#    vector indicating which columns were processed without problem, and
#    assign the result to `is_ok1`.
#    Proceed similarly with `warning_log` and assign the result to `is_ok2`.
#
#    To check your answer:
#
#    The output of `str(is_ok1, vec.len = 2)` is
#
#    ```
#     Named logi [1:5] TRUE TRUE TRUE ...
#     - attr(*, "names")= chr [1:5] "Sepal.Length" "Sepal.Width" ...
#    ```
#
#    The output of `str(is_ok2, vec.len = 2)` is
#
#    ```
#     Named logi [1:5] TRUE TRUE TRUE ...
#     - attr(*, "names")= chr [1:5] "Sepal.Length" "Sepal.Width" ...
#    ```
#
## Do not modify this line!

is_ok1 <- map_lgl(error_log, is_empty)
is_ok2 <- map_lgl(warning_log, is_empty)

# 5. The next step is to use those logical vectors to extract your
#    computations. Use `transpose` on `y1` again along with
#    `is_ok1` to extract the results that could be processessed,
#    and flatten the resulting list into a simple vector using `flatten_dbl`.
#    Assign the result to `m1b`.
#    Proceed similarly with `y2` and `is_ok2` and assign the result to `m2b`.
#    Hint: see slide 55 of lecture 3.
#
#    To check your answer:
#
#    The output of `print(m1b, digits = 1)` is
#
#    ```
#    [1] 8 4 7 2
#    ```
#
#    The output of `print(m2b, digits = 1)` is
#
#    ```
#    [1] 6 3 4 1
#    ```
#
## Do not modify this line!

m1b <- flatten_dbl(transpose(y1)$result[is_ok1])
m2b <- flatten_dbl(transpose(y2)$result[is_ok2])

# 6. Note that a similar result could have been obtained using `possibly`.
#    Combine `map_dbl` and `possibly` to assign to `m1c` a vector
#    containing:
#      - the per-column `max` of `iris` if the maximum can be computer,
#      - an `NA` otherwise.
#    Hint: look-up the `otherwise` argument of `possibly`.
#
#    To check your answer:
#
#    The output of `print(m1c, digits = 1)` is
#
#    ```
#    Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species
#               8            4            7            2           NA
#    ```
## Do not modify this line!

m1c <- map_dbl(iris, possibly(max, otherwise = NA))
print(m1c, digits = 1)
