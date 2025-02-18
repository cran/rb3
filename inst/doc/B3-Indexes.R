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

## ----indexes-get, eval=FALSE--------------------------------------------------
# indexes_get()

## ----indexes-get-load, message=FALSE, warning=FALSE, echo=FALSE---------------
indexes_get_ <- try(indexes_get(), silent = TRUE)
if (is(indexes_get_, "try-error")) {
  load("indexes_get.rda")
}
indexes_get_

## ----ibov-weights-get, eval=FALSE---------------------------------------------
# index_weights_get("IBOV")

## ----ibov-weights-get-load, message=FALSE, warning=FALSE, echo=FALSE----------
ibov_weights_get_ <- try(index_weights_get("IBOV"), silent = TRUE)
if (is(ibov_weights_get_, "try-error")) {
  load("indexes_data.rda")
}
ibov_weights_get_

## ----ibxx-weights-get, eval=FALSE---------------------------------------------
# index_weights_get("IBXX")

## ----ibxx-weights-get-load, message=FALSE, warning=FALSE, echo=FALSE----------
ibxx_weights_get_ <- try(index_weights_get("IBXX"), silent = TRUE)
if (is(ibxx_weights_get_, "try-error")) {
  load("indexes_data.rda")
}
ibxx_weights_get_

## ----smll-weights-get, eval=FALSE---------------------------------------------
# index_weights_get("SMLL")

## ----smll-weights-get-load, message=FALSE, warning=FALSE, echo=FALSE----------
smll_weights_get_ <- try(index_weights_get("SMLL"), silent = TRUE)
if (is(smll_weights_get_, "try-error")) {
  load("indexes_data.rda")
}
smll_weights_get_

## ----smll-comp-get, eval=FALSE------------------------------------------------
# index_comp_get("SMLL")

## ----smll-comp-get-load, message=FALSE, warning=FALSE, echo=FALSE-------------
smll_comp_get_ <- try(index_comp_get("SMLL"), silent = TRUE)
if (is(smll_comp_get_, "try-error")) {
  load("indexes_data.rda")
}
smll_comp_get_

## ----ibov-by-segment-get, eval=FALSE------------------------------------------
# index_by_segment_get("IBOV")

## ----ibov-by-segment-get-load, message=FALSE, warning=FALSE, echo=FALSE-------
ibov_by_segment_get_ <- try(index_by_segment_get("IBOV"), silent = TRUE)
if (is(ibov_by_segment_get_, "try-error")) {
  load("indexes_data.rda")
}
ibov_by_segment_get_

## ----ibov-get-2019-load, message=FALSE, warning=FALSE, echo=FALSE-------------
index_name <- "IBOV"
index_data <- try(index_get(index_name, as.Date("2019-01-01")), silent = TRUE)
if (is(index_data, "try-error")) {
  load("indexes_data.rda")
  index_data <- ibov_data_1
}

## ----ibov-get-2019, eval=FALSE------------------------------------------------
# index_name <- "IBOV"
# index_data <- index_get(index_name, as.Date("2019-01-01"))

## ----ibov-get-2019-echo-------------------------------------------------------
head(index_data)

## ----ibov-get-2019-plot, fig.width=7, fig.height=3----------------------------
index_data |>
  ggplot(aes(x = refdate, y = value)) +
  geom_line() +
  labs(
    x = NULL, y = "Index",
    title = str_glue("{index_name} Historical Data"),
    caption = str_glue("Data imported using rb3")
  )

## ----ibov-get-1968-load, message=FALSE, warning=FALSE, echo=FALSE-------------
index_name <- "IBOV"
index_data <- try(index_get(index_name, as.Date("1968-01-01")), silent = TRUE)
if (is(index_data, "try-error")) {
  load("indexes_data.rda")
  index_data <- ibov_data_2
}

## ----ibov-get-1968, eval=FALSE------------------------------------------------
# index_data <- index_get(index_name, as.Date("1968-01-01"))
# index_data |>
#   ggplot(aes(x = refdate, y = value)) +
#   geom_line() +
#   scale_y_log10() +
#   labs(
#     x = NULL, y = "Index (log scale)",
#     title = str_glue("{index_name} Historical Data - since 1968"),
#     caption = str_glue("Data imported using rb3")
#   )

## ----ibov-get-1968-plot, message=FALSE, warning=FALSE, echo=FALSE, fig.width=7, fig.height=3----
index_data |>
  ggplot(aes(x = refdate, y = value)) +
  geom_line() +
  scale_y_log10() +
  labs(
    x = NULL, y = "Index (log scale)",
    title = str_glue("{index_name} Historical Data - since 1968"),
    caption = str_glue("Data imported using rb3")
  )

## ----smll-get-2010-load, message=FALSE, warning=FALSE, echo=FALSE-------------
index_name <- "SMLL"
index_data <- try(index_get(index_name, as.Date("2010-01-01")), silent = TRUE)
if (is(index_data, "try-error")) {
  load("indexes_data.rda")
  index_data <- smll_data
}

## ----smll-get-2010, eval=FALSE------------------------------------------------
# index_name <- "SMLL"
# index_data <- index_get(index_name, as.Date("2010-01-01"))

## ----smll-get-2010-plot, fig.width=7, fig.height=3----------------------------
index_data |>
  ggplot(aes(x = refdate, y = value)) +
  geom_line() +
  labs(
    x = NULL, y = "Index",
    title = str_glue("{index_name} Historical Data"),
    caption = str_glue("Data imported using rb3")
  )

## ----indexes-last-update, eval=FALSE------------------------------------------
# indexes_last_update()

