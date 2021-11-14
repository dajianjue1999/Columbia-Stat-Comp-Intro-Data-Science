# HW7: dates1
#
# We'll look at a sample from
# [Citibike usage data](https://www.citibikenyc.com/system-data),
# corresponding to every bike trip taken by users in August 2016.
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse` and `lubridates` packages.
#    Then, use `read_csv` to load `/course/data/citybike.csv` and assign it
#    to a tibble `trips`.
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
#    # . with 1e+05 more rows, and 10 more variables:  start station
#    #   latitude  <dbl>,  start station longitude  <dbl>,  end station
#    #   id  <dbl>,  end station name  <chr>,  end station
#    #   latitude  <dbl>,  end station longitude  <dbl>, bikeid <dbl>,
#    #   usertype <chr>,  birth year  <dbl>, gender <dbl>
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
trips <- read_csv("/course/data/citybike.csv")
print(trips, n = 5)

# 2. From `trips`, extract a tibble `trips_with_genders` that has the
#    `gender` column first and the other columns in the original order,
#    and with the `gender` column transformedas a factor with levels
#    `"Unknown"` for 0, `"Male"` for 1, and `"Female"` for 2.
#    Hint: you can use `mutate()` and `factor()`, and judiciously use the
#    `levels` argument of `factor()`. Then, you can reorder the columns using
#    `select()` and `everything()`.
#
#    To check your answer:
#
#    The output of `print(trips_with_genders, n = 5)` is
#
#    ```
#    # A tibble: 100,000 x 15
#      gender tripduration starttime stoptime  start station .
#      <fct>         <dbl> <chr>     <chr>               <dbl>
#    1 Male           5945 8/5/2016. 8/5/201.              228
#    2 Male           1494 8/3/2016. 8/3/201.              460
#    3 Male            826 8/30/201. 8/30/20.             3301
#    4 Female          278 8/15/201. 8/15/20.             3256
#    5 Female          729 8/8/2016. 8/8/201.              347
#    # . with 1e+05 more rows, and 10 more variables:  start station
#    #   name  <chr>,  start station latitude  <dbl>,  start station
#    #   longitude  <dbl>,  end station id  <dbl>,  end station
#    #   name  <chr>,  end station latitude  <dbl>,  end station
#    #   longitude  <dbl>, bikeid <dbl>, usertype <chr>,  birth
#    #   year  <dbl>
#    ```
#
#    The output of `print(trips_with_genders$gender[1:2])` is
#
#    ```
#    [1] Male Male
#    Levels: Unknown Male Female
#    ```
#
## Do not modify this line!

level <-  c("Unknown", "Male", "Female")
trips_with_genders <- trips %>% mutate(gender = factor(gender, levels = level)) %>%select(gender, everything())
print(trips_with_genders, n = 5)

# 3. From `trips`, extract a tibble `trips_with_dates` by
#      - modifying the `starttime` and `stoptime` columns to
#        contain dates in the format month-day-year_hour-minute-second,
#      - adding a column `interval` to representing the time interval
#        between `starttime` and `stoptime`,
#      - changing the order to have the `starttime`, `stoptime`, and `interval`
#        columns first, and then the others in the original order.
#    Hint: you can use `mutate()` and `mdy_hms()`, and then `select()` and
#    `everything()`.
#
#    To check your answer:
#
#    The output of `print(trips_with_dates, n = 5)` is
#
#    ```
#    # A tibble: 100,000 x 16
#      starttime           stoptime
#      <dttm>              <dttm>
#    1 2016-08-05 14:15:11 2016-08-05 15:54:16
#    2 2016-08-03 22:56:34 2016-08-03 23:21:28
#    3 2016-08-30 07:41:07 2016-08-30 07:54:54
#    4 2016-08-15 20:39:47 2016-08-15 20:44:26
#    5 2016-08-08 17:40:31 2016-08-08 17:52:40
#    # . with 1e+05 more rows, and 14 more variables: interval <Interval>,
#    #   tripduration <dbl>,  start station id  <dbl>,  start station
#    #   name  <chr>,  start station latitude  <dbl>,  start station
#    #   longitude  <dbl>,  end station id  <dbl>,  end station
#    #   name  <chr>,  end station latitude  <dbl>,  end station
#    #   longitude  <dbl>, bikeid <dbl>, usertype <chr>,  birth
#    #   year  <dbl>, gender <dbl>
#    ```
#
#    The output of `print(trips_with_dates$interval[1:3])` is
#
#    ```
#    [1] 2016-08-05 14:15:11 UTC--2016-08-05 15:54:16 UTC
#    [2] 2016-08-03 22:56:34 UTC--2016-08-03 23:21:28 UTC
#    [3] 2016-08-30 07:41:07 UTC--2016-08-30 07:54:54 UTC
#    ```
#
## Do not modify this line!

trips_with_dates <- trips %>%
  mutate(starttime = mdy_hms(starttime),
         stoptime = mdy_hms(stoptime))%>%
  mutate(interval = (starttime %--% stoptime))%>%
  select(starttime, stoptime, interval, everything())
print(trips_with_dates, n = 5)
print(trips_with_dates$interval[1:3])

# 4. From `trips_with_dates`, extract a tibble `trips_start_times` by
#      - selecting only the `starttime` column,
#      - adding two columns `start_ymd` and `start_hour` containing
#        the date and hour of day of the starting time for each trip
#        (you can use `mutate()` along with `floor_date()` and `hour()`)
#
#    To check your answer:
#
#    The output of `print(trips_start_times, n = 5)` is
#
#    ```
#    # A tibble: 100,000 x 3
#      starttime           start_ymd           start_hour
#      <dttm>              <dttm>                   <int>
#    1 2016-08-05 14:15:11 2016-08-05 00:00:00         14
#    2 2016-08-03 22:56:34 2016-08-03 00:00:00         22
#    3 2016-08-30 07:41:07 2016-08-30 00:00:00          7
#    4 2016-08-15 20:39:47 2016-08-15 00:00:00         20
#    5 2016-08-08 17:40:31 2016-08-08 00:00:00         17
#    # . with 1e+05 more rows
#    ```
#
## Do not modify this line!

trips_start_times <- trips_with_dates %>% select(starttime)%>%mutate(start_ymd = floor_date(starttime, "day"), start_hour = hour(starttime))
print(trips_start_times, n = 5)

# 5. From `trips_start_times`, extract a tibble `trips_per_hour` by
#    computing, for each hour of the day,
#      - `num_trips`, the total number of trips,
#      - `num_days`, the number of days in which there was at least one trip,
#      - `mean_trips`, the ratio between the previous two.
#    Hint:  you can use `group_by()`, `summarize()`, as well as `n()` and
#    `n_distinct()`.
#
#    To check your answer:
#
#    The output of `print(trips_per_hour, n = 5)` is
#
#    ```
#    # A tibble: 24 x 4
#      start_hour num_trips num_days mean_trips
#           <int>     <int>    <int>      <dbl>
#    1          0       986       31      31.8
#    2          1       506       31      16.3
#    3          2       322       31      10.4
#    4          3       193       30       6.43
#    5          4       195       31       6.29
#    # . with 19 more rows
#    ```
## Do not modify this line!

trips_per_hour <- trips_start_times %>% group_by(start_hour)%>%
  summarize(num_trips = n(), num_days = n_distinct(start_ymd), mean_trips = num_trips/num_days)
print(trips_per_hour, n = 5)


# HW7: email
#
# In this exercise, you will perform an analysis of email data between
# 184 people in a company from 1998 to 2001.
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse` and `lubridates` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_csv` to load
#      - `/course/data/people.csv` and assign it to a tibble `people`, which contains
#        information about the 184 people who sent the emails,
#      - `/course/data/email.csv` and assign it to a tibble `email`, which contains
#        information about each email sent (e.g., time, sender and receiver).
#
#    To check your answer:
#
#    The output of `print(email, n = 5)` is
#
#    ```
#    # A tibble: 38,131 x 8
#       onset terminus  tail  head onset.censored terminus.censor. duration
#       <dbl>    <dbl> <dbl> <dbl> <lgl>          <lgl>               <dbl>
#    1 9.58e8   9.58e8    30    30 FALSE          FALSE                   0
#    2 9.59e8   9.59e8    30    30 FALSE          FALSE                   0
#    3 9.59e8   9.59e8    30    30 FALSE          FALSE                   0
#    4 9.64e8   9.64e8    30    30 FALSE          FALSE                   0
#    5 9.70e8   9.70e8    30    30 FALSE          FALSE                   0
#    # . with 3.813e+04 more rows, and 1 more variable: edge.id <dbl>
#    ```
#
#    The output of `print(people, n = 10)` is
#
#    ```
#    # A tibble: 184 x 5
#       vertex.names email_id      person_name    role        dept
#              <dbl> <chr>         <chr>          <chr>       <chr>
#     1            1 albert.meyers Albert Meyers  Employee    Specialist
#     2            2 a..martin     Thomas Martin  Vice Presi. <NA>
#     3            3 andrea.ring   Andrea Ring    <NA>        <NA>
#     4            4 andrew.lewis  Andrew Lewis   Director    <NA>
#     5            5 andy.zipper   Andy Zipper    Vice Presi. Enron Online
#     6            6 a..shankman   Jeffrey Shank. President   Enron Global.
#     7            7 barry.tychol. Barry Tycholiz Vice Presi. <NA>
#     8            8 benjamin.rog. Benjamin Roge. Employee    Associate
#     9            9 bill.rapp     Bill Rapp      <NA>        <NA>
#    10           10 bill.williams <NA>           <NA>        <NA>
#    # . with 174 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
theme_set(theme_light())
people <- read_csv("/course/data/people.csv")
email <- read_csv("/course/data/email.csv")
print(email, n = 5)
print(people, n = 10)

# 2. From `email`, extract a tibble `email_w_time` which adds as FIRST column
#    a new column called `date` corresponding to the time when the email is
#    sent. Note that, in `email`, the `onset` variable represents a number of
#    seconds since January 1st, 1970 UTC.
#    Hint: you can use `mutate()`, `as_datetime()`, `select()` and
#    `everything()`.
#
#    To check your answer:
#
#    The output of `print(email_w_time, n = 5)` is
#
#    ```
#    # A tibble: 38,131 x 9
#      date                 onset terminus  tail  head onset.censored
#      <dttm>               <dbl>    <dbl> <dbl> <dbl> <lgl>
#    1 2000-05-15 12:35:00 9.58e8   9.58e8    30    30 FALSE
#    2 2000-05-18 08:15:00 9.59e8   9.59e8    30    30 FALSE
#    3 2000-05-24 06:58:00 9.59e8   9.59e8    30    30 FALSE
#    4 2000-07-19 11:09:00 9.64e8   9.64e8    30    30 FALSE
#    5 2000-09-28 06:45:00 9.70e8   9.70e8    30    30 FALSE
#    # . with 3.813e+04 more rows, and 3 more variables:
#    #   terminus.censored <lgl>, duration <dbl>, edge.id <dbl>
#    ```
#
## Do not modify this line!

email_w_time <- email %>% mutate(date = as_datetime(onset))%>%
  select(date, everything())
print(email_w_time, n = 5)

# 3. Now let's take a look into the `people` dataset.
#    We can see some missing values in `person_name` column, but we can get a
#    person's name using his/her `email_id`.
#    For example, Albert Meyers's email ID is just `"albert.meyers"`.
#    To fill in missing values with email ID, let's first create a function
#    `email_id_to_name` that:
#      - take a character vector `email_id` as input,
#      - returns the name extracted from the email id.
#    To do that, you can use:
#      - `str_replace_all()` to replace the dots by spaces,
#      - `str_squish()` to remove the extra spaces,
#      - `str_to_title()` to capitalize the first and last names.
#
#    To check your answer:
#
#    The output of `print(email_id_to_name('john.doe'))` is
#
#    ```
#    [1] "John Doe"
#    ```
#
#    The output of `print(email_id_to_name('john...doe'))` is
#
#    ```
#    [1] "John Doe"
#    ```
#
#    The output of `print(email_id_to_name(c('john.doe', 'jane.doe')))` is
#
#    ```
#    [1] "John Doe" "Jane Doe"
#    ```
#
## Do not modify this line!

email_id_to_name <- function(email_id){
  email_id <-str_replace_all(email_id, "[.]", " ")
  email_id <-str_squish(email_id)
  str_to_title(email_id)
}
print(email_id_to_name('john.doe'))
print(email_id_to_name('john...doe'))
print(email_id_to_name(c('john.doe', 'jane.doe')))

# 4. From `people`, extract a tibble `people_new` that adds the missing names
#    using the function you just created.
#    To do that, you can use `mutate()`, `ifelse()`, and `is.na()`. If the name
#    is missing, extract it from `email_id` using `email_id_to_name`. If the
#    name is not missing, do not modify it.
#
#    To check your answer:
#
#    The output of `print(people_new, n = 10)` is
#
#    ```
#    # A tibble: 184 x 5
#       vertex.names email_id      person_name    role        dept
#              <dbl> <chr>         <chr>          <chr>       <chr>
#     1            1 albert.meyers Albert Meyers  Employee    Specialist
#     2            2 a..martin     Thomas Martin  Vice Presi. <NA>
#     3            3 andrea.ring   Andrea Ring    <NA>        <NA>
#     4            4 andrew.lewis  Andrew Lewis   Director    <NA>
#     5            5 andy.zipper   Andy Zipper    Vice Presi. Enron Online
#     6            6 a..shankman   Jeffrey Shank. President   Enron Global.
#     7            7 barry.tychol. Barry Tycholiz Vice Presi. <NA>
#     8            8 benjamin.rog. Benjamin Roge. Employee    Associate
#     9            9 bill.rapp     Bill Rapp      <NA>        <NA>
#    10           10 bill.williams Bill Williams  <NA>        <NA>
#    # . with 174 more rows
#
## Do not modify this line!

people_new <- people %>% mutate(person_name = ifelse(is.na(person_name) , email_id_to_name(email_id), person_name))
print(people_new, n = 10)

# 5. From `people_new`, extract a tibble `people_new2` that fills the `NA`
#    values in `role` and `dept`, as well as transform `role` into a factor...
#    Let's fill in the missing values:
#      - in `role` with `"Employee"`,
#      - and in `dept` with `General`.
#    Furthermore, let's transform `role` into a factor using levels sorted
#    according the the following hierarchy:
#
#    ```
#    role_order <- c("Employee", "Trader", "Manager", "Managing Director",
#       "Director", "In House Lawyer", "Vice President", "President", "CEO")
#    ```
#
#    To do that, you can use:
#      - `replace_na()` to fill in the missing values,
#      - `mutate()` to transform `role` into a factor with `factor()` with
#        levels properly specified.
#
#    # A tibble: 184 x 5
#    vertex.names email_id        person_name      role           dept
#    <dbl>        <chr>           <chr>            <fct>          <chr>
#    1             albert.meyers   Albert Meyers    Employee       Specialist
#    2             a..martin       Thomas Martin    Vice President General
#    3             andrea.ring     Andrea Ring      Employee       General
#    4             andrew.lewis    Andrew Lewis     Director       General
#    5             andy.zipper     Andy Zipper      Vice President Enron Online
#    6             a..shankman     Jeffrey Shankman President      Enron Global Mkts
#    7             barry.tycholiz  Barry Tycholiz   Vice President General
#    8             benjamin.rogers Benjamin Rogers  Employee       Associate
#    9             bill.rapp       Bill Rapp        Employee       General
#    10            bill.williams   Bill Williams    Employee       General
#    . with 174 more rows
#
## Do not modify this line!

people_new2 <- people_new %>% replace_na(list(role = "Employee", dept = "General"))%>% 
  mutate(role = factor(role, role_order <- c("Employee", "Trader", "Manager", "Managing Director",
                                             "Director", "In House Lawyer", "Vice President", "President", "CEO")))

