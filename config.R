renv::restore(prompt = FALSE)
library(readr)
library(here)
library(knitr)
library(dplyr)
library(ggplot2)
library(qualtRics)
library(lubridate)
library(qrcode)

# qualtRics secrets are read from the environment:
# - QUALTRICS_API_KEY
# - QUALTRICS_BASE_URL

# We also need DATAVERSE secrets
#      DATAVERSE_TOKEN: ${{secrets.DATAVERSE_TOKEN}}
#      DATAVERSE_SERVER: https://demo.dataverse.org
#      DATAVERSE_DATASET_DOI: do
# Let's check that they are there:

message(Sys.getenv("QUALTRICS_BASE_URL"))

# The repository name

message(Sys.getenv("GITHUB_REPOSITORY"))

# Process the repository name to generate the URL
# - split the two components
# - combine them into a URL with 'github.io' in the middle

GITHUB_REPOSITORY <- Sys.getenv("GITHUB_REPOSITORY")
GITHUB_REPOSITORY_PARTS <- strsplit(GITHUB_REPOSITORY, "/")[[1]]
REPOSITORY_URL <- paste0("https://github.com/", GITHUB_REPOSITORY)
WEBSITE_URL <- paste0("https://", GITHUB_REPOSITORY_PARTS[1], ".github.io/", GITHUB_REPOSITORY_PARTS[2])

# Qualtrics data for Day 1:
# you can find this with all_surveys() %>% arrange(creationDate) %>% head()

QUALTRICS_FULL_URL <- "https://cornell.yul1.qualtrics.com/jfe/form"

# Public Qualtrics URL for day 2

QUALTRICS_DAY2 <- "SV_cNkhKL69K2Ob7o2"

# Time when this was posted (discard anything before that)

QUALTRICS_DAY2_STIME <- ymd_hms("2025-04-30 23:59:00")
QUALTRICS_DAY2_ETIME <- ymd_hms("2025-05-26 23:59:00")

if (!dir.exists(here::here("data"))) {
  dir.create(here::here("data"))
}