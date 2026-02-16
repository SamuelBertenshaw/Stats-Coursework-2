library(dplyr)
library(ggplot2)

# Removing unnecessary columns within the original file
df <- read.csv("20251231-RTT-December-2025-full-extract.csv")
cols_to_remove <- c("Org\\.Code", "RTT\\.Part", "Treatment\\.Function\\.Code", 
                    "Commissioner\\.Parent\\.Name", "Commissioner\\.Org\\.Name")
df <- df[, !grepl(paste(cols_to_remove, collapse = "|"), names(df), ignore.case = TRUE)]
# Removing the "total" columns which originally came under each individual hospital's data
df <- df[df$Treatment.Function.Name != "Total", ]

# Convert weeks columns to numeric
df <- df %>% mutate(across(starts_with("Gt."), as.numeric))

# Some exploratory plots
ggplot(df, aes(x = Gt.01.To.02.Weeks.SUM.1, y = Treatment.Function.Name)) +
  geom_bar(stat = "identity") +
  labs(x = "Waiting time of 1-2 Weeks",
       y = "Treatment Function",
       title = "Waiting time of 1-2 Weeks by Treatment Function")

ggplot(df, aes(x = Gt.01.To.02.Weeks.SUM.1)) +
  geom_histogram(binwidth = 10) +
  xlim(0, 1000) +
  ylim(0, 500) +
  labs(x = "Waiting time of 1-2 Weeks",
       y = "Frequency",
       title = "Waiting time of 1-2 Weeks")
