## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(steppedwedge)

## ----include = FALSE----------------------------------------------------------
# Including this twice (once here with include=F) avoids a bug having to do with dplyr and pkgdown
data(sw_data_example)
dat <- load_data(
  time = "period",
  cluster_id = "cluster",
  individual_id = NULL,
  treatment = "trt",
  outcome = "outcome_bin",
  data = sw_data_example
)

## -----------------------------------------------------------------------------
data(sw_data_example)
head(sw_data_example)

dat <- load_data(
  time = "period",
  cluster_id = "cluster",
  individual_id = NULL,
  treatment = "trt",
  outcome = "outcome_bin",
  data = sw_data_example
)

## ----fig.width=9, fig.height=8, fig.align = "center"--------------------------
plot_dat <- plot_design(dat)

print(plot_dat)

## -----------------------------------------------------------------------------
analysis_1 <- analyze(
  dat = dat,
  method = "mixed",
  estimand_type = "TATE", 
  exp_time = "IT",
  family = binomial,
  re = c("clust", "time")
)

print(analysis_1)

## -----------------------------------------------------------------------------
analysis_1b <- analyze(
  dat = dat,
  method = "mixed",
  estimand_type = "TATE", 
  exp_time = "IT",
  family = binomial,
  re = "clust"
)

print(analysis_1b)

## -----------------------------------------------------------------------------
analysis_2 <- analyze(
  dat = dat,
  method = "GEE",
  estimand_type = "TATE", 
  exp_time = "IT",
  family = binomial,
  corstr = "exchangeable"
)

print(analysis_2)

## -----------------------------------------------------------------------------
analysis_3 <- analyze(
  dat = dat,
  method = "mixed",
  estimand_type = "TATE", 
  exp_time = "ETI",
  family = binomial
)

print(analysis_3)

## -----------------------------------------------------------------------------
analysis_4 <- analyze(
  dat = dat,
  method = "mixed",
  estimand_type = "TATE", 
  exp_time = "NCS",
  family = binomial
)

print(analysis_4)

## -----------------------------------------------------------------------------
analysis_5 <- analyze(
  dat = dat,
  method = "mixed",
  estimand_type = "TATE",
  exp_time = "DCT",
  family = binomial,
  advanced = params(w = 2)
)

print(analysis_5)

## -----------------------------------------------------------------------------

dat_cont <- load_data(
  time = "period",
  cluster_id = "cluster",
  individual_id = NULL,
  treatment = "trt",
  outcome = "outcome_cont",
  data = sw_data_example
)

analysis_6 <- analyze(
  dat = dat_cont,
  method = "mixed",
  estimand_type = "TATE", 
  exp_time = "NCS",
  family = gaussian
)

print(analysis_6)

## -----------------------------------------------------------------------------

dat_binom <- load_data(
  time ="period",
  cluster_id = "cluster",
  individual_id = NULL,
  treatment = "trt",
  outcome = c("numerator", "denominator"),
  data = sw_data_example_binom
)


## -----------------------------------------------------------------------------

analysis_binom <- analyze(
  dat = dat_binom,
  method = "mixed",
  family = binomial,
  estimand_type = "TATE", 
  exp_time = "ETI")

print(analysis_binom)


## -----------------------------------------------------------------------------

IT_model <- analyze(
  dat = dat_cont, method = "mixed", estimand_type = "TATE",
  estimand_time = c(1, 4), exp_time = "IT"
)
ETI_model <- analyze(
  dat = dat_cont, method = "mixed", estimand_type = "TATE", 
  estimand_time = c(1, 4), exp_time = "ETI"
)
NCS_4_model <- analyze(
  dat = dat_cont, method = "mixed", estimand_type = "TATE",
  estimand_time = c(1, 4), exp_time = "NCS", 
  advanced = params(n_knots_exp = 4)
)
DCT_model <- analyze(
  dat = dat_cont, method = "mixed", estimand_type = "TATE",
  estimand_time = c(1, 4), exp_time = "DCT",
  advanced = params(w = 2)
)

plot_effect_curves(IT_model, ETI_model, NCS_4_model, DCT_model, facet_nrow = 2)



## ----fig.height = 8-----------------------------------------------------------

plot_clusters(analysis_6, ncol = 3)


## ----fig.height = 8-----------------------------------------------------------

plot_clusters(analysis_4, ncol = 3)


