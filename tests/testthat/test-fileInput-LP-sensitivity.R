context("fileInput, sensitivity")

# Configuration mockup
config <- list(
  inputMode = "file",
  fileType = "CPLEX_LP",
  filePath = getSampleData("table_chair.lp"),
  solver = "glpkAPI",
  returnSensitivity = TRUE
)

payload <- list(config = config, inputs = NULL)


test_that("LP sensitivity, file mode with glpkAPI", {
  skip_if_not_installed('glpkAPI')
  sol <- AlteryxSolve(payload)
  df_sensitivity <- sol$sensitivity
  expect_equal(dim(df_sensitivity$constraintsRHS), c(4,10))
})

test_that("LP row_activity, file mode with glpkAPI", {
  skip_if_not_installed('glpkAPI')
  sol <- AlteryxSolve(payload)
  expect_equal(sol$row_activity$optimals, c(240,100))
  expect_equal(sol$row_activity$slacks, c(0,0))
})
