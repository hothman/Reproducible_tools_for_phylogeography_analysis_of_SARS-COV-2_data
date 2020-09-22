library(babette)
library(testthat)
mcmc <- beautier::create_test_ns_mcmc()

if (is_beast2_installed() && is_beast2_pkg_installed("NS")) {
  out_constant <- bbt_run_from_model(
    fasta_filename = "/home/dell/corona.fasta",
    inference_model = create_inference_model(
      site_model = beautier::create_jc69_site_model(),
      tree_prior =beautier::create_ccp_tree_prior(),
      tipdates_filename = "/home/dell/corona.txt",
      mcmc =beautier::create_test_ns_mcmc()
  
    ),
    beast2_options = create_beast2_options(
      beast2_path = beastier::get_default_beast2_bin_path()
    )
  )
  out_bcs <- bbt_run_from_model(
    fasta_filename = "/home/dell/corona.fasta",
    inference_model = create_inference_model(
      site_model = beautier::create_jc69_site_model(),
      tree_prior =beautier::create_cbs_tree_prior(),
      clock_model = create_strict_clock_model(
        clock_rate_distr = create_log_normal_distr(
          m = 0.01,
          s = 0.00001
        )
      ),
      tipdates_filename = "/home/dell/corona.txt",
      mcmc = mcmc
    ),
    beast2_options = create_beast2_options(
      beast2_path = beastier::get_default_beast2_bin_path()
    )
  )
}
if (is_beast2_installed() && is_beast2_pkg_installed("NS")) {
  df <- data.frame(
    model = c("out_constant", "out_bcs"),
    mar_log_lik = c(out_constant$ns$marg_log_lik, out_bcs$ns$marg_log_lik),
    mar_log_lik_sd = c(out_constant$ns$marg_log_lik_sd, out_bcs$ns$marg_log_lik_sd)
  )
  knitr::kable(df)
}



if (is_beast2_installed() && is_beast2_pkg_installed("NS")) {
  bayes <- out_constant$ns$marg_log_lik / out_bcs$ns$marg_log_lik

}
#######################################Show the effective sample sizes (ESS)###################################################
sample_interval <- mcmc$tracelog$log_every
if (is_beast2_installed()) {
  traces <- remove_burn_ins(
    traces = out_bcs$estimates,
    burn_in_fraction = 0.2
  )
  esses <- t(calc_esses(traces, sample_interval = sample_interval))
  colnames(esses) <- "ESS"
  knitr::kable(esses)
} #For a reliable inference, use an ESS of at least 200.
  #######################################Show the summary statistics###################################################
if (is_beast2_installed()) {
  sum_stats <- t(
    calc_summary_stats(
      traces$posterior,
      sample_interval = sample_interval
    )
  )
  colnames(sum_stats) <- "Statistic"
  knitr::kable(sum_stats)
}
#######################################Plot the posterior phylogenies###################################################
if (is_beast2_installed()) {
  plot_densitree(out_constant$corona_trees, width = 3)
}

