## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(rb3)
library(ggplot2)
library(dplyr)
library(stringr)

## -----------------------------------------------------------------------------
indexes_get()

## -----------------------------------------------------------------------------
index_weights_get("IBOV")

## -----------------------------------------------------------------------------
index_weights_get("IBXX")

## -----------------------------------------------------------------------------
index_weights_get("SMLL")

## -----------------------------------------------------------------------------
index_comp_get("SMLL")

## -----------------------------------------------------------------------------
index_by_segment_get("IBOV")

## -----------------------------------------------------------------------------
index_name <- "IBOV"
index_data <- index_get(index_name, as.Date("2019-01-01"))
head(index_data)

## ----fig.width=9, fig.height=6------------------------------------------------
index_data |>
  ggplot(aes(x = refdate, y = value)) +
  geom_line() +
  labs(
    x = NULL, y = "Index",
    title = str_glue("{index_name} Historical Data"),
    caption = str_glue("Data imported using rb3")
  )

## ----fig.width=9, fig.height=6------------------------------------------------
index_data <- index_get(index_name, as.Date("1968-01-01"))
index_data |>
  ggplot(aes(x = refdate, y = value)) +
  geom_line() +
  scale_y_log10() +
  labs(
    x = NULL, y = "Index (log scale)",
    title = str_glue("{index_name} Historical Data - since 1968"),
    caption = str_glue("Data imported using rb3")
  )

## ----fig.width=9, fig.height=6------------------------------------------------
index_name <- "SMLL"
index_data <- index_get(index_name, as.Date("2010-01-01"))
index_data |>
  ggplot(aes(x = refdate, y = value)) +
  geom_line() +
  labs(
    x = NULL, y = "Index",
    title = str_glue("{index_name} Historical Data"),
    caption = str_glue("Data imported using rb3")
  )

## -----------------------------------------------------------------------------
indexes_last_update()

