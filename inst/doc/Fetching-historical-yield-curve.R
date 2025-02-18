## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  out.width = "100%"
)

## ----packages-----------------------------------------------------------------
library(rb3)
library(ggplot2)
library(stringr)
library(dplyr)

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
df_yc <- try(yc_mget(
  first_date = Sys.Date() - 255 * 5,
  last_date = Sys.Date(),
  by = 255
), silent = TRUE)

if (is(df_yc, "try-error")) {
  load("yc_mget.rda")
}

## ----eval=FALSE---------------------------------------------------------------
# df_yc <- yc_mget(
#   first_date = Sys.Date() - 255 * 5,
#   last_date = Sys.Date(),
#   by = 255
# )

## ----fig.width=9, fig.height=6------------------------------------------------
p <- ggplot(
  df_yc,
  aes(
    x = forward_date,
    y = r_252,
    group = refdate,
    color = factor(refdate)
  )
) +
  geom_line(linewidth = 1) +
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

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
df_yc <- try(yc_ipca_mget(
  first_date = Sys.Date() - 255 * 5,
  last_date = Sys.Date(),
  by = 255
), silent = TRUE)

if (is(df_yc, "try-error")) {
  load("yc_ipca_mget.rda")
}

## ----eval=FALSE---------------------------------------------------------------
# df_yc <- yc_ipca_mget(
#   first_date = Sys.Date() - 255 * 5,
#   last_date = Sys.Date(),
#   by = 255
# )

## ----fig.width=9, fig.height=6------------------------------------------------
p <- ggplot(
  df_yc |> filter(biz_days > 21, biz_days < 1008),
  aes(
    x = forward_date,
    y = r_252,
    group = refdate,
    color = factor(refdate)
  )
) +
  geom_line(linewidth = 1) +
  labs(
    title = "DIxIPCA Yield Curves for Brazil",
    subtitle = "Built using interest rates future contracts",
    caption = str_glue("Data imported using rb3 at {Sys.Date()}"),
    x = "Forward Date",
    y = "Annual Interest Rate",
    color = "Reference Date"
  ) +
  theme_light() +
  scale_y_continuous(labels = scales::percent)

print(p)

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
df_yc <- try(yc_usd_mget(
  first_date = Sys.Date() - 255 * 5,
  last_date = Sys.Date(),
  by = 255
), silent = TRUE)

if (is(df_yc, "try-error")) {
  load("yc_usd_mget.rda")
}

## ----eval=FALSE---------------------------------------------------------------
# df_yc <- yc_usd_mget(
#   first_date = Sys.Date() - 255 * 5,
#   last_date = Sys.Date(),
#   by = 255
# )

## ----fig.width=9, fig.height=6------------------------------------------------
p <- ggplot(
  df_yc |> filter(biz_days > 21, biz_days < 2520),
  aes(
    x = forward_date,
    y = r_360,
    group = refdate,
    color = factor(refdate)
  )
) +
  geom_line(linewidth = 1) +
  labs(
    title = "Cupom Limpo (USD) Yield Curves for Brazil",
    subtitle = "Built using interest rates future contracts",
    caption = str_glue("Data imported using rb3 at {Sys.Date()}"),
    x = "Forward Date",
    y = "Annual Interest Rate",
    color = "Reference Date"
  ) +
  theme_light() +
  scale_y_continuous(labels = scales::percent)

print(p)

