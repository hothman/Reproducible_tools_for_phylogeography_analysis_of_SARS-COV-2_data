library(babette)
library(testthat)
################################model_1##################################
inference_model <- create_test_inference_model(
  tree_prior = create_tree_prior_cbs(),
  clock_model = create_strict_clock_model(),
  site_model = create_jc69_site_model(),
  tipdates_filename = "corona.txt")


if (is_beast2_installed()) {
  out<- bbt_run_from_model(
    fasta_filename = "corona.fasta",
    inference_model = inference_model
  )
}
out_model1=create_test_bbt_run_output()

###############################model_2#####################################
inference_model <- create_test_inference_model(
  tree_prior = create_tree_prior_cbs(),
  clock_model = create_clock_model_rln(),
  site_model = create_gtr_site_model(),
  tipdates_filename = "corona.txt")


if (is_beast2_installed()) {
  out<- bbt_run_from_model(
    fasta_filename = "corona.fasta",
    inference_model = inference_model
  )
}
out_model2=create_test_bbt_run_output()

#############################best_model#####################################
