library(targets)

# Distributed computing options go here

# Source R files in package-level R/ directory
tar_source(files = "../R")

# Replace the target list below with your own:
list(
  tar_target(
    name = data,
    command = simulate_data()
  ),
  tar_target(
    name = model,
    command = linear_fit(data)
  )
)