# 6. Let's combine the two datasets `email_w_time` and `people_new2` together
#    into a new tibble `email_w_names`.
#    Here, we want to keep the information about every email and add the name,
#    email ID, role and department for the sender as well as for the receiver:
#      - in `people_new2`, the `vertex.names` column is a primary key
#        identifying each person,
#      - in `email_w_time`, the `tail` and `head` columns are foreign keys
#        corresponding to `vertex.name` and representing
#        respectively the receiver and sender of the email.
#    In other words, you need to use two `left_join()` to
#    add first the information of the receiver and then again to add
#    that of the sender. You will also need to update the names of the columns
#    added by the joins.
#    Finally, only keep the emails where the sender is different from the
#    receiver, and keep only the information about the date, sender
#    and receiver (4 columns each, with email ID, name, role and department).
#    To do that, you can use:
#      - `left_join()` and `rename()` twice to add the information about
#        the receiver and sender (change `email_id` to `receiver_email`,
#        `person_name` to `receiver_name`, `role` to `receiver_role`,
#        `dept` to `receiver_dept`, and similarly with `sender_xyz`),
#       - `select()` and `starts_with()` to only keep the `date`, as well
#         as the sender and receiver information.
#
#    To check your answer:
#
#    The output of `print(email_w_names, n = 5)` is
#
#    ```
#    # A tibble: 34,427 x 9
#      date                sender_email sender_name sender_role sender_dept
#      <dttm>              <chr>        <chr>       <fct>       <chr>
#    1 2001-03-15 07:43:00 jeffrey.sha. Jeffrey Sh. President   Enron Glob.
#    2 2001-04-02 17:44:00 jeffrey.sha. Jeffrey Sh. President   Enron Glob.
#    3 2001-06-06 02:40:00 jeffrey.sha. Jeffrey Sh. President   Enron Glob.
#    4 2001-06-11 09:20:00 jeffrey.sha. Jeffrey Sh. President   Enron Glob.
#    5 2001-03-08 07:52:00 kim.ward     Kim Ward    Employee    General
#    # . with 3.442e+04 more rows, and 4 more variables:
#    #   receiver_email <chr>, receiver <chr>, receiver_role <fct>,
#    #   receiver_dept <chr>
#    ```
#
## Do not modify this line!

email_w_names <- email_w_time %>% left_join(people_new2,by = c("tail" = "vertex.names"))%>%
  left_join(people_new2,by = c("head"="vertex.names"))%>%
  rename(receiver_email = email_id.x, receiver = person_name.x, receiver_role = role.x,
         receiver_dept = dept.x, sender_email = email_id.y, sender_name = person_name.y,
         sender_role = role.y, sender_dept = dept.y) %>% filter(receiver_email!=sender_email) %>%
  select(date, starts_with(c("sender", "receiver")))
print(email_w_names, n = 5)

# 7. From `email_w_names`, extract a tibble `sender_role_count` that
#    contains the number of emails sent by each role, sorted in descending
#    order.
#    Hint: to do that, you can use `group_by()`, `summarize()` and `arrange()`.
#
#    To check your answer:
#
#    The output of `print(sender_role_count, n = 5)` is
#
#    ```
#    # A tibble: 9 x 2
#      sender_role    count
#      <fct>          <int>
#    1 Employee       16394
#    2 Vice President  8300
#    3 President       1879
#    4 CEO             1703
#    5 Director        1655
#    # . with 4 more rows
#    ```
#
## Do not modify this line!

sender_role_count <- email_w_names %>% group_by(sender_role)%>%
  summarize(count = n())%>%
  arrange(desc(count))
print(sender_role_count, n = 5)

# 8. During which period of the day are people tend to send emails?
#    To answer this, use `email_w_names` to produce an histogram of the
#    number of emails sent per our of the day.
#    To do that, use:
#      - `mutate()` and `hour()` to add an `hour` column,
#      - `ggplot()` to initialize the plot,
#      - `geom_histogram()` to plot a histogram for `hour`, with `bins = 24`,
#      - `labs()` to set the
#        - title as `"People send more emails in the middle of the day"`,
#        - x-axis as `"Hour"`
#        - y-axis as `"Count (n)"`.
#    Store the plot into a `ggplot` object `g1`.
#
## Do not modify this line!

g1 <- email_w_names %>% mutate(hour = hour(date))%>%
  ggplot(aes(hour)) + 
  geom_histogram(bins = 24) +
  labs(title = "People send more emails in the middle of the day",
       x = "Hour",
       y = "Count(n)")



# 9. What is the trend regarding emails usage? Do people use it more
#    frequently in 1998 or 2001?
#    From `email_w_names`, extract a tibble `count_by_month` that contains
#    the number of emails sent per `sender_role` for each month from
#    January 1st, 1998 until December 31st, 2001.
#    To do that, you can use:
#      - `filter()` to only keep the emails sent before 2002,
#      - `mutate()` and `floor_date()` to floor the date at the monthly
#        frequency,
#      - `group_by()` to group the data by date and sender's role,
#      - `summarize()` to count the number of emails sent per month and
#        sender's role
#      - `arrange()` to order the rows by date.
#
#    To check your answer:
#
#    The output of `print(count_by_month, n = 5)` is
#
#    ```
#    # A tibble: 265 x 3
#    # Groups:   date [38]
#      date                sender_role       count
#      <dttm>              <fct>             <int>
#    1 1998-11-01 00:00:00 Employee              7
#    2 1998-11-01 00:00:00 Managing Director     2
#    3 1998-12-01 00:00:00 Employee             15
#    4 1998-12-01 00:00:00 Managing Director     3
#    5 1998-12-01 00:00:00 Vice President        2
#    # . with 260 more rows
#    ```
#
## Do not modify this line!

count_by_month <- email_w_names %>% filter(year(date)<2002)%>%
  mutate(date = floor_date(date, "month"))%>%
  group_by(date, sender_role)%>%
  summarize(count = n())%>%
  arrange(date)
print(count_by_month, n = 5)

# 10. Let's now visualize it: plot the `count` against `date` with colors
#    spliting by `sender_role`.
#    To do that, use:
#      - `ggplot()` to initialize the plot,
#      - `geom_point()` to get the scatterplot,
#      - `geom_smooth()` with `method = "loess"` to add a smoothing trend,
#      - `labs()` to set the
#        - title as `"Emailed activity increased from 1999 to 2001"`,
#        - x-axis as `"Date"`
#        - y-axis as `"Count (n)"`,
#        - color as `"Sender role"`.
#    Save your plot to `g2`.
#
## Do not modify this line!

g2 <-count_by_month %>% ggplot(aes(x = date, y = count, coloe = sender_role))+
  geom_point()+
  geom_smooth(method = "loess")+
  labs(title = "Emailed activity increased from 1999 to 2001",
       x = "Date",
       y = "Count (n)",
       color = "Sender role")

# HW7: nycstock
#
# In this exercise, you will conduct a data analysis on NYC stock prices.
# The dataset consists of following files:
#   - `prices.csv`: daily prices, with most of data spanning from 2010 to the
#     end of 2016 (for newer companies, the date range is shorter).
#     The dataset doesn't account for stock splits.
#   - `securities.csv`: general description of each company (e.g., sector).
#   - `fundamentals.csv`: metrics extracted from annual SEC 10K fillings
#     (2012-2016), which allows to derive most of the popular fundamental
#     indicators.
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse` and `lubridates` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_csv` to load
#      - `/course/data/prices.csv` (with `locale = locale(tz = "America/New_York")`
#        to set the timezone properly) and assign it to a tibble `prices`,
#      - `/course/data/securities.csv` and assign it to a tibble `securities`,
#      - `/course/data/fundamentals.csv` and assign it to a tibble `fund`.
#
#    To check your answer:
#
#    The output of `print(prices, n = 5)` is
#
#    ```
#    # A tibble: 851,264 x 7
#      date                symbol  open close   low  high  volume
#      <dttm>              <chr>  <dbl> <dbl> <dbl> <dbl>   <dbl>
#    1 2016-01-05 00:00:00 WLTW    123.  126.  122.  126. 2163600
#    2 2016-01-06 00:00:00 WLTW    125.  120.  120.  126. 2386400
#    3 2016-01-07 00:00:00 WLTW    116.  115.  115.  120. 2489500
#    4 2016-01-08 00:00:00 WLTW    115.  117.  114.  117. 2006300
#    5 2016-01-11 00:00:00 WLTW    117.  115.  114.  117. 1408600
#    # . with 8.513e+05 more rows
#    ```
#
#    The output of `print((prices %>% pull(date))[1:3])` is
#
#    ```
#    [1] "2016-01-05 EST" "2016-01-06 EST" "2016-01-07 EST"
#    ```
#
#    The output of `print(securities, n = 5)` is
#
#    ```
#    # A tibble: 505 x 8
#       Ticker symbol  Security  SEC filings   GICS Sector
#      <chr>           <chr>    <chr>         <chr>
#    1 MMM             3M Comp. reports       Industrials
#    2 ABT             Abbott . reports       Health Care
#    3 ABBV            AbbVie   reports       Health Care
#    4 ACN             Accentu. reports       Information .
#    5 ATVI            Activis. reports       Information .
#    # . with 500 more rows, and 4 more variables:  GICS Sub
#    #   Industry  <chr>,  Address of Headquarters  <chr>,  Date first
#    #   added  <date>, CIK <chr>
#    ```
#
#    The output of `print(fund, n = 5)` is
#
#    ```
#    # A tibble: 1,781 x 78
#       Ticker Symbol   Period Ending   Accounts Payab.  Accounts Recei.
#      <chr>           <chr>                      <dbl>            <dbl>
#    1 AAL             12/31/12              3068000000       -222000000
#    2 AAL             12/31/13              4975000000        -93000000
#    3 AAL             12/31/14              4668000000       -160000000
#    4 AAL             12/31/15              5102000000        352000000
#    5 AAP             12/29/12              2409453000        -89482000
#    # . with 1,776 more rows, and 74 more variables:  Add'l
#    #   income/expense items  <dbl>,  After Tax ROE  <dbl>,  Capital
#    #   Expenditures  <dbl>,  Capital Surplus  <dbl>,  Cash Ratio  <dbl>,
#    #    Cash and Cash Equivalents  <dbl>,  Changes in
#    #   Inventories  <dbl>,  Common Stocks  <dbl>,  Cost of
#    #   Revenue  <dbl>,  Current Ratio  <dbl>,  Deferred Asset
#    #   Charges  <dbl>,  Deferred Liability Charges  <dbl>,
#    #   Depreciation <dbl>,  Earnings Before Interest and Tax  <dbl>,
#    #    Earnings Before Tax  <dbl>,  Effect of Exchange Rate  <dbl>,
#    #    Equity Earnings/Loss Unconsolidated Subsidiary  <dbl>,  Fixed
#    #   Assets  <dbl>, Goodwill <dbl>,  Gross Margin  <dbl>,  Gross
#    #   Profit  <dbl>,  Income Tax  <dbl>,  Intangible Assets  <dbl>,
#    #    Interest Expense  <dbl>, Inventory <dbl>, Investments <dbl>,
#    #   Liabilities <dbl>,  Long-Term Debt  <dbl>,  Long-Term
#    #   Investments  <dbl>,  Minority Interest  <dbl>,  Misc.
#    #   Stocks  <dbl>,  Net Borrowings  <dbl>,  Net Cash Flow  <dbl>,
#    #    Net Cash Flow-Operating  <dbl>,  Net Cash
#    #   Flows-Financing  <dbl>,  Net Cash Flows-Investing  <dbl>,  Net
#    #   Income  <dbl>,  Net Income Adjustments  <dbl>,  Net Income
#    #   Applicable to Common Shareholders  <dbl>,  Net Income-Cont.
#    #   Operations  <dbl>,  Net Receivables  <dbl>,  Non-Recurring
#    #   Items  <dbl>,  Operating Income  <dbl>,  Operating Margin  <dbl>,
#    #    Other Assets  <dbl>,  Other Current Assets  <dbl>,  Other
#    #   Current Liabilities  <dbl>,  Other Equity  <dbl>,  Other
#    #   Financing Activities  <dbl>,  Other Investing Activities  <dbl>,
#    #    Other Liabilities  <dbl>,  Other Operating Activities  <dbl>,
#    #    Other Operating Items  <dbl>,  Pre-Tax Margin  <dbl>,  Pre-Tax
#    #   ROE  <dbl>,  Profit Margin  <dbl>,  Quick Ratio  <dbl>,  Research
#    #   and Development  <dbl>,  Retained Earnings  <dbl>,  Sale and
#    #   Purchase of Stock  <dbl>,  Sales, General and Admin.  <dbl>,
#    #    Short-Term Debt / Current Portion of Long-Term Debt  <dbl>,
#    #    Short-Term Investments  <dbl>,  Total Assets  <dbl>,  Total
#    #   Current Assets  <dbl>,  Total Current Liabilities  <dbl>,  Total
#    #   Equity  <dbl>,  Total Liabilities  <dbl>,  Total Liabilities &
#    #   Equity  <dbl>,  Total Revenue  <dbl>,  Treasury Stock  <dbl>,
#    #    For Year  <dbl>,  Earnings Per Share  <dbl>,  Estimated Shares
#    #   Outstanding  <dbl>
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
theme_set(theme_light())
prices <- read_csv("/course/data/prices.csv",locale = locale(tz = "America/New_York"))
securities <- read_csv("/course/data/securities.csv")
fund <- read_csv("/course/data/fundamentals.csv")
print(prices, n = 5)

# 2. In `securities`, let's keep the companies belonging to the top 6 sectors
#    (by frequency of occurence), as well as those whose `GICS Sub Industry`
#    falls into `"Gold"` or `"Real Estate`" (i.e., `GICS Sub Industry` contains
#    either `"Gold"` or `"REITs"`).
#    You need to do it in two steps:
#      - First, create a tibble named `securities_sectored` that contain
#        only the companies that do not belong to those that you want (see
#        below).
#        Note that `securities_sectored` should contain an additional column
#        `GICS Sector truncated` that contains the top 6 factors in `GICS Sector`
#        and all the others lumped into an additional level `"Other"`.
#      - Second, use `anti_join()` on `securities` and `securities_sectored` to
#        create `securities_selected`, which contains only the rows that
#        meet the requirements above by deleting the rows from `securities`
#        that are in `securities_sectored`.
#        Then, use `select()` to only select the columns `Ticker symbol`,
#        `Security`, and `GICS Sector`.
#    To extract `securities_sectored` from `securities`, you can use:
#        - `mutate()` along with `fct_infreq()` and `fct_lump()` to
#          reorder the sectors by frequency of occurence and lump
#          all except the top 6 into a single level `"Other"`.
#        - `filter()` to select rows such that
#          - `GICS Sector truncated` do not belong to the top 6 (i.e., the ones
#            with the level `"Other"`),
#          - `GICS Sub Industry` does not contain the words `"Gold"` or
#            `"REITs"` (e.g., with `str_detect()` using a regular expression
#            with OR represented by the alternation symbol `"|"`).
#    To check your answer:
#
#    The output of `print(securities_sectored, n = 5)` is
#
#    ```
#    # A tibble: 94 x 9
#       Ticker symbol  Security  SEC filings   GICS Sector
#      <chr>           <chr>    <chr>         <chr>
#    1 AES             AES Corp reports       Utilities
#    2 APD             Air Pro. reports       Materials
#    3 ALB             Albemar. reports       Materials
#    4 LNT             Alliant. reports       Utilities
#    5 AEE             Ameren . reports       Utilities
#    # . with 89 more rows, and 5 more variables:  GICS Sub
#    #   Industry  <chr>,  Address of Headquarters  <chr>,  Date first
#    #   added  <date>, CIK <chr>,  GICS Sector truncated  <fct>
#    ```
#
#    The output of `print(securities_selected, n = 5)` is
#
#    ```
#    # A tibble: 411 x 3
#       Ticker symbol  Security             GICS Sector
#      <chr>           <chr>               <chr>
#    1 MMM             3M Company          Industrials
#    2 ABT             Abbott Laboratories Health Care
#    3 ABBV            AbbVie              Health Care
#    4 ACN             Accenture plc       Information Technology
#    5 ATVI            Activision Blizzard Information Technology
#    # . with 406 more rows
#    ```
#
## Do not modify this line!

