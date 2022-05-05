## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(rb3)
library(ggplot2)
library(stringr)

df_yc <- yc_get(
  first_date = Sys.Date() - 255 * 5,
  last_date = Sys.Date(),
  by = 255
)

p <- ggplot(
  df_yc,
  aes(x = forward_date,
      y = r_252,
      group = refdate,
      color = factor(refdate))
  ) +
  geom_line() +
  labs(
    title = "Yield Curves for Brazil",
    subtitle = "Built using interest rates future contracts",
    caption = str_glue("Data imported using rb3 at {Sys.Date()}"),
    x = "Forward Date",
    y = "Annual Interest Rate",
    color = "Reference Date"
  ) +
  theme_light() +
  scale_y_continuous(labels = scales::percent)

print(p)

