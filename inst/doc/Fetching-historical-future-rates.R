## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message=FALSE-----------------------------------------------------
library(rb3)
library(ggplot2)
library(stringr)
library(dplyr)
library(bizdays)

df <- futures_mget(
    first_date = "2021-01-01",
    last_date = "2022-04-27",
    by = 5
)

## ---- fig.width=9, fig.height=6-----------------------------------------------
di1_futures <- df |>
    filter(commodity == "DI1") |>
    mutate(
        maturity_date = maturity2date(maturity_code),
        fixing = following(maturity_date, "Brazil/ANBIMA"),
        business_days = bizdays(refdate, maturity_date, "Brazil/ANBIMA"),
        adjusted_tax = (100000 / price) ^ (252 / business_days) - 1
    ) |>
    filter(business_days > 0)

di1_futures |>
    filter(symbol %in% c("DI1F23", "DI1F33")) |>
    ggplot(aes(x = refdate, y = adjusted_tax, color = symbol, group = symbol)) +
    geom_line() +
    geom_point() +
    labs(
        title = "DI1 Future Rates - Nominal Interest Rates",
        caption = str_glue("Data imported using rb3 at {Sys.Date()}"),
        x = "Date",
        y = "Interest Rates",
        color = "Symbol"
    ) +
    scale_y_continuous(labels = scales::percent)

## ---- fig.width=9, fig.height=6-----------------------------------------------
dap_futures <- df |>
    filter(commodity == "DAP") |>
    mutate(
        maturity_date = maturity2date(maturity_code, "15th day"),
        fixing = following(maturity_date, "Brazil/ANBIMA"),
        business_days = bizdays(refdate, maturity_date, "Brazil/ANBIMA"),
        adjusted_tax = (100000 / price) ^ (252 / business_days) - 1
    ) |>
    filter(business_days > 0)

dap_futures |>
    filter(symbol %in% c("DAPF23", "DAPK35")) |>
    ggplot(aes(x = refdate, y = adjusted_tax, group = symbol, color = symbol)) +
    geom_line() +
    geom_point() +
    labs(
        title = "DAP Future Rates - Real Interest Rates",
        caption = str_glue("Data imported using rb3 at {Sys.Date()}"),
        x = "Date",
        y = "Interest Rates",
        color = "Symbol"
    ) +
    scale_y_continuous(labels = scales::percent)

## ---- warning=FALSE, fig.width=9, fig.height=6--------------------------------
infl_futures <- df |>
    filter(symbol %in% c("DI1F23", "DAPF23")) |>
    mutate(
        maturity_date = if_else(commodity == "DI1",
            maturity2date(maturity_code),
            maturity2date(maturity_code, "15th day")
        ),
        fixing = following(maturity_date, "Brazil/ANBIMA"),
        business_days = bizdays(refdate, maturity_date, "Brazil/ANBIMA"),
        adjusted_tax = (100000 / price) ^ (252 / business_days) - 1
    ) |>
    arrange(refdate)

infl_expec <- infl_futures |>
    select(symbol, price, refdate) |>
    tidyr::pivot_wider(names_from = symbol, values_from = price) |>
    mutate(inflation = DAPF23 / DI1F23 - 1)

infl_expec |>
    ggplot(aes(x = refdate, y = inflation)) +
    geom_line() +
    geom_point()

## ---- warning=FALSE, fig.width=9, fig.height=6--------------------------------
df_fut <- df |>
    filter(symbol %in% c("DI1F23", "DI1F33")) |>
    mutate(
        maturity_date = maturity2date(maturity_code) |>
            following("Brazil/ANBIMA"),
        business_days = bizdays(refdate, maturity_date, "Brazil/ANBIMA")
    )

df_du <- df_fut |>
    select(refdate, symbol, business_days) |>
    tidyr::pivot_wider(names_from = symbol, values_from = business_days) |>
    mutate(
        du = DI1F33 - DI1F23
    ) |>
    select(refdate, du)

df_fwd <- df_fut |>
    select(refdate, symbol, price) |>
    tidyr::pivot_wider(names_from = symbol, values_from = price) |>
    inner_join(df_du, by = "refdate") |>
    mutate(
        fwd = (DI1F23 / DI1F33)^(252 / du) - 1
    ) |>
    select(refdate, fwd) |>
    na.omit()

## ---- warning=FALSE, fig.width=9, fig.height=6--------------------------------
df_fwd |>
    ggplot(aes(x = refdate, y = fwd)) +
    geom_line() +
    labs(
        x = "Date", y = "Forward Rates",
        title = "Historical 10Y Forward Rates - F23:F33",
        caption = "Source B3 - package rb3"
    )