securities_sectored <- securities %>% 
  mutate(`GICS Sector truncated` = `GICS Sector` %>% 
           fct_infreq() %>% 
           fct_lump(n = 6))%>%
  filter(`GICS Sector truncated` == "Other") %>% 
  filter(str_detect(`GICS Sub Industry`,"Gold|REITs")==FALSE)
print(securities_sectored, n = 5)
securities_selected <- securities %>% 
  anti_join(securities_sectored)%>%
  select(`Ticker symbol`, Security, `GICS Sector`)
print(securities_selected, n = 5)

#   3. from `fund`, extract a tibble `fund_time` by converting the column name
#    of `fund` from `Ticker Symbol` to `Ticker symbol` (for consistency between
#    the column names of the different tables).
#    Then:
#      - create new column `Period Ending Year` by extract the year from
#        `Period Ending`
#      - drop the rows containing `NA` values,
#      - select the columns `Ticker symbol`, `Period Ending Year` and
#        `Gross Margin`.
#    To do that, you can use:
#      - `rename()` to convert the column name,
#      - `mutate()`, `mdy()` and `year()` to create `Period Ending Year`,
#      - `drop_na()` to drop the rows that contain `NA` values.
#      - `dplyr::select()` to select the required columns.
#
#    To check your answer:
#
#    The output of `print(fund_time, n = 5)` is
#
#    ```
#    # A tibble: 1,299 x 3
#       Ticker symbol   Period Ending Year   Gross Margin
#      <chr>                          <dbl>          <dbl>
#    1 AAL                             2012             58
#    2 AAL                             2013             59
#    3 AAL                             2014             63
#    4 AAL                             2015             73
#    5 AAP                             2012             50
#    # . with 1,294 more rows
#    ```
#
## Do not modify this line!

fund_time <- fund %>%
  rename(`Ticker symbol` = `Ticker Symbol`)%>%
  mutate(`Period Ending Year` = year(mdy(`Period Ending`)))%>%
  drop_na()%>%
  dplyr::select(`Ticker symbol`,`Period Ending Year`,`Gross Margin` )

print(fund_time, n = 5)



# 4. Extract a tibble `securities_fund` by joining `securities_selected`
#    and `fund_time`: `securities_fund` should contain all the rows in
#    `securities_selected` where there is a match in `fund_time`, using
#    `Ticker symbol` as key.
#
#    To check your answer:
#
#    The output of `print(securities_fund, n = 5)` is
#
#    ```
#    # A tibble: 988 x 5
#       Ticker symbol  Security  GICS Sector   Period Ending .
#      <chr>           <chr>    <chr>                    <dbl>
#    1 MMM             3M Comp. Industrials               2013
#    2 MMM             3M Comp. Industrials               2014
#    3 MMM             3M Comp. Industrials               2015
#    4 ABT             Abbott . Health Care               2012
#    5 ABT             Abbott . Health Care               2013
#    # . with 983 more rows, and 1 more variable:  Gross Margin  <dbl>
#    ```
#
## Do not modify this line!

securities_fund <- inner_join(`securities_selected`,fund_time, by = "Ticker symbol")
print(securities_fund, n = 5)





# 5. Generate histograms of the `Gross Margin` by facceted by sector.
#    To do this, use `securities_fund` and:
#      - `geom_histogram()` with `binwidth = 10`,
#      - `facet_wrap()` to facet by `GICS Sector`,
#      - `labs()` to set the
#        - title as `"The gross margin distribution varies by sector"`,
#        - x-axis as `"Gross Margin (%)"`
#        - y-axis as `"Count (n)"`.
#    Store the plot into a `ggplot` object `gross_margin`.
#
## Do not modify this line!

gross_margin <- securities_fund %>% ggplot(aes(x = `Gross Margin`))+
  geom_histogram(binwidth = 10)+
  facet_wrap(~`GICS Sector`)+
  labs(title = "The gross margin distribution varies by sector",
       x  = "Gross Margin (%)",
       y = "Count (n)")




# 6. Let's now look at stock prices.
#    First, from `securities_fund`, extract a tibble `tickers_sectors` that
#    contains the `Ticker symbol`, `Security`, and `GICS Sector` columns,
#    keeping only the `unique()` combinations and `arrange()` them by
#    `Ticker symbol`.
#    Second, from `prices`, extract a tibble `full_stock` that contains the
#    `Ticker symbol` (renamed from `symbol`), `close`, `open`, `date`,
#    and `year` (extracted from `date`), and add it the `Security` and
#    `GICS Sector` information from `tickers_sectors`.
#    Filter out the rows where the `GICS Sector` is not available.
#    To do that, you can use:
#       - `rename()` to conver `symbol` into `Ticker symbol`,
#       - `mutate()` and `year()` to extract the year,
#       - `dplyr::select()` to select the relevant variables
#       - `left_join()` to add the security name and sector,
#       - `filter()` to delete the rows where the sector information is
#         not available.
#
#    To check your answer:
#
#    The output of `print(tickers_sectors, n = 5)` is
#
#    ```
#    # A tibble: 276 x 3
#       Ticker symbol  Security                 GICS Sector
#      <chr>           <chr>                   <chr>
#    1 AAL             American Airlines Group Industrials
#    2 AAP             Advance Auto Parts      Consumer Discretionary
#    3 AAPL            Apple Inc.              Information Technology
#    4 ABBV            AbbVie                  Health Care
#    5 ABC             AmerisourceBergen Corp  Health Care
#    # . with 271 more rows
#    ```
#
#    The output of `print(full_stock, n = 5)` is
#
#    ```
#    # A tibble: 468,588 x 7
#       Ticker symbol   close   open date                 year Security
#      <chr>            <dbl>  <dbl> <dttm>              <dbl> <chr>
#    1 AAL               4.77   4.84 2010-01-04 00:00:00  2010 America.
#    2 AAP              40.4   40.7  2010-01-04 00:00:00  2010 Advance.
#    3 AAPL            214.   213.   2010-01-04 00:00:00  2010 Apple I.
#    4 ABC              26.6   26.3  2010-01-04 00:00:00  2010 Ameriso.
#    5 ABT              54.5   54.2  2010-01-04 00:00:00  2010 Abbott .
#    # . with 4.686e+05 more rows, and 1 more variable:  GICS
#    #   Sector  <chr>
#    ```
#
## Do not modify this line!

tickers_sectors <- securities_fund %>%
  select(`Ticker symbol`, Security,`GICS Sector`)%>%
  unique()%>%
  arrange(`Ticker symbol`)
full_stock <- prices %>% rename(`Ticker symbol` = symbol)%>%
  mutate(year = year(date))%>%
  dplyr::select(`Ticker symbol`, close, open, date, year)%>%
  left_join(tickers_sectors)%>%
  filter(!is.na(`GICS Sector`))

print(tickers_sectors, n = 5)

print(full_stock, n = 5)

# 7. Plot the evolution to the (closing) stock price in 2010~2016 for the
#    following companies:
#      `"Aetna Inc"`, `"Amazon.com Inc"`, `"Facebook"`, `"Whole Foods Market"`,
#      `"FedEx Corporation"`, `"Boeing Company"`, `"The Walt Disney Company"`.
#    To do that, use:
#      - `filter()` to select the rows of the right companies,
#      - `ggplot()` to initialize the plot,
#      - `geom_line()` to get the lineplot (color by `Security`),
#      - `geom_smooth()` with `method = "loess"` to add a smoothing trend,
#      - `labs()` to set the
#        - title as `"Amazon's stock price more than doubled!"`,
#        - x-axis as `"Date"`
#        - y-axis as `"Daily close price (USD)"`.
#    Store the plot into a `ggplot` object `trend`.
## Do not modify this line!

trend <- full_stock %>% filter(Security %in% c("Aetna Inc", "Amazon.com Inc", "Facebook", "Whole Foods Market", "FedEx Corporation", "Boeing Company", "The Walt Disney Company"))%>%
  ggplot(aes(x = date, y = close, color = Security))+
  geom_line()+
  labs(title = "Amazon's stock price more than doubled!",
       x = "Date",
       y = "Daily close price (USD)")




# 8. Calculate the annual "Rate of Return" (RoR, or return) on the securities
#    in `full_stock`. The RoR is defined as the net gain or loss on an
#    investment over a specified time period, calculated as a percentage of the
#    investment's initial cost.
#    Formally, RoR = (current value - initial value) / initial value.
#    From `full_stock`, extract a tibble `return_stock` grouping by
#    `year`, `Ticker symbol`, `GICS Sector`.
#    Then, for year and stock, extract the open corresponding to the first
#    (i.e. `min()`) date, and the close corresponding to the last
#    (i.e. `max()`) date.
#    Finally, compute `return` as `(close - open) / open`.
#    Hint: this can be done simply using `group_by()` and `summarize()`.
#
#    To check your answer:
#
#    The output of `print(return_stock, n = 5)` is
#
#    ```
#    # A tibble: 1,866 x 6
#    # Groups:   year, Ticker symbol [1,866]
#       year  Ticker symbol   GICS Sector             open close return
#      <dbl> <chr>           <chr>                   <dbl> <dbl>  <dbl>
#    1  2010 AAL             Industrials              4.84  10.0  1.07
#    2  2010 AAP             Consumer Discretionary  40.7   66.2  0.625
#    3  2010 AAPL            Information Technology 213.   323.   0.511
#    4  2010 ABC             Health Care             26.3   34.1  0.298
#    5  2010 ABT             Health Care             54.2   47.9 -0.116
#    # . with 1,861 more rows
#    ```
#
## Do not modify this line!

return_stock <- full_stock %>%
  group_by(year, `Ticker symbol`, `GICS Sector`)%>%
  summarize(open = first(open),
            close = last(close),
            return = (close - open) / open)

print(return_stock, n = 5)


# 9. From `return_stock`, extract a tibble `summary_stock` by calculating
#    the mean, 0.25 quantile, mean, and 0.75 quantile of `return`
#    for each `GICS Sector`.
#    Hint: you can do that using `group_by()` and `summarize()`.
#
#    To check your answer:
#
#    The output of `print(summary_stock, n = 5)` is
#
#    ```
#    # A tibble: 8 x 4
#       GICS Sector                q25 mean_return   q75
#      <chr>                     <dbl>       <dbl> <dbl>
#    1 Consumer Discretionary -0.0357       0.150  0.318
#    2 Consumer Staples        0.00668      0.0902 0.192
#    3 Financials             -0.0286       0.100  0.243
#    4 Health Care            -0.0195       0.150  0.256
#    5 Industrials            -0.0422       0.140  0.299
#    # . with 3 more rows
#    ```
## Do not modify this line!

summary_stock <- return_stock %>%
  group_by(`GICS Sector`)%>%
  summarize(q25 = quantile(return, 0.25),
            mean_return = mean(return),
            q75 = quantile(return, 0.75))

print(summary_stock, n = 5)

# HW7: weather
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse`,`lubridates` and `rattle` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `data(weather)` to read the dataset `weather` from the
#    `rattle` package, and convert it into a tibble `weather` using
#    `as_tibble()`.
#
#    To check your answer:
#
#    The output of `print(weather, n = 5)` is
#
#    ```
#    # A tibble: 366 x 24
#      Date       Location MinTemp MaxTemp Rainfall Evaporation Sunshine
#      <date>     <fct>      <dbl>   <dbl>    <dbl>       <dbl>    <dbl>
#    1 2007-11-01 Canberra     8      24.3      0           3.4      6.3
#    2 2007-11-02 Canberra    14      26.9      3.6         4.4      9.7
#    3 2007-11-03 Canberra    13.7    23.4      3.6         5.8      3.3
#    4 2007-11-04 Canberra    13.3    15.5     39.8         7.2      9.1
#    5 2007-11-05 Canberra     7.6    16.1      2.8         5.6     10.6
#    # . with 361 more rows, and 17 more variables: WindGustDir <ord>,
#    #   WindGustSpeed <dbl>, WindDir9am <ord>, WindDir3pm <ord>,
#    #   WindSpeed9am <dbl>, WindSpeed3pm <dbl>, Humidity9am <int>,
#    #   Humidity3pm <int>, Pressure9am <dbl>, Pressure3pm <dbl>,
#    #   Cloud9am <int>, Cloud3pm <int>, Temp9am <dbl>, Temp3pm <dbl>,
#    #   RainToday <fct>, RISK_MM <dbl>, RainTomorrow <fct>
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
library(rattle)
theme_set(theme_light())
weather
print(weather, n = 5)

# 2. From `weather`, extract two tibbles `weather_9am` and `weather_3pm`.
#    `weather_9am` should contain the column `Date`, followed by all the
#    variables which names ending with `"9am"`
#    Note that:
#      - `"9am"` should be removed from the names of the variables.
#      - The `Date` should be converted into a date-time object as follows.
#        Instead of `"Y-M-D"`, it should  `"Y-M-D 09:00:00 AECT"`,
#        where `"AECT"` is the time zone code for Australian Eastern Time
#        `09:00:00` corresponds to 9am.
#
#    To check your answer:
#
#    The output of `print(weather_9am, n = 5)` is
#
#    ```
#    # A tibble: 366 x 7
#      Date                WindDir WindSpeed Humidity Pressure Cloud  Temp
#      <dttm>              <ord>       <dbl>    <int>    <dbl> <int> <dbl>
#    1 2007-11-01 09:00:00 SW              6       68    1020.     7  14.4
#    2 2007-11-02 09:00:00 E               4       80    1012.     5  17.5
#    3 2007-11-03 09:00:00 N               6       82    1010.     8  15.4
#    4 2007-11-04 09:00:00 WNW            30       62    1006.     2  13.5
#    5 2007-11-05 09:00:00 SSE            20       68    1018.     7  11.1
#    # . with 361 more rows
#    ```
#
#    The output of `print(weather_3pm, n = 5)` is
#
#    ```
#    # A tibble: 366 x 7
#      Date                WindDir WindSpeed Humidity Pressure Cloud  Temp
#      <dttm>              <ord>       <dbl>    <int>    <dbl> <int> <dbl>
#    1 2007-11-01 15:00:00 NW             20       29    1015      7  23.6
#    2 2007-11-02 15:00:00 W              17       36    1008.     3  25.7
#    3 2007-11-03 15:00:00 NNE             6       69    1007.     7  20.2
#    4 2007-11-04 15:00:00 W              24       56    1007      7  14.1
#    5 2007-11-05 15:00:00 ESE            28       49    1018.     7  15.4
#    # . with 361 more rows
#    ```
#
## Do not modify this line!

weather_9am <- weather %>% select(Date,ends_with("9am"))%>%
  rename_all(~str_replace_all(.,"9am",""))%>%
  mutate(Date=make_datetime(year=year(Date), month=month(Date), day=day(Date), hour = 9, min = 0, sec = 0, tz = "Australia/Canberra"))
print(weather_9am, n = 5)

weather_3pm <- weather %>% select(Date,ends_with("3pm"))%>%
  rename_all(~str_replace_all(.,"3pm",""))%>%
  mutate(Date=make_datetime(year=year(Date), month=month(Date), day=day(Date), hour = 15, min = 0, sec = 0, tz = "Australia/Canberra"))
print(weather_3pm, n = 5)

# 3. From the tibbles `weather_9am` and `weather_3pm`, create a tibble
#    `humidity_temp` by
#      - full-joining them,
#      - creating `hour`, a factor variable corresponding to the hour of day,
#      - creating `yday`, a numeric variable corresponding to the day of year,
#      - selecting the `yday`, `hour`, `Humidity`, and `Temp` columns,
#      - making the data longer by pivoting around the `Humidity` and `Temp`
#        columns,
#      - sorting by day of year and hour.
#    To do so, you can use `full_join()` (or `bind_rows()`), `mutate()`,
#    `dplyr::select()`, `pivot_longer()` and `arrange()`.
#
#    To check your answer:
#
#    The output of `print(humidity_temp, n = 5)` is
#
#    ```
#    # A tibble: 1,464 x 4
#       yday hour  name     value
#      <dbl> <fct> <chr>    <dbl>
#    1     1 9     Humidity  50
#    2     1 9     Temp      21.9
#    3     1 15    Humidity  20
#    4     1 15    Temp      31.8
#    5     2 9     Humidity  43
#    # . with 1,459 more rows
#    ```
#
## Do not modify this line!

humidity_temp <-  full_join(weather_9am, weather_3pm) %>% 
  mutate(hour = as.factor(hour(Date)), yday = yday(Date)) %>%
  dplyr::select(yday, hour, Humidity, Temp)%>%  
  pivot_longer(c(Humidity, Temp), names_to = "name", values_to = "value") %>%
  arrange(yday, hour)
print(humidity_temp, n = 5)

# 4. Produce a smooth regression plot of `value` against `yday`,
#    colored by `hour` and with line type by `name`.
#    To do this, use `humidity_temp` and:
#      - `ggplot` to initialize the plot,
#      - `geom_smooth()` to get the smooth regression plot, and set the `se`
#        as `FALSE`, and the `method` as `"loess"`,
#      - `labs()` to set the
#        - title as `"Temperature and humidity are negatively correlated"`,
#        - x-axis as `"Day of the year"`,
#        - y-axis as `"Humidity (percent) and temperature (degrees C)"`,
#        - color as `"Hour"`,
#        - line type as `"Measurement"`,
#      - `theme` to set the `legend.position` as `"bottom"`.
#    Store the plot into a `ggplot` object `temp_humidity_plot`.
#
## Do not modify this line!

temp_humidity_plot <- ggplot(humidity_temp, aes(x = yday, y = value,
                                                color = hour, linetype = name))+
  geom_smooth(se = FALSE, method = "loess")+
  labs(title = "Temperature and humidity are negatively correlated",
       x = "Day of the year",
       y = "Humidity (percent) and temperature (degrees C)",
       color = "Hour",
       linetype = "Measurement")

# 5. From `weather_9am` and `weather_3pm`, extract two tibbles
#    `weather_wind_9am` and `weather_wind_3pm` by
#      - selecting the variables `WindDir` and `Temp`,
#      - adding a variable `Hour` (respectively as `"9am"` and `"3pm"`).
#    To do that, you can use `dplyr::select()` and `mutate()`.
#    Then, from the tibbles `weather_wind_9am` and `weather_wind_3pm`,
#    create a tibble `weather_wind` by
#      - full-joining them,
#      - dropping the NAs,
#      - creating `WindMainDir`, a character variable corresponding to the
#        first letter of `WindDir`,
#      - transforming `Hour` into a factor with levels as `c("9am", "3pm")`.
#    To do so, you can use `full_join()`, `drop_na()`, `str_sub()`,
#    and `mutate()`.
#
#    To check your answer:
#
#    The output of `print(weather_wind_9am, n = 5)` is
#
#    ```
#    # A tibble: 366 x 3
#      WindDir  Temp Hour
#      <ord>   <dbl> <chr>
#    1 SW       14.4 9am
#    2 E        17.5 9am
#    3 N        15.4 9am
#    4 WNW      13.5 9am
#    5 SSE      11.1 9am
#    # . with 361 more rows
#    ```
#
#    The output of `print(weather_wind_3pm, n = 5)` is
#
#    ```
#    # A tibble: 366 x 3
#      WindDir  Temp Hour
#      <ord>   <dbl> <chr>
#    1 NW       23.6 3pm
#    2 W        25.7 3pm
#    3 NNE      20.2 3pm
#    4 W        14.1 3pm
#    5 ESE      15.4 3pm
#    # . with 361 more rows
#    ```
#
#    The output of `print(weather_wind, n = 5)` is
#
#    ```
#    # A tibble: 700 x 4
#      WindDir  Temp Hour  WindMainDir
#      <ord>   <dbl> <fct> <fct>
#    1 SW       14.4 9am   S
#    2 E        17.5 9am   E
#    3 N        15.4 9am   N
#    4 WNW      13.5 9am   W
#    5 SSE      11.1 9am   S
#    # . with 695 more rows
#    ```
## Do not modify this line!

weather_wind_9am <- weather_9am %>%
  dplyr::select(WindDir, Temp)%>%
  mutate(Hour = "9am")

weather_wind_3pm <- weather_3pm %>%
  dplyr::select(WindDir, Temp)%>%
  mutate(Hour = "3pm")

weather_wind <- weather_wind_9am %>% full_join( weather_wind_3pm)%>%
  drop_na()%>%
  mutate(a = str_sub(WindDir, 1, 1))%>%
  mutate(WindMainDir = factor(a, levels = c("E","N","S","W")))%>%
  mutate(Hour = factor(Hour, levels = c("9am", "3pm")))%>%
  select(-a)
print(weather_wind_9am, n = 5)
print(weather_wind_3pm, n = 5)
print(weather_wind, n = 5)

# 6. Finally, use `weather_wind` to produce a boxplot of `Temp` against
#    `WindMainDir`, facetted by `Hour`.
#    To do this, use `weather_wind` and:
#      - `ggplot` to initialize the plot,
#      - `geom_boxplot()` to get the boxplot,
#      - `facet_grid()` for the facetting,
#      - `labs()` to set the
#        - title as `"Temperature is higher in the afternoon"`,
#        - subtitle as
#
#         ```
#         str_wrap("In the morning, it decreases when
#                  the winds turns from East to West", width = 70)
#         ```
#
#        - x-axis as `"Wind direction"`,
#        - y-axis as `"Temperature (degree C)"`,
#      - `theme` to set the `legend.position` as `"bottom"`.
#    Store the plot into a `ggplot` object `wind_boxplot`.
#
## Do not modify this line!

wind_boxplot<-weather_wind %>% ggplot(aes(y = Temp, x = WindMainDir))+
  geom_boxplot()+
  facet_grid(~Hour)+
  labs(title = "Temperature is higher in the afternoon",
       subtitle = str_wrap("In the morning, it decreases when
        the winds turns from East to West", width = 70),
       x = "Wind direction",
       y = "Temperature (degree C)")+
  theme(legend.position="bottom")

# HW7: relational1
#
# This exercise was inspired by exercise 6 in Chapter 2 of
# [Bit By Bit: Social Research in the Digital Age]
# (https://www.bitbybitbook.com/en/1st-ed/observing-behavior/observing-activities/)
# by Matt Salganik.
#
# "In a widely discussed paper, Michel and colleagues
# ([2011](https://doi.org/10.1126/science.1199644)) analyzed the content of
# more than five million digitized books in an attempt to identify long-term
# cultural trends. The data that they used has now been released as the Google
# NGrams dataset, and so we can use the data to replicate and extend some of
# their work.
#
# In one of the many results in the paper, Michel and colleagues argued that we
# are forgetting faster and faster. For a particular year, say "1883," they
# calculated the proportion of all terms published in each year between 1875
# and 1975 that were "1883". They reasoned that this proportion is a measure of
# the interest in events that happened in that year. In their figure 3a, they
# plotted the usage trajectories for three years: 1883, 1910, and 1950. These
# three years share a common pattern: little use before that year, then a
# spike, then decay."
#
# They noticed the rate of decay for each year mentioned seemed to increase
# with time and they argued that this means that we are forgetting the past
# faster and faster.
#
# The full paper can be found
# [here](https://aidenlab.org/papers/Science.Culturomics.pdf), and you are
# going to replicate part of figure 3a.
#
# To do so we will focus on the mention of terms that can represent years
# (strings like "1765", "1886", "1897", "1937"...). The raw data was fetched
# for you from the [Google Books NGram Viewer website]
# (http://storage.googleapis.com/books/ngrams/books/datasetsv2.html) and
# preprocessed into two files:
#   - `mentions_yearly_counts.tsv` contains the number of mentions of
#     different terms per year and the number of books retrieved where the term
#     appeared each year (one row per term per year).
#   - `yearly_total_counts.csv` contains the total number of mentions of
#     all terms per year as well as the number of pages and books retrived each
#     year (one row per year).
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse` and `scales` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_tsv` to load `/course/data/mentions_yearly_counts.tsv` and assign
#    the resulting tibble to `terms_mentions`.
#    Set the parameters of `read_tsv()` in order to make sure of the following:
#      - Column names should be `"term"`, `"year"`, `"n_mentions"`,
#        and `"book_count"`.
#      - Column types should be `character`, `integer`, `integer`, `integer`.
#    Hint: you can use parameters `col_names` and `col_types` to achieve this.
#
#    To check your answer:
#
#    The output of `print(terms_mentions, n = 5)` is
#
#    ```
#    # A tibble: 53,393 x 4
#      term   year n_mentions book_count
#      <chr> <int>      <int>      <int>
#    1 1817   1524         31          1
#    2 1817   1575         17          1
#    3 1817   1607          3          1
#    4 1817   1637          2          1
#    5 1817   1662          1          1
#    # . with 5.339e+04 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
library(scales)
theme_set(theme_light())
terms_mentions <- read_tsv("/course/data/mentions_yearly_counts.tsv",
                           col_names= c("term", "year", "n_mentions","book_count"),
                           col_types = cols(term = col_character(),
                                            year = col_integer(),
                                            n_mentions = col_integer(), 
                                            book_count = col_integer()))
print(terms_mentions, n = 5)

# 2. Similarly, load `/course/data/yearly_total_counts.csv` using `read_csv()` and
#    assign the resulting tibble to `total_mentions`.
#    Set the parameters of `read_csv()` in order to make sure of the following:
#      - Column names should be `"year"`, `"total_mentions"`,
#        `"total_page_count"`, `"total_book_count"`.
#      - Column types should be `integer`, `double`, `integer`, `integer`.
#    Hint: you can use parameters `col_names` and `col_types` to achieve this.
#    Note: the reason you should read in the `total_mentions` as a `double`
#    column is that it contains very large integers that don't fit within the
#    bounds of numbers represented by the `integer` type in R. Using a
#    double-precision number is our only recourse.
#
#    To check your answer:
#
#    The output of `print(total_mentions, n = 5)` is
#
#    ```
#    # A tibble: 425 x 4
#       year total_mentions total_page_count total_book_count
#      <int>          <dbl>            <int>            <int>
#    1  1505          32059              231                1
#    2  1507          49586              477                1
#    3  1515         289011             2197                1
#    4  1520          51783              223                1
#    5  1524         287177             1275                1
#    # . with 420 more rows
#    ```
#
## Do not modify this line!

total_mentions <- read_csv("/course/data/yearly_total_counts.csv",
                           col_names = c("year", "total_mentions", "total_page_count", "total_book_count"),
                           col_types = list("integer", "double", "integer", "integer")
)
print(total_mentions, n = 5)

# 3. From `terms_mentions`, extract a new tibble `mentions` by left-joining
#    the `total_mentions` tibble.
#    `mentions` should print to:
#
#    To check your answer:
#
#    The output of `print(mentions, n = 5)` is
#
#    ```
#    # A tibble: 53,393 x 7
#      term   year n_mentions book_count total_mentions total_page_count
#      <chr> <int>      <int>      <int>          <dbl>            <int>
#    1 1817   1524         31          1         287177             1275
#    2 1817   1575         17          1         186706             1067
#    3 1817   1607          3          1         381763             1600
#    4 1817   1637          2          1         681719             2315
#    5 1817   1662          1          1         239762             1471
#    # . with 5.339e+04 more rows, and 1 more variable:
#    #   total_book_count <int>
#    ```
#
## Do not modify this line!

mentions <- terms_mentions %>% left_join(total_mentions)
print(mentions, n = 5)

# 4. Check that your join was successful by using `anti_join()` to drop all
#    observations in `terms_mentions` that have a match in `mentions` and
#    assign the resulting tibble to `diagnosis`. If the join went as expected
#    `diagnosis` should be an empty tibble with the same columns as
#    `terms_mentions`.
#
## Do not modify this line!

diagnosis <- terms_mentions %>% anti_join(mentions)
diagnosis

# 5. From `mentions`, extract a new tibble `relative_mention_counts` by adding
#    a column `frac_total` containing the frequency of mentions of each term
#    per year. This frequency is obtained by dividing the number of
#    mentions of each term per year by the total number of mentions of all
#    terms that year,
#    Then, select only columns `term`, `year`, `n_mentions`,
#    `total_mentions` and `frac_total`.
#    Hint: you can use `mutate()` and `select()`.
#
#    To check your answer:
#
#    The output of `print(relative_mention_counts, n = 5)` is
#
#    ```
#    # A tibble: 53,393 x 5
#      term   year n_mentions total_mentions frac_total
#      <chr> <int>      <int>          <dbl>      <dbl>
#    1 1817   1524         31         287177 0.000108
#    2 1817   1575         17         186706 0.0000911
#    3 1817   1607          3         381763 0.00000786
#    4 1817   1637          2         681719 0.00000293
#    5 1817   1662          1         239762 0.00000417
#    # . with 5.339e+04 more rows
#    ```
#
## Do not modify this line!

relative_mention_counts <- mentions %>% mutate(frac_total = n_mentions/total_mentions)%>%
  select(term, year, n_mentions, total_mentions,frac_total)
print(relative_mention_counts, n = 5)

# 6. From `relative_mention_counts`, extract a new tibble
#    `examples_mention_counts` by
#      - keeping only the terms `"1883"`, `"1910"` and `"1950"`,
#      - transform the terms from characters to a factor in which the levels
#        are in reversed alphabetical order (`"1950"`, `"1910"` and `"1883"`)
#    Hint: you can use `filter()`, `mutate()` and `fct_rev()`.
#    Note: the order matters to reproduce the same colors as the original
#    figure without setting them explicitely when generating the plot.
#
#    To check your answer:
#
#    The output of `print(examples_mention_counts, n = 5)` is
#
#    ```
#    # A tibble: 825 x 5
#      term   year n_mentions total_mentions frac_total
#      <fct> <int>      <int>          <dbl>      <dbl>
#    1 1883   1515          1         289011 0.00000346
#    2 1883   1520          1          51783 0.0000193
#    3 1883   1524         15         287177 0.0000522
#    4 1883   1574          4          62235 0.0000643
#    5 1883   1575          3         186706 0.0000161
#    # . with 820 more rows
#    ```
#
## Do not modify this line!

examples_mention_counts <- relative_mention_counts %>% filter(term %in% c(1883,1910,1950))%>%
  mutate(term = factor(term, levels = fct_rev(c("1950", "1910","1883"))))
print(examples_mention_counts, n = 5)

# 7. Generate a plot to reproduce the large window of figure 3a and assign the
#    result to `paper_figure`.
#    To do this, use `examples_mention_counts` and:
#      - `ggplot` to initialize the plot,
#      - `geom_line()` to get the lineplot,
#      - `scale_y_continuous(label = percent)` to set the y-axis labels to
#        the percent format,
#      - `coord_cartesian()` and its argument `xlim` to limit the coordinates
#        to show only the mentions across the timeframe `1850`-`2012`,
#      - `labs()` to set the
#        - title as `"Are we neglecting the past faster?"`,
#        - x-axis as `"Year"`
#        - y-axis as `"Frequency of mention of each term"`,
#        - color as `"Term"`.
#    Store the plot into a `ggplot` object `paper_figure`.
#
## Do not modify this line!

paper_figure <- examples_mention_counts %>% ggplot(aes(x = year, y = frac_total, color = term))+
  geom_line()+
  scale_y_continuous(label = percent)+
  coord_cartesian(xlim = c(1850,2012))+
  labs(title = "Are we neglecting the past faster?",
       x = "Year",
       y = "Frequency of mention of each term",
       color = "Term",
  )

# HW7: relational2
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse`, `scales` and `lubridates` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_csv` to load
#      - `/course/data/guest_house/booking.csv` and assign it to a tibble `booking`,
#      - `/course/data/guest_house/guest.csv` and assign it to a tibble `guest`,
#      - `/course/data/guest_house/rate.csv` and assign it to a tibble `rate`,
#      - `/course/data/guest_house/room.csv` and assign it to a tibble `room`.
#
#    To check your answer:
#
#    The output of `print(booking, n = 5)` is
#
#    ```
#    # A tibble: 347 x 8
#      booking_id booking_date room_no guest_id occupants room_type_reque.
#           <dbl> <chr>          <dbl>    <dbl>     <dbl> <chr>
#    1       5001 11/3/2016        101     1027         1 single
#    2       5002 11/3/2016        102     1179         1 double
#    3       5003 11/3/2016        103     1106         2 double
#    4       5004 11/3/2016        104     1238         1 double
#    5       5005 11/3/2016        105     1540         3 family
#    # . with 342 more rows, and 2 more variables: nights <dbl>,
#    #   arrival_time <time>
#    ```
#
#    The output of `print(guest, n = 5)` is
#
#    ```
#    # A tibble: 649 x 4
#         id first_name last_name address
#      <dbl> <chr>      <chr>     <chr>
#    1  1001 Jim        Dowd      Lewisham West and Penge
#    2  1002 Lyn        Brown     West Ham
#    3  1003 Ann        Clwyd     Cynon Valley
#    4  1004 Nic        Dakin     Scunthorpe
#    5  1005 Pat        Glass     North West Durham
#    # . with 644 more rows
#    ```
#
#    The output of `print(rate, n = 5)` is
#
#    ```
#    # A tibble: 8 x 3
#      room_type occupancy amount
#      <chr>         <dbl>  <dbl>
#    1 double            1     56
#    2 double            2     72
#    3 family            1     56
#    4 family            2     72
#    5 family            3     84
#    # . with 3 more rows
#    ```
#
#    The output of `print(room, n = 5)` is
#
#    ```
#    # A tibble: 30 x 3
#         id room_type max_occupancy
#      <dbl> <chr>             <dbl>
#    1   101 single                1
#    2   102 double                2
#    3   103 double                2
#    4   104 double                2
#    5   105 family                3
#    # . with 25 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
library(scales)
library(lubridate)
theme_set(theme_light())
booking <- read_csv("/course/data/guest_house/booking.csv")
guest<- read_csv("/course/data/guest_house/guest.csv")
rate <- read_csv("/course/data/guest_house/rate.csv")
room <- read_csv("/course/data/guest_house/room.csv")


# 2. From `booking`, extract a tibble `room_earning` by left-joining the
#    `rate` tibble. Then, add a column `earning` containing the earning of
#    each booking, defined as `amount` times `nights`.
#    Finally, some tidying:
#      - Convert `booking_date` to class `"Date"`.
#      - Convert `room_no` to a factor with levels ordered by median `earning`.
#      - Sort by `booking_date`, breaking the ties by `room_no`.
#      - Select the columns `booking_date`, `room_no`, `guest_id`,
#        `nights`, and `earning`.
#    Hint: to do that, you can use `left_join()`, `mutate()`, `mdy()`,
#    `fct_order()`, `arrange()`  and `select()`.
#
#    To check your answer:
#
#    The output of `print(room_earning, n = 5)` is
#
#    ```
#    # A tibble: 347 x 5
#      booking_date room_no guest_id nights earning
#      <date>       <fct>      <dbl>  <dbl>   <dbl>
#    1 2016-11-03   309         1060      1      56
#    2 2016-11-03   102         1179      2     112
#    3 2016-11-03   301         1406      4     192
#    4 2016-11-03   108         1136      1      56
#    5 2016-11-03   210         1626      5     360
#    # . with 342 more rows
#    ```
#
#    The output of `print((room_earning %>% pull(room_no))[1:5], max.levels = 3)` is
#
#    ```
#    [1] 309 102 301 108 210
#    30 Levels: 309 102 ... 203
#    ```
#
## Do not modify this line!

room_earning = booking %>% 
  left_join(rate, by=c('room_type_requested'='room_type', 'occupants'='occupancy'))%>% 
  mutate(earning=amount*nights) %>% 
  mutate(booking_date=mdy((booking_date))) %>% 
  mutate(room_no=fct_reorder( as_factor(room_no), earning, median)) %>% 
  arrange(booking_date, room_no) %>% 
  select(booking_date, room_no,guest_id,nights,earning)

print(room_earning, n = 5)




# 3. Let's visualize the earnings per rooms using a boxplot.
#    To do this, use `room_earning` and:
#      - `ggplot` to initialize the plot,
#      - `geom_boxplot()` to get the boxplot,
#      - `scale_y_continuous()` with `label_dollar()` to set the y-axis labels
#        to dollar format,
#      - `coord_flip()` to flip the axes,
#      - `labs()` to set the
#        - title as `"Most rooms have earnings between $100 and $300"`,
#        - x-axis as `"Room number"`,
#        - y-axis as `"Earnings"`.
#    Store the plot into a `ggplot` object `room_earning_plot`.
#
## Do not modify this line!

room_earning_plot <- room_earning %>% ggplot(aes(x = room_no,y = earning))+
  geom_boxplot()+
  scale_y_continuous(labels = label_dollar())+
  coord_flip()+
  labs(title = "Most rooms have earnings between $100 and $300",
       x = "Room number",
       y = "Earnings")



# 4. From `guest`, extract a tibble `guest_spending` that stores, for the 10
#    "biggest clients":
#      - `name`, the full name of the `guest`,
#      - `nights`, the total number of nights spent by the guest,
#      - `spending`, the total dollar amount spent by the guest.
#    Here, the 10 biggest clients means the 10 that spent the most.
#    Make sure that:
#      - `name` is a factor whose levels are ordered by median `spending`,
#      - you sort the data by descending total spending.
#    You can use :
#      - `mutate()` and `paste()` to concatenate `first_name` and
#        `last_name` in `guest`,
#      - `right_join()` to join the aforementioned tibble with
#        `room_earning`,
#      - `group_by()`  and `summarize()` to compute the total number of
#        `nights` and `spending` for each guest,
#      - `arrange()` and `head()` to sort and select the biggest spenders,
#      - `fct_reorder()` to transform `name` into factor with appropriate
#        levels ordering.
#
#    To check your answer:
#
#    The output of `print(guest_spending, n = 5)` is
#
#    ```
#    # A tibble: 10 x 3
#      name                nights spending
#      <fct>                <dbl>    <dbl>
#    1 Sir Edward Garnier      11      780
#    2 Robert Halfon           10      768
#    3 Angela Rayner           14      744
#    4 Karin Smyth             11      696
#    5 Sir Alan Haselhurst     11      680
#    # . with 5 more rows
#    ```
#
#    The output of `print((guest_spending %>% pull(name))[1:3], max.levels = 3)` is
#
#    ```
#    [1] Sir Edward Garnier Robert Halfon      Angela Rayner
#    10 Levels: Craig Tracey Hannah Bardell ... Sir Edward Garnier
#    ```
#
## Do not modify this line!

guest_spending <- guest %>% mutate(name = paste(first_name, last_name, sep = " "))%>%
  right_join(room_earning, by = c("id" = "guest_id"))%>%
  group_by(name)%>%
  summarize(nights = sum(nights), spending = sum(earning))%>%
  mutate(name = fct_reorder(name,spending, median))%>%
  arrange(desc(spending))%>% head(10)
print(guest_spending, n = 5)
print((guest_spending %>% pull(name))[1:3], max.levels = 3)

# 5. Produce a barplot of the spendings of the 10 biggest clients.
#    The bars should be horizontal and ordered by total spending
#    from highest (on top of the figure) to lowest.
#    To do this, use `guest_spending` and:
#      - `ggplot` to initialize the plot,
#      - `geom_col()` to get the barplot,
#      - `scale_y_continuous()` with `label_dollar()` to set the y-axis labels
#        to dollar format,
#      - `coord_flip()` to flip the axes,
#      - `labs()` to set the
#        - title as `"Top 10 guests all spent more than $600"`,
#        - x-axis as `"Name"`,
#        - y-axis as `"Spending"`.
#    Store the plot into a `ggplot` object `guest_spending_plot`.
#
## Do not modify this line!

guest_spending_plot<-guest_spending %>% ggplot(aes(x = name, y = spending))+
  geom_col()+
  scale_y_continuous(labels = label_dollar())+
  coord_flip()+
  labs(title = "Top 10 guests all spent more than $600",
       x = "Name",
       y = "Spending")

# HW7: relational3
#
# In this exercise, we'll look at data about a university.
# This dataset contains four tables:
#   - `department.csv` contains information about the university's departments,
#     including `Department_ID`, `Department_Name` and `DOE` (date of
#     establishment).
#   - `employee.csv` contains information about the faculty, including
#     `Employee_ID`, `DOB` (date of birth), `DOJ` (date of university joining)
#     and the `Department_ID` to which the person belongs.
#   - `s_admission.csv` contains information about students' admission,
#     including `Student_ID`, `DOA` (date of admission), `DOB`,
#     `Department_Choices` (choices student made during counselling) and
#     `Department_Admission` (department offered to student).
#   - `s_performance` contains information about students' performances,
#     including `Student_ID`, `Semester_Name`, `Paper_ID`, `Paper_Name` and
#     `Marks` (marks scored in examination).
# After preprocessing each table, we will focus on the Engineering School.
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse` and `lubridates` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_csv` to load
#      - `/course/data/department_info.csv` and assign it to a tibble `booking`,
#      - `/course/data/employee_info.csv` and assign it to a tibble `guest`,
#      - `/course/data/student_counselling_info.csv` and assign it to a tibble
#        `s_admission`,
#      - `/course/data/student_performance_info.csv` and assign it to a tibble
#        `s_performance`.
#
#    To check your answer:
#
#    The output of `print(department, n = 5)` is
#
#    ```
#    # A tibble: 40 x 3
#      Department_ID Department_Name                DOE
#      <chr>         <chr>                          <dttm>
#    1 IDEPT4670     Aerospace Engineering          1961-05-31 00:00:00
#    2 IDEPT5528     Biosciences and Bioengineering 1943-06-28 00:00:00
#    3 IDEPT3115     Chemical Engineering           1940-05-01 00:00:00
#    4 IDEPT5881     Chemistry                      2013-06-08 00:00:00
#    5 IDEPT4938     Civil Engineering              1941-10-27 00:00:00
#    # . with 35 more rows
#    ```
#
#    The output of `print(employee, n = 5)` is
#
#    ```
#    # A tibble: 1,000 x 4
#      Employee_ID DOB                 DOJ                 Department_ID
#      <chr>       <dttm>              <dttm>              <chr>
#    1 IU196557    1983-02-23 00:00:00 2009-10-31 00:00:00 IDEPT4938
#    2 IU449901    1985-09-02 00:00:00 2009-06-07 00:00:00 IDEPT2357
#    3 IU206427    1971-07-30 00:00:00 2008-05-09 00:00:00 IDEPT4670
#    4 IU688905    1973-07-20 00:00:00 2002-01-17 00:00:00 IDEPT2601
#    5 IU634582    1991-11-16 00:00:00 2000-02-13 00:00:00 IDEPT7626
#    # . with 995 more rows
#    ```
#
#    The output of `print(s_admission, n = 5)` is
#
#    ```
#    # A tibble: 4,000 x 5
#      Student_ID DOA                 DOB                 Department_Choi.
#      <chr>      <dttm>              <dttm>              <chr>
#    1 SID201311. 2013-07-01 00:00:00 1996-02-05 00:00:00 IDEPT7783
#    2 SID201311. 2013-07-01 00:00:00 1995-07-31 00:00:00 IDEPT6347
#    3 SID201311. 2013-07-01 00:00:00 1995-09-05 00:00:00 IDEPT1836
#    4 SID201311. 2013-07-01 00:00:00 1996-01-12 00:00:00 IDEPT8473
#    5 SID201311. 2013-07-01 00:00:00 1995-07-30 00:00:00 IDEPT5528
#    # . with 3,995 more rows, and 1 more variable:
#    #   Department_Admission <chr>
#    ```
#
#    The output of `print(s_performance, n = 5)` is
#
#    ```
#    # A tibble: 209,611 x 5
#      Student_ID  Semster_Name Paper_ID    Paper_Name Marks
#      <chr>       <chr>        <chr>       <chr>      <dbl>
#    1 SID20131143 Sem_1        SEMI0012995 Paper 1       44
#    2 SID20131143 Sem_1        SEMI0015183 Paper 2       74
#    3 SID20131143 Sem_1        SEMI0018371 Paper 3       80
#    4 SID20131143 Sem_1        SEMI0015910 Paper 4       44
#    5 SID20131143 Sem_1        SEMI0016208 Paper 5       95
#    # . with 2.096e+05 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
theme_set(theme_light())
department <- read_csv("/course/data/department_info.csv")
employee <- read_csv("/course/data/employee_info.csv")
s_admission <- read_csv("/course/data/student_counselling_info.csv")
s_performance <- read_csv("/course/data/student_performance_info.csv")


# 2. From `employee`, extract a tibble `employee_new` with columns
#    `Employee_ID`, `Department_ID`, `age`, `seniority` and `seniority_level`,
#    where
#      - `age` is the age of the professor (in years),
#      - `seniority` is the year of number of years since joining,
#      - and `seniority_level` is a factor with two levels, namely `"junior"`
#        (`seniority` <= 10) and `"senior`" (`seniority` > 10).
#    To do this, you can use `mutate()` to create the columns
#      - `age` and `seniority` from `DOB` and `DOJ` repectively by
#        - creating an interval with `%--%`, `today()` and `dyears()`.
#        - flooring the years to integers with `floor()`.
#      - `seniority_level` to categorize `seniority` by
#        - cutting `seniority` with `cut()`, setting
#          `breaks = min(seniority), 10, max(seniority)`,
#          `labels = c("junior", "senior")`, and `include.lowest = TRUE`,
#    Then, you can use `dplyr::select()` to select the desired columns.
#
#    To check your answer:
#
#    The output of `print(employee_new, n = 5)` is
#
#    ```
#    # A tibble: 1,000 x 5
#      Employee_ID Department_ID   age seniority seniority_level
#      <chr>       <chr>         <dbl>     <dbl> <fct>
#    1 IU196557    IDEPT4938        37        10 junior
#    2 IU449901    IDEPT2357        34        10 junior
#    3 IU206427    IDEPT4670        48        11 senior
#    4 IU688905    IDEPT2601        46        18 senior
#    5 IU634582    IDEPT7626        28        20 senior
#    # . with 995 more rows
#    ```
#
## Do not modify this line!

employee_new <- employee %>% mutate(age = floor((DOB %--% today()) / dyears(1)), 
                                    seniority = floor((DOJ %--% today()) / dyears(1)),
                                    seniority_level = cut(seniority, breaks = c(min(seniority), 10, max(seniority)), 
                                                          labels = c("junior", "senior"), 
                                                          include.lowest = TRUE))%>%
  dplyr::select(Employee_ID, Department_ID, age, seniority, seniority_level)



print(employee_new, n = 5)


# 3. From `s_admission`, extract a tibble `s_admission_new` with columns
#    `Student_ID`, `Department_Admission`, `age` and `school_year`, where
#      - `age` is the age of the student,
#      - `school_year` is the class standing, a factor with four levels, namely
#        `"graduate"`, `"senior"`, `"junior"`, `"sophomore"` or `"freshman"`.
#    To do this, you can use `mutate()` to create the columns `age` from
#    `DOB` similarly as above, and `school_year` by
#      - transforming `DOA` into a factor with `factor()`.
#      - collapsing the levels `"2013-07-01"` and `"2014-07-01"` into
#        `"graduate"` with `fct_collapse()`,
#      - recoding the other levels with `fct_recode()` to make
#        - `"2015-07-01"` into `"senior"`,
#        - `"2016-07-01"` into `"junior"`,
#        - `"2017-07-01"` into `"sophomore"`,
#        - `"2018-07-01"` into `"freshman"`,
#    Then, you can use `dplyr::select()` to select the desired columns.
#
#    To check your answer:
#
#    The output of `print(s_admission_new, n = 5)` is
#
#    ```
#    # A tibble: 4,000 x 4
#      Student_ID  Department_Admission   age school_year
#      <chr>       <chr>                <dbl> <fct>
#    1 SID20131143 IDEPT7783               24 graduate
#    2 SID20131151 IDEPT6347               24 graduate
#    3 SID20131171 IDEPT1836               24 graduate
#    4 SID20131176 IDEPT8473               24 graduate
#    5 SID20131177 IDEPT5528               24 graduate
#    # . with 3,995 more rows
#    ```
#
#    The output of `print(tail(s_admission_new), n = 5)` is
#
#    ```
#    # A tibble: 6 x 4
#      Student_ID  Department_Admission   age school_year
#      <chr>       <chr>                <dbl> <fct>
#    1 SID20189917 IDEPT6347               19 freshman
#    2 SID20189921 IDEPT7005               18 freshman
#    3 SID20189926 IDEPT1836               19 freshman
#    4 SID20189949 IDEPT4938               18 freshman
#    5 SID20189982 IDEPT6347               19 freshman
#    # . with 1 more row
#    ```
#
## Do not modify this line!

s_admission_new <- s_admission %>% 
  mutate(age = floor((DOB %--% today()) / dyears(1)),
         school_year = factor(DOA)%>%
           fct_collapse(graduate = c("2013-07-01","2014-07-01"))%>%
           fct_recode("senior" = "2015-07-01",
                      "junior" = "2016-07-01",
                      "sophomore" = "2017-07-01",
                      "freshman" = "2018-07-01"))%>%
  dplyr::select(Student_ID, Department_Admission, age, school_year)

print(s_admission_new, n = 5)

# 4. From `s_performance`, extract a tibble `s_performance_new` with columns
#    `Student_ID`, `mean_score`, `min_score` and `max_score`. `mean_score`,
#    `min_score` and `max_score` are aggregated across semesters and papers.
#    To do this, you can use:
#       - `group_by()` to group the data by `Student_ID`.
#       - `summarize()` to calculate the mean, minimum and maximum of `Marks`.
#
#    To check your answer:
#
#    The output of `print(s_performance_new, n = 5)` is
#
#    ```
#    # A tibble: 3,819 x 4
#      Student_ID  mean_score min_score max_score
#      <chr>            <dbl>     <dbl>     <dbl>
#    1 SID20131143       71.7        22       100
#    2 SID20131151       72.6        40       100
#    3 SID20131171       70.9        20        99
#    4 SID20131176       70.9        42       100
#    5 SID20131177       70.3        29       100
#    # . with 3,814 more rows
#    ```
#
## Do not modify this line!

s_performance_new <- s_performance%>%
  group_by(Student_ID)%>%
  summarize(mean_score = mean(Marks),
            min_score = min(Marks),
            max_score = max(Marks))

print(s_performance_new, n = 5)


# 5. From `department`, extract a tibble `department_engie` with columns
#    `Department_ID` and `Department_Name`, and the rows are those where
#    `Department_Name` has a match with the string `"Engineering"` (case insensitive).
#    To do this, you can use:
#      - `filter()` to filter `Department_Name` for the Engineering School
#        with `str_detect()` to match the string `"Engineering"`, either with
#        a regexp and the alternation `"|"`, or with `fixed()` and the
#        `ignore_case` argument,
#      - `dplyr::select()` to select the desired columns.
#
#    To check your answer:
#
#    The output of `print(department_engie, n = 5)` is
#
#    ```
#    # A tibble: 17 x 2
#      Department_ID Department_Name
#      <chr>         <chr>
#    1 IDEPT4670     Aerospace Engineering
#    2 IDEPT5528     Biosciences and Bioengineering
#    3 IDEPT3115     Chemical Engineering
#    4 IDEPT4938     Civil Engineering
#    5 IDEPT1423     Computer Science & Engineering
#    # . with 12 more rows
#    ```
#
## Do not modify this line!

department_engie <- department %>% 
  filter(str_detect(Department_Name,"Engineering|engineering"))%>%
  dplyr::select(Department_ID, Department_Name)

print(department_engie, n = 5)



# 6. From `employee_new`, extract a tibble `employee_engie` by inner-joining
#    `department_engie` and transforming `Department_Name` into a factor with
#    levels ordered by frequency.
#    Hint: you can use `fct_infreq()`.
#    Note that the inner-join is used because there is no employee record
#    for three engineering departments. Hence, another join would create NAs.
#
#    To check your answer:
#
#    The output of `print(employee_engie, n = 5)` is
#
#    ```
#    # A tibble: 422 x 6
#      Employee_ID Department_ID   age seniority seniority_level
#      <chr>       <chr>         <dbl>     <dbl> <fct>
#    1 IU196557    IDEPT4938        37        10 junior
#    2 IU449901    IDEPT2357        34        10 junior
#    3 IU206427    IDEPT4670        48        11 senior
#    4 IU572796    IDEPT1142        42        12 senior
#    5 IU393717    IDEPT1825        47        10 junior
#    # . with 417 more rows, and 1 more variable: Department_Name <fct>
#    ```
#
#    The output of `print(employee_engie$Department_Name[1:2], max.levels = 2)` is
#
#    ```
#    [1] Civil Engineering              Energy Science and Engineering
#    14 Levels: Aerospace Engineering ... Centre of Studies in Resources Engineering (CSRE)
#    ```
#
## Do not modify this line!

employee_engie <- employee_new %>%
  inner_join(department_engie)%>%
  mutate(Department_Name = Department_Name%>%
           fct_infreq())

print(employee_engie, n = 5)


# 7. One important aspect of faculty make-up is seniority.
#    Draw horizontal stacked bar charts for `Department_Name` to visualize the
#    distribution of `seniority_level` for each department of the Engineering
#    school
#    To do this, use `employee_engie` and:
#      - `ggplot` to initialize the plot,
#      - `geom_bar()` to get the barplot,
#      - `coord_flip()` to flip the axes,
#      - `labs()` to set the
#        - title as
#
#         ```
#         str_wrap("Most departments have more senior professors
#                  than juniors", width = 40)
#         ```
#
#        - subtitle as `"Exceptions are CASDE and Chemical Engineering"`,
#        - x-axis as `"Department's name"`,
#        - y-axis as `"Number of professors"`,
#        - fill as `"Seniority level"`.
#    Store the plot into a `ggplot` object `g1`.
#
## Do not modify this line!

g1 <- employee_engie %>% 
  ggplot(aes(x = Department_Name,fill = seniority_level))+
  geom_bar()+
  coord_flip()+
  labs(title = str_wrap("Most departments have more senior professors
        than juniors", width = 40),
       subtitle = "Exceptions are CASDE and Chemical Engineering",
       x = "Department's name",
       y = "Number of professors",
       fill = "Seniority level")




# 8. Inner-join the tibbles `s_admission_new`, `s_performance_new` and
#    `department_engie` to create a new tibble `student_engie`, with
#    the `school_year` column transformed into a factor with levels ordered
#    by median `mean_score`.
#    To do this, you can use:
#      - `inner_join()` with the key `"Student_ID"` to join
#        `s_admission_new` with `s_performance_new`.
#      - `inner_join()` with the key `"Department_Admission"` in the left table
#        and `"Department_ID"` in the right table to further join
#        `department_engie`,
#      - `mutate()` and `fct_reorder()` to transform and reorder `school_year`
#        appropriately.
#
#    To check your answer:
#
#    The output of `print(student_engie, n = 5)` is
#
#    ```
#    # A tibble: 1,740 x 8
#      Student_ID Department_Admi.   age school_year mean_score min_score
#      <chr>      <chr>            <dbl> <fct>            <dbl>     <dbl>
#    1 SID201311. IDEPT7783           24 graduate          71.7        22
#    2 SID201311. IDEPT8473           24 graduate          70.9        42
#    3 SID201311. IDEPT5528           24 graduate          70.3        29
#    4 SID201311. IDEPT8473           24 graduate          64.3        40
#    5 SID201311. IDEPT3115           24 graduate          69.8        21
#    # . with 1,735 more rows, and 2 more variables: max_score <dbl>,
#    #   Department_Name <chr>
#    ```
#
#    The output of `print(student_engie$school_year[1:2], max.levels = 2)` is
#
#    ```
#    [1] graduate graduate
#    5 Levels: senior ... graduate
#    ```
#
## Do not modify this line!

student_engie<- inner_join(s_admission_new, s_performance_new, by = "Student_ID")%>%
  inner_join(department_engie, by = c("Department_Admission"="Department_ID"))%>%
  mutate(school_year = fct_reorder(school_year, mean_score, median))

print(student_engie, n = 5)


# 9. Using `student_engie`, let's draw an horizontal boxplots for
#    `mean_score` against `school_year`.
#    To do this, use `student_engie` and:
#      - `ggplot` to initialize the plot,
#      - `geom_boxplot()` to get the barplot,
#      - `coord_flip()` to flip the axes,
#      - `labs()` to set the
#        - title as `"Score distribution is similar across years"`,
#        - x-axis as `"Class standing"`,
#        - y-axis as `"Mean paper score"`.
#    Store the plot into a `ggplot` object `g2`.
## Do not modify this line!

g2 <- student_engie %>% ggplot(aes(y = mean_score, x = school_year))+
  geom_boxplot()+
  coord_flip()+
  labs(title = "Score distribution is similar across years",
       x = "Class standing",
       y = "Mean paper score")

# HW7: relational4
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse` and `lubridates` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_csv` to load
#      - `/course/data/movies.csv` and assign it to a tibble `movie`,
#      - `/course/data/ratings.csv` and assign it to a tibble `ratings`, with an
#        additional`date` column created from `timestamp` using `mutate()` and
#        `as_datetime()`.
#
#    To check your answer:
#
#    The output of `print(movies, n = 5)` is
#
#    ```
#    # A tibble: 27,254 x 3
#      movieId title                       genres
#        <dbl> <chr>                       <chr>
#    1       1 Toy Story (1995)            Adventure|Animation|Children|Co.
#    2       2 Jumanji (1995)              Adventure|Children|Fantasy
#    3       3 Grumpier Old Men (1995)     Comedy|Romance
#    4       4 Waiting to Exhale (1995)    Comedy|Drama|Romance
#    5       5 Father of the Bride Part I. Comedy
#    # . with 2.725e+04 more rows
#    ```
#
#    The output of `print(ratings, n = 5)` is
#
#    ```
#    # A tibble: 50,000 x 5
#      userId movieId rating  timestamp date
#       <dbl>   <dbl>  <dbl>      <dbl> <dttm>
#    1  36660     280    4    834049053 1996-06-06 08:17:33
#    2  91867    2657    5    971578971 2000-10-15 03:02:51
#    3 107259    2566    2    944169497 1999-12-02 21:18:17
#    4 129338    4161    2.5 1137405482 2006-01-16 09:58:02
#    5 128693    2355    4    984620012 2001-03-15 01:33:32
#    # . with 5e+04 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
theme_set(theme_light())
movies <- read_csv("/course/data/movies.csv")
ratings <- read_csv("/course/data/ratings.csv")
ratings <- ratings %>% mutate(date = as_datetime(timestamp))
print(ratings, n = 5)


# 2. From `ratings`, extract a new tibble `ratings_per_year` by adding a new
#    column `year`, corresponding to the year of the observation, and then
#    calculating, for each `year`:
#      - `mean`, i.e. the mean rating,
#      - `n`, the number of ratings,
#      - `sd`, the standard deviation of the ratings,
#      - `se`,  the standard error of the number of ratings, computed as
#        `1.96 * sd / sqrt(n)`.
#
#    To check your answer:
#
#    The output of `print(ratings_per_year, n = 5)` is
#
#    ```
#    # A tibble: 20 x 5
#       year  mean     n    sd     se
#      <dbl> <dbl> <int> <dbl>  <dbl>
#    1  1996  3.56  4089 0.985 0.0302
#    2  1997  3.56  1750 1.01  0.0474
#    3  1998  3.49   753 1.17  0.0833
#    4  1999  3.59  2950 1.13  0.0408
#    5  2000  3.59  4894 1.12  0.0313
#    # . with 15 more rows
#    ```
#
## Do not modify this line!

ratings_per_year <- ratings %>% mutate(year = year(date))%>%
  group_by(year)%>%
  summarize(mean = mean(rating),
            n = n(),
            sd = sd(rating),
            se = 1.96 * sd / sqrt(n))

print(ratings_per_year, n = 5)




# 3. Using `ratings_per_year`, draw a scatterplot of the `mean` against `year`,
#    with error bars computed with `mean - se` and `mean + se`.
#    To do this, use `ratings_per_year` and:
#      - `ggplot` to initialize the plot,
#      - `geom_point()` to get the scatterplot,
#      - `geom_errorbar()` to add the error bars,
#      - `labs()` to set the
#        - title as `"2004 and 2005 have the lowest average ratings"`,
#        - subtitle as `"2014 has the highest average ratings"`,
#        - x-axis as `"Year"`,
#        - y-axis as `"Average rating (with standard errors)"`.
#    Store the plot into a `ggplot` object `g1`.
#
## Do not modify this line!


g1 <- ratings_per_year %>% ggplot(aes(x = year, y = mean))+
  geom_point()+
  geom_errorbar(aes(ymin = mean-se, ymax = mean+se))+
  labs(title = "2004 and 2005 have the lowest average ratings",
       subtitle = "2014 has the highest average ratings",
       x = "Year",
       y = "2014 has the highest average ratings")



# 4. From `movies`, extract a new tibble `movies_new` by
#      - adding a new variable `year`, corresponding to an extraction of the
#        year from the `title` column and its convertion into a numeric,
#        which you can do using `mutate()`, `str_sub()` and `as.numeric()`,
#      - use `separate_rows()` to separate the `genres` column into multiple
#        rows (pay attention to the `sep` argument).
#
#    Note that the `title` column format is relatively clean here. What if
#    we have 4-digit years and 2-digit years mix
#    (e.g. 1995, 96, 02, 2005, etc.)?
#    The method with `str_sub()` wouldn't work, as one couldn't use a fixed
#    `start` and `end`. What could we do in this case?
#    Method 1: locate the indices of `(` and `)` for each title and then use
#    `str_sub()`.
#    Method 2: use regular expression to do that in one step.
#    For instance, you can combine `str_replace()` with
#    `pattern = ".+\\(([0-9]+)\\)"`, `replacement = "\\1"` in order to
#    extract the year.
#    Here, `str_replace()` matches to argument pattern within each element of
#    a character vector, and then replace the designed pattern.
#    The pattern is `".+\\(([0-9]+)\\)"`, where
#      - `.` means the string starts with a character and `.+` means there are
#        one or more characters,
#      - `\\(` and `\\)` means there really exist parenthese with `\\` being
#        the syntax for escaping,
#      - `([0-9]+)` means there exists a string of characters that can be
#        converted to numeric.
#    The replacement is `\\1`, where `\\1` means that we only keep the
#    characters that can be converted into numeric.
#    If interested, please go to the following website for more details:
#    https://stringr.tidyverse.org/articles/regular-expressions.html.
#
#    To check your answer:
#
#    The output of `print(movies_new, n = 5)` is
#
#    ```
#    # A tibble: 54,374 x 4
#      movieId title            genres     year
#        <dbl> <chr>            <chr>     <dbl>
#    1       1 Toy Story (1995) Adventure  1995
#    2       1 Toy Story (1995) Animation  1995
#    3       1 Toy Story (1995) Children   1995
#    4       1 Toy Story (1995) Comedy     1995
#    5       1 Toy Story (1995) Fantasy    1995
#    # . with 5.437e+04 more rows
#    ```
#
## Do not modify this line!

movies_new <- movies %>%
  mutate(year = as.numeric(str_sub(title, -5, -2)))%>%
  separate_rows(genres, sep = "\\|")

print(movies_new, n = 5)



# 5. From `movies_new`, extract a tibble `ratings_of_movies` by
#      - inner-joining `ratings`,
#      - removing the `movieId`, `userId` and `timestamp` columns after the
#        join,
#      - filtering-out the rows such that the `genres` is
#        `"(no genres listed)"`.
#    To do this, you can use `inner_join()`, `dplyr::select`, and `filter()`.
#
#    To check your answer:
#
#    The output of `print(ratings_of_movies, n = 5)` is
#
#    ```
#    # A tibble: 132,724 x 5
#      title            genres     year rating date
#      <chr>            <chr>     <dbl>  <dbl> <dttm>
#    1 Toy Story (1995) Adventure  1995    3.5 2005-03-17 20:22:12
#    2 Toy Story (1995) Adventure  1995    3   1999-07-06 18:41:32
#    3 Toy Story (1995) Adventure  1995    3   2009-08-18 18:31:29
#    4 Toy Story (1995) Adventure  1995    4.5 2009-08-20 06:36:02
#    5 Toy Story (1995) Adventure  1995    5   1997-01-26 14:23:23
#    # . with 1.327e+05 more rows
#    ```
#
## Do not modify this line!

ratings_of_movies <- movies_new %>%
  inner_join(ratings) %>%
  dplyr::select(-movieId, -userId, -timestamp)%>%
  filter(genres != "(no genres listed)")

print(ratings_of_movies, n = 5)



# 6. From `ratings_of_movies`, extract a tibble `ratings_by_genres` by
#    computing `average_rating` and `number_of_ratings`, respectively
#    the average rating and number of ratings per genre.
#    To do this, you can use `group_by()`, `summarize()`.
#
#    To check your answer:
#
#    The output of `print(ratings_by_genres, n = 5)` is
#
#    ```
#    # A tibble: 19 x 3
#      genres    average_rating number_of_ratings
#      <chr>              <dbl>             <int>
#    1 Action              3.43             13970
#    2 Adventure           3.49             10875
#    3 Animation           3.59              2807
#    4 Children            3.38              4133
#    5 Comedy              3.42             18701
#    # . with 14 more rows
#    ```
#
## Do not modify this line!

ratings_by_genres <- ratings_of_movies %>% 
  group_by(genres)%>%
  summarize(average_rating = mean(rating),
            number_of_ratings = n())

print(ratings_by_genres, n = 5)



# 7. Draw a smooth regression line (computed using the `"gam"` method) of
#    `average_rating` against `number_of_ratings`, and add a scatterplot of
#    the same data albeit colored by `genres`.
#    To do this, use `ratings_by_genres` and:
#      - `ggplot` to initialize the plot,
#      - `geom_smooth()` to get the smooth regression line with `method` set to
#        `"gam"`, and `color` set to `"black"`,
#      - `geom_point()` to get the scatterplot,
#      - `scale_x_log10()` to set the x-axis as logarithmic,
#      - `labs()` to set the
#        - title as
#
#          ```
#          str_wrap("When the number of ratings is over 5000,
#                   its average plateaus around 3.5")
#          ```
#
#        - x-axis as `"Number of ratings"`,
#        - y-axis as `"Average rating"`,
#      - `theme` to set the `legend.position` as `"bottom"`.
#    Store the plot into a `ggplot` object `g2`.
#
## Do not modify this line!

g2 <- ratings_by_genres %>% ggplot(aes(x = number_of_ratings, y = average_rating, color = genres))+
  geom_point()+
  geom_smooth(method = "gam", color = "black")+
  scale_x_log10()+
  labs(title = str_wrap("When the number of ratings is over 5000,
         its average plateaus around 3.5"),
       x = "Number of ratings",
       y = "Average rating")+
  theme(legend.position = "bottom")




# 8. From `ratings_of_movies`, extract a tibble `ratings_over_time` by
#    creating three columns:
#      - `interval`, a column with class `"interval"` defined as the inteval
#        of time between the rating and the film's release (you can assume
#        that the movie was released on January 1st of the year that you
#        extracted before),
#      - `years_passed`, the number of years in `interval` (i.e., obtained
#        simply by dividing by one duration year),
#      - `decade`, a factor with levels `(0,20]`, `(20,40]`, ..., `(100,120]`.
#    Then, reorder the columns as shown below, and filter-out the observations
#    such that `years_passed` is smaller than or equal to 80, and.
#    Hints:
#      - you can use `mutate()`, `dplyr::select`, and `filter`,
#      - to create `interval`, you can use `make_datetime()` to convert
#        the release year into a date and remembers that dates/datetimes can
#        be substracted to create intervals,
#      - to create `years_passed`, remember that intervals can be divided by
#        durations, so `dyears()` can help to compute the number of years that
#        have passedm
#      - to create `decade`, remember the `cut()` function.
#
#    To check your answer:
#
#    The output of `print(ratings_over_time, n = 5)` is
#
#    ```
#    # A tibble: 132,595 x 8
#      genres interval years_passed decade title  year rating
#      <chr>  <drtn>          <dbl> <fct>  <chr> <dbl>  <dbl>
#    1 Adven. 3728.84.        10.2  (0,20] Toy .  1995    3.5
#    2 Adven. 1647.77.         4.51 (0,20] Toy .  1995    3
#    3 Adven. 5343.77.        14.6  (0,20] Toy .  1995    3
#    4 Adven. 5345.27.        14.6  (0,20] Toy .  1995    4.5
#    5 Adven.  756.59.         2.07 (0,20] Toy .  1995    5
#    # . with 1.326e+05 more rows, and 1 more variable: date <dttm>
#    ```
#
## Do not modify this line!

ratings_over_time <- ratings_of_movies %>%
  mutate(interval= date - make_datetime(year),
         years_passed=interval/dyears(),
         decade = cut(years_passed, breaks = 20*(0:6))) %>%
  select(genres, interval, years_passed, decade,
         title, year, rating, date) %>%
  filter(years_passed <= 80)

print(ratings_over_time, n = 5)

# 9. Draw an horizontal linerange plot of `rating` against `genre`,
#    colored by `decade`.
#    To do this, use `ratings_over_time` and:
#      - `ggplot` to initialize the plot,
#      - `geom_linerange()` to get the linerange plot, and set the `stat`
#        as `"summary"`,
#      - `coord_flip()` to flip the axes,
#      - `labs()` to set the
#        - title as `"The average rating usually increases with time"`,
#        - subtitle as `"Exceptions are documentaries and animation movies"`,
#        - x-axis as `"Genre"`,
#        - y-axis as `"Average rating (and standard errors)"`,
#        - color as `"Years between release and rating"`,
#      - `theme` to set the `legend.position` as `"bottom"`.
#    Store the plot into a `ggplot` object `g3`.
#
## Do not modify this line!

g3 <- ratings_over_time %>% ggplot(aes(x = genres, y = rating, color = decade))+
  geom_linerange(stat = "summary")+
  coord_flip()+
  labs(title = "The average rating usually increases with time",
       subtitle = "Exceptions are documentaries and animation movies",
       x = "Genre",
       y = "Average rating (and standard errors)",
       color = "Years between release and rating")+
  theme(legend.position = "bottom")


# HW8: City Weather Prediction
#
# This exercise is based on historical hourly weather data 2012-2017 obtained from
# [Kaggle](https://www.kaggle.com/selfishgene/historical-hourly-weather-data).
# The dataset contains approximately 5 years of high temporal resolution
# data of temperature for 30 US and Canadian Cities, as well as 6 Israeli
# cities.
# The data is organized such that the rows represent the time axis, and the
# columns represent the different cities.
#
# In the whole exercise, do NOT use a `for`, `while`, or `repeat` loop!
#
# 1. Load the `tidyverse`, `lubridates`, `broom` and `modelr` packages and use
#    `theme_set(theme_light())` to set the theme for the rest of the exercise.
#    Then, use `read_csv` to load `/course/data/temperature_cities.csv` and assign it
#    to a tibble `temperature`.
#
#
#    To check your answer:
#
#    The output of `print(temperature, n = 5)` is
#
#    ```
#    # A tibble: 45,253 x 5
#      datetime            Vancouver Phoenix Miami  New York
#      <dttm>                  <dbl>   <dbl> <dbl>      <dbl>
#    1 2012-10-01 12:00:00       NA      NA    NA         NA
#    2 2012-10-01 13:00:00      285.    297.  300.       288.
#    3 2012-10-01 14:00:00      285.    297.  300.       288.
#    4 2012-10-01 15:00:00      285.    297.  300.       288.
#    5 2012-10-01 16:00:00      285.    297.  300.       288.
#    # . with 4.525e+04 more rows
#    ```
#
## Do not modify this line!

library(tidyverse)
library(lubridate)
library(broom)
library(modelr)
theme_set(theme_light())
temperature <- read_csv("/course/data/temperature_cities.csv")

# 2. From `temperature`, extract a tibble `temperature_full` with by gathering
#    the data corresponding to all cities. Furthermore, convert the
#    temperature from Kelving to Celsius, and use the `datetime` variable to
#    create the following columns:
#      - `yday`, a numeric variable corresponding to the day of the year,
#      - `hour`, a factor variable coresponding to the hour,
#      - `yearfrac`, a numeric variable corresponding to ratio between `yday`
#        and the total number of days in the year.
#    Finally, drop the rows containing NAs.
#    To do this, you can use :
#      - `pivot_longer()` to gather the data from the various cities,
#      - `mutate()` to convert `temperature` from Kelvin to Celsius
#        (assume that  Celsius = Kelvin - 273.15) as well as create the
#        `yday`, `hour` and `yearfrac` columns
#        (hint: it is straighforward to extract `yday` and `hour` by getting
#        the days/hours component of a date-time, and for `yearfrac`, you can
#        use `yday(make_date(year(datetime), 12, 31))` to calculate the total
#        number of days in the corresponding),
#      - `drop_na()` to drop `NA` values.
#
#    Then, filter the data corresponding to New York and assign it to
#    `temperature_ny` (you can use `filter()`).
#
#    To check your answer:
#
#    The output of `print(temperature_full, n = 5)` is
#
#    ```
#    # A tibble: 178,616 x 6
#      datetime            city      temperature  yday yearfrac hour
#      <dttm>              <chr>           <dbl> <dbl>    <dbl> <fct>
#    1 2012-10-01 13:00:00 Vancouver        11.5   275    0.751 13
#    2 2012-10-01 13:00:00 Phoenix          23.5   275    0.751 13
#    3 2012-10-01 13:00:00 Miami            26.6   275    0.751 13
#    4 2012-10-01 13:00:00 New York         15.1   275    0.751 13
#    5 2012-10-01 14:00:00 Vancouver        11.5   275    0.751 14
#    # . with 1.786e+05 more rows
#    ```
#
#    The output of `print(temperature_ny, n = 5)` is
#
#    ```
#    # A tibble: 44,460 x 6
#      datetime            city     temperature  yday yearfrac hour
#      <dttm>              <chr>          <dbl> <dbl>    <dbl> <fct>
#    1 2012-10-01 13:00:00 New York        15.1   275    0.751 13
#    2 2012-10-01 14:00:00 New York        15.1   275    0.751 14
#    3 2012-10-01 15:00:00 New York        15.2   275    0.751 15
#    4 2012-10-01 16:00:00 New York        15.3   275    0.751 16
#    5 2012-10-01 17:00:00 New York        15.3   275    0.751 17
#    # . with 4.446e+04 more rows
#    ```
#
## Do not modify this line!

temperature_full <- temperature %>%
  pivot_longer(c("Vancouver", "Phoenix", "Miami", "New York"),
               names_to = "city",
               values_to = "temperature") %>%
  mutate(temperature = temperature - 273.15,
         yday = yday(datetime),
         yearfrac = yday/yday(make_date(year(datetime), 12, 31)),
         hour = factor(hour(datetime)))%>%
  drop_na()

temperature_ny <- temperature_full %>% filter(city == "New York")

print(temperature_full, n = 5)
print(temperature_ny, n = 5)


# 3. Produce a lineplot of the evolution of the hourly temperature in New York
#    from 2012 to 2018 (i.e., `temperature` against the `datetime`).
#    To do this, use `temperature_ny` and:
#      - `geom_line()` to get the lineplot,
#      - `labs()` to set the
#        - title as `"Hourly temperature in New York from 2012 to 2018"`,
#        - x-axis as `"Date"`,
#        - y-axis as `"Temperature (C)"`.
#    Store the plot into a `ggplot` object `ny_temp`.
#
## Do not modify this line!

ny_temp <- temperature_ny %>% ggplot(aes(x = datetime, y = temperature))+
  geom_line()+
  labs(title = "Hourly temperature in New York from 2012 to 2018",
       x = "Date",
       y = "Temperature (C)")



# 4. Let's try to fit the temperature using a polynomial model capturing the
#    effect of the day of the year.
#    Using `lm()` and `temperature_ny`, create a linear model called `model0`
#    using the following formula: `temperature ~ poly(yday, 5)`.
#    Then, from `temperature_ny`, extract a new tibble `temperature_ny_model0`
#    by adding two columns `pred` and `resid` containing respectively the
#    predictions and residuals from `model0`,
#    Hint: you can use `add_predictions()` and `add_residuals()`.
#
#    To check your answer:
#
#    The output of `print(broom::tidy(model0))` is
#
#    ```
#    # A tibble: 6 x 5
#      term           estimate std.error statistic  p.value
#      <chr>             <dbl>     <dbl>     <dbl>    <dbl>
#    1 (Intercept)        12.3    0.0243     503.  0.
#    2 poly(yday, 5)1    669.     5.13       130.  0.
#    3 poly(yday, 5)2  -1612.     5.13      -314.  0.
#    4 poly(yday, 5)3   -388.     5.13       -75.6 0.
#    5 poly(yday, 5)4    522.     5.13       102.  0.
#    6 poly(yday, 5)5     57.8    5.13        11.3 2.12e-29
#    ```
#
#    The output of `print(temperature_ny_model0, n = 5)` is
#
#    ```
#    # A tibble: 44,460 x 8
#      datetime            city  temperature  yday yearfrac hour   pred
#      <dttm>              <chr>       <dbl> <dbl>    <dbl> <fct> <dbl>
#    1 2012-10-01 13:00:00 New .        15.1   275    0.751 13     17.2
#    2 2012-10-01 14:00:00 New .        15.1   275    0.751 14     17.2
#    3 2012-10-01 15:00:00 New .        15.2   275    0.751 15     17.2
#    4 2012-10-01 16:00:00 New .        15.3   275    0.751 16     17.2
#    5 2012-10-01 17:00:00 New .        15.3   275    0.751 17     17.2
#    # . with 4.446e+04 more rows, and 1 more variable: resid <dbl>
#    ```
#
## Do not modify this line!

model0 <- lm(temperature ~ poly(yday, 5), temperature_ny)
temperature_ny_model0 <- temperature_ny %>% 
  add_predictions(model0, "pred")%>%
  add_residuals(model0, "resid")

print(broom::tidy(model0))
print(temperature_ny_model0, n = 5)



# 5. To visualize the model's predictions, produce a scatterplot of
#    `temperature` against `datetime`, and add a lineplot of `pred` (in red).
#    To do this, use `temperature_ny_model0` and:
#      - `geom_point()` with `size` at 0.2 to shrink the points and
#        `alpha` at 0.2,
#      - `geom_line()` with `aes(y=pred)` to draw the predicted data points,
#        setting `size` to 1 and `col` to `"red"`,
#      - `labs()` to set the
#        - title as `"The seasonality is captured"`,
#        - subtitle as `"But polynomials in red miss the cyclicality (boundary effect)"`,
#        - x-axis as `"Date"`,
#        - y-axis as `"Temperature (C)"`.
#    Store the plot into a `ggplot` object `ny_temp_fitted`.
#
## Do not modify this line!

ny_temp_fitted<-temperature_ny_model0 %>% ggplot(aes(x = datetime, y = temperature))+
  geom_point(size = 0.2, alpha = 0.2)+
  geom_line(aes(y = pred),size = 1, col = "red")+
  labs(title = "The seasonality is captured",
       subtitle = "But polynomials in red miss the cyclicality (boundary effect)",
       x = "Date",
       y = "Temperature (C)")



# 6. We now want to be able to capture the cyclicality properly by
#    fitting a linear model of `temperature` against a transformation of `yday`
#    taking it into account.
#    First, create the following function :
#    `cyclic <- function(yearfrac) mgcv::cSplineDes(yearfrac, seq(0, 1, 0.2))[, -5]`
#    Then, repeat the steps from part 4 by using `cyclic(yearfrac)` instead
#    of `poly(yday, 5)` in the model formula to create a new model called
#    `model1`, and a new tibble called `temperature_ny_model1` adding its
#    residuals and predictions to `temperature_ny`.
#
#    To check your answer:
#
#    The output of `print(broom::tidy(model1))` is
#
#    ```
#    # A tibble: 5 x 5
#      term              estimate std.error statistic   p.value
#      <chr>                <dbl>     <dbl>     <dbl>     <dbl>
#    1 (Intercept)          27.2      0.116     235.  0.
#    2 cyclic(yearfrac)1   -12.7      0.202     -63.0 0.
#    3 cyclic(yearfrac)2   -29.3      0.150    -196.  0.
#    4 cyclic(yearfrac)3   -27.4      0.150    -183.  0.
#    5 cyclic(yearfrac)4    -5.68     0.205     -27.7 2.07e-167
#    ```
#
#    The output of `print(temperature_ny_model1, n = 5)` is
#
#    ```
#    # A tibble: 44,460 x 8
#      datetime            city  temperature  yday yearfrac hour   pred
#      <dttm>              <chr>       <dbl> <dbl>    <dbl> <fct> <dbl>
#    1 2012-10-01 13:00:00 New .        15.1   275    0.751 13     17.3
#    2 2012-10-01 14:00:00 New .        15.1   275    0.751 14     17.3
#    3 2012-10-01 15:00:00 New .        15.2   275    0.751 15     17.3
#    4 2012-10-01 16:00:00 New .        15.3   275    0.751 16     17.3
#    5 2012-10-01 17:00:00 New .        15.3   275    0.751 17     17.3
#    # . with 4.446e+04 more rows, and 1 more variable: resid <dbl>
#    ```
#
## Do not modify this line!

cyclic <- function(yearfrac) mgcv::cSplineDes(yearfrac, seq(0, 1, 0.2))[, -5]
model1 <- lm(temperature ~ cyclic(yearfrac), temperature_ny)
temperature_ny_model1 <- temperature_ny %>% 
  add_predictions(model1, "pred")%>%
  add_residuals(model1, "resid")

print(broom::tidy(model1))
print(temperature_ny_model1, n = 5)


# 7. Now, let's compare the predictions of `model0` and `model1`.
#    To do that, start from `ny_temp_fitted` and use
#       - `geom_line()` with  `aes(y = pred)`, `data` as
#         `temperature_ny_model1`, and  `color` as `"green"` and `size` as 1,
#       - `labs()` to set `subtitle` to
#
#       ```
#       str_wrap("Polynomials in red miss the cyclicality,
#                but cyclic splines in green capture it properly",
#                width = 40)
#       ```
#
#    Store the plot into a `ggplot` object `ny_temp_fitted2`.
#
## Do not modify this line!

ny_temp_fitted2 <- ny_temp_fitted+
  geom_line(aes(y = temperature_ny_model1$pred),size = 1, color = "green")+
  labs(subtitle = str_wrap("Polynomials in red miss the cyclicality,
       but cyclic splines in green capture it properly",
                           width = 40))





# 8. Use a boxplot to visualize the residuals (`resid`) against the hour of
#    the day (`hour`).
#    To do this, use `temperature_ny_model1` and:
#      - `geom_boxplot()` to get the boxplot,
#      - `labs()` to set the
#        - title as `"There is a time-of-day effect in the residuals"`,
#        - x-axis as `"Hour"`,
#        - y-axis as `"Residuals (C)"`.
#    Store the plot into a `ggplot` object `ny_temp_residual`.
#
## Do not modify this line!

ny_temp_residual <- temperature_ny_model1 %>% ggplot(aes(x = hour, y = resid))+
  geom_boxplot()+
  labs(title = "There is a time-of-day effect in the residuals",
       x = "Hour",
       y = "Residuals (C)")



# 9. We now want to be able to model the intradaily variations of the temperature
#    by adding `hour` as predictor in the regression.
#    Using `lm()` and `temperature_ny`, create a linear model called `model2`
#    using the following formula: `temperature ~ cyclic(yfrac) + hour`.
#    Then, use `temperature_ny` again to extract a new tibble
#    `temperature_ny_model2` by combining the predictions and residuals
#    of both `model1` and `model2`:
#      - use `gather_predictions()` and `gather_residuals()` to get the
#        predictions and residuals respectively,
#      - combine the two tibbles using `left_join()`,
#      - use `mutate()` and `factor()` to convert the `model` column into a
#        factor with `levels` set to `c("model1", "model2")`.
#    To check your answer:
#
#    The output of `print(broom::tidy(model2))` is
#
#    ```
#    # A tibble: 28 x 5
#       term              estimate std.error statistic   p.value
#       <chr>                <dbl>     <dbl>     <dbl>     <dbl>
#     1 (Intercept)         28.3       0.147    192.   0.
#     2 cyclic(yearfrac)1  -12.7       0.180    -70.6  0.
#     3 cyclic(yearfrac)2  -29.3       0.134   -219.   0.
#     4 cyclic(yearfrac)3  -27.4       0.134   -205.   0.
#     5 cyclic(yearfrac)4   -5.68      0.183    -31.0  5.96e-209
#     6 hour1               -0.773     0.151     -5.10 3.37e-  7
#     7 hour2               -1.50      0.151     -9.94 3.08e- 23
#     8 hour3               -1.98      0.151    -13.1  5.15e- 39
#     9 hour4               -2.42      0.151    -16.0  1.85e- 57
#    10 hour5               -2.85      0.151    -18.8  7.31e- 79
#    # . with 18 more rows
#    ```
#
#    The output of `print(temperature_ny_model2, n = 5)` is
#
#    ```
#    # A tibble: 88,920 x 9
#      model datetime            city  temperature  yday yearfrac hour
#      <fct> <dttm>              <chr>       <dbl> <dbl>    <dbl> <fct>
#    1 mode. 2012-10-01 13:00:00 New .        15.1   275    0.751 13
#    2 mode. 2012-10-01 14:00:00 New .        15.1   275    0.751 14
#    3 mode. 2012-10-01 15:00:00 New .        15.2   275    0.751 15
#    4 mode. 2012-10-01 16:00:00 New .        15.3   275    0.751 16
#    5 mode. 2012-10-01 17:00:00 New .        15.3   275    0.751 17
#    # . with 8.892e+04 more rows, and 2 more variables: pred <dbl>,
#    #   resid <dbl>
#    ```
#
## Do not modify this line!

model2 <- lm(temperature ~ cyclic(yearfrac) + hour, temperature_ny)
temperature_ny_model2 <- temperature_ny %>%
  gather_predictions(model1, model2)%>%
  left_join(temperature_ny %>% gather_residuals(model1, model2))%>%
  mutate(model = factor(model, levels = c("model1", "model2")))

print(broom::tidy(model2))
print(temperature_ny_model2, n = 5)


# 10. To compare `model1` and `model2`, produce a boxplot similar as
#     the one from part 8, but facetted by `model`.
#     To do this, use `temperature_ny_model2` and:
#       - `geom_boxplot()` to get the boxplot,
#       - `facet_wrap()` to facet by `model`,
#       - `labs()` to set the
#         - title as `"Including the hour captures the time-of-day effect"`,
#         - x-axis as `"Hour"`,
#         - y-axis as `"Residuals (C)"`.
#     Store the plot into a `ggplot` object `ny_temp_residual2`.
#
## Do not modify this line!

ny_temp_residual2<- temperature_ny_model2 %>% ggplot(aes(x = hour, y = resid))+
  geom_boxplot()+
  facet_wrap(~model)+
  labs(title = "Including the hour captures the time-of-day effect",
       x = "Hour",
       y = "Residuals (C)")




# 11. Use `anova()` to compare the variance of `model1` and `model2` and save
#     the result to `compare_models`.
#
#    To check your answer:
#
#    The output of `print(broom::tidy(compare_models))` is
#
#    ```
#    # A tibble: 2 x 6
#      res.df      rss    df   sumsq statistic p.value
#       <dbl>    <dbl> <dbl>   <dbl>     <dbl>   <dbl>
#    1  44455 1184509.    NA     NA        NA       NA
#    2  44432  944015.    23 240495.      492.       0
#    ```
#
## Do not modify this line!

compare_models <- anova(model1, model2)
print(broom::tidy(compare_models))




# 12. Now, let's choose `model2` as our "best" model and apply a similar
#     approach to all cities in the initial dataset.
#     Create a function `my_model` that:
#       - takes a data frame `df` as argument,
#       - returns a fitted model using `lm()` with the same formula as for
#         `model2`, namely `temperature ~ cyclic(yfrac) + hour`,
#         but with an arbitrary dataset (i.e., set `data = df`).
#    Then, from `temperature_full`, extract a new tibble `by_city` that
#    contains the fitted model for each city by using:
#      - `group_by()` and `nest()` to obtained a dataset nested by city,
#      - `mutate()`, `map()` and `my_model()` to fit the model to each city.
#
#    To check your answer:
#
#    The output of `my_model(temperature_ny)` is `model2`.
#
#    The output of `print(by_city, n = 5)` is
#
#    ```
#    # A tibble: 4 x 3
#    # Groups:   city [4]
#      city      data                  model
#      <chr>     <list>                <list>
#    1 Vancouver <tibble [44,458 × 5]> <lm>
#    2 Phoenix   <tibble [45,250 × 5]> <lm>
#    3 Miami     <tibble [44,448 × 5]> <lm>
#    4 New York  <tibble [44,460 × 5]> <lm>
#    ```
#
#
## Do not modify this line!

my_model <- function(df){
  lm(temperature ~ cyclic(yearfrac) + hour, df)
}

by_city <- temperature_full %>% group_by(city)%>%
  nest()%>%
  mutate(model = map(data, my_model))

print(by_city, n = 5)


# 13. From `by_city`, extract a new tibble `by_city_stats` by containing
#     measures of fit quality/complexity for your models obtained using
#     `broom::glance()`. Arrange the cities by values of `adj.r.squared`.
#     To do that, you can use:
#       - `mutate()`, `map()` and `glance()` to extract the summary statistics,
#       - `dplyr::select()` to remove the columns `data` and `model`,
#       - `unnest()` to unnest the summary statistics for each city,
#       - `arrange()` the order the records by `adj.r.squared`.
#
#    To check your answer:
#
#    The output of `print(by_city_stats, n = 5)` is
#
#    ```
#    # A tibble: 4 x 12
#    # Groups:   city [4]
#      city  r.squared adj.r.squared sigma statistic p.value    df  logLik
#      <chr>     <dbl>         <dbl> <dbl>     <dbl>   <dbl> <int>   <dbl>
#    1 Miami     0.611         0.611  2.61     2588.       0    28 -1.06e5
#    2 New .     0.797         0.797  4.61     6451.       0    28 -1.31e5
#    3 Vanc.     0.798         0.798  2.99     6501.       0    28 -1.12e5
#    4 Phoe.     0.848         0.848  3.87     9337.       0    28 -1.25e5
#    # . with 4 more variables: AIC <dbl>, BIC <dbl>, deviance <dbl>,
#    #   df.residual <int>
#    ```
#
## Do not modify this line!

by_city_stats <- by_city %>%
  mutate(glance = map(model, broom::glance))%>%
  dplyr::select(-c(data, model)) %>%
  unnest(glance)%>%
  arrange(adj.r.squared)

print(by_city_stats, n = 5)



# 14. Now, let's look at hourly model predictions in each of the four seasons.
#     To do that, generate a tibble `test_df`, consisting of all the
#     combinations of
#       - `yearfrac` ranging from 0 to 0.75 with interval 0.25,
#       - all levels of `hour`.
#     To do that, you can use `crossing` to get the combinations, with
#       - `yearfrac` as `seq(0, 0.75, 0.25)`.
#       - `hour` using `pull(hour)` on `temperature_full` and then
#         `unique()` to select unique hours.
#
#    To check your answer:
#
#    The output of `print(test_df, n = 5)` is
#
#    ```
#    # A tibble: 96 x 2
#      yearfrac hour
#         <dbl> <fct>
#    1        0 0
#    2        0 1
#    3        0 2
#    4        0 3
#    5        0 4
#    # . with 91 more rows
#    ```
#
## Do not modify this line!

test_df <- crossing(yearfrac = seq(0, 0.75, 0.25),
                    hour = pull(temperature_full, -1))%>%
  unique()

print(test_df, n = 5)



# 15. Using `test_df` and `by_city`, extract a new tibble `by_city_pred`
#     containing the predictions for each city.
#     Furthermore, convert `yearfrac` into a factor with levels being
#     `seq(0, 0.75, 0.25)` and the corresponding labels being
#     `c("Winter", "Spring", "Summer", "Autumn")`.
#     Finally, convert `hour` back into a numeric (be careful with the factor
#     to numeric conversion!!!).
#     To do that, you can use:
#       - `mutate()`, `map()` and `add_predictions()` with `data = test_df` to
#         add the predictions,
#       - `dplyr::select()` to remove the columns `data` and `model`,
#       - `unnest()` to unnest the predictions for each city,
#       - `mutate()` again to convert `yearfrac` and `hour` as described above.
#
#    To check your answer:
#
#    The output of `print(by_city_pred, n = 5)` is
#
#    ```
#    # A tibble: 384 x 4
#    # Groups:   city [4]
#      city      yearfrac  hour  pred
#      <chr>     <fct>    <dbl> <dbl>
#    1 Vancouver Winter       0  5.47
#    2 Vancouver Winter       1  5.12
#    3 Vancouver Winter       2  4.56
#    4 Vancouver Winter       3  4.01
#    5 Vancouver Winter       4  3.26
#    # . with 379 more rows
#    ```
#
## Do not modify this line!

by_city_pred <- by_city %>% mutate(tmp = map(model, function(x) {add_predictions(test_df,x)}))%>%
  dplyr::select(-data, -model)%>%
  unnest(tmp)%>%
  mutate(yearfrac = factor(yearfrac, levels = seq(0, 0.75, 0.25), labels = c("Winter", "Spring", "Summer", "Autumn")),
         hour = as.numeric(hour)-1)

print(by_city_pred, n = 5)


# 16. Use `by_city_pred` to produce a lineplot of the `temperature` against
#     `hour`, colored by `yearfrac`, and facetted by `city`.
#     To do this, use `by_city_pred` and:
#       - `filter()` to only keep data for Miami, Phoenix and Vancouver,
#       - `geom_line()` to get the lineplot,
#       - `facet_wrap()` to facet by `model`,
#       - `labs()` to set the
#         - title as `"Our model can predict the temperature in different seasons!"`,
#         - x-axis as `"Hour"`,
#         - y-axis as `"Prediction (C)"`,
#         - color as `"Season"`.
#     Store the plot into a `ggplot` object `temperature_per_hour_season_plot`.
#
## Do not modify this line!

temperature_per_hour_season_plot <- by_city_pred %>% filter(city%in%c("Miami","Phoenix","Vancouver"))%>%
  ggplot(aes(x = hour, y = pred, color = yearfrac))+
  geom_line()+
  facet_wrap(~city)+
  labs(title = "Our model can predict the temperature in different seasons!",
       x = "Hour",
       y = "Prediction (C)",
       color = "Season")

