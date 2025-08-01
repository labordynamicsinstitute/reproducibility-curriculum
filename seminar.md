---
title: "Reproducibility in research – Ensuring the transparency and credibility of your work"
author: 
  - "Lars Vilhuber"
  - "Michael Stepner"
  - "Laurel Krovetz"
date: 2025
---

```{r config,include=FALSE}
# ========================================================================================
# This document can be used when repurposing the curriculum for a specific event.
# Adapt and adjust as needed, including for the surveys. 
# An example can be found at https://larsvilhuber.github.io/summer-school-qicss-2025/
# ========================================================================================

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
```

::: {.panel-tabset}

## Details

- May 26 (1:00 p.m. to 4:00 p.m.) 
- May 27, 2025 (9:00 a.m. to 4:00 p.m.)

Location: *DS-1520, [pavillon DS, UQAM](https://plancampus.uqam.ca/#pavillon/ds), 320, rue Sainte-Catherine Est, Montreal, Québec* (see details on last tab)

Registration required, see [registration link](https://ecommerce.dexero.com/shopping/ciqss/ciqss/event/school_repro25/Detail.view).

*Sponsored by [QICSS](https://ciqss.org)*, part of the [Canadian Economics Association meetings pre-program](https://www.economics.ca/cea2025).

<img height="50px" src="https://ciqss.org/wp-content/uploads/2024/02/logo-ciqss-temp-1024x407.webp" alt="QICSS logo" />
<img height="50px" src="https://www.economics.ca/resources/Pictures/full_logo_with_wordmark_II.svg" alt="CEA logo" />

## Follow along

```{r qrcode}
#| echo: false

code <- qr_code(WEBSITE_URL)
plot(code)

```


## Day 1


```{r, child=c(here::here('toc.md'))}	
```



## Day 2


```{r, child=c(here::here('toc2.md'))}	
```



## Survey for Day 2

For part of Day 2, we have a choice:

- [Reproducibility when some data are confidential](https://labordynamicsinstitute.github.io/reproducibility-confidential/) 
- [Preserving raw survey data](presentation/day2.html#preserving-raw-survey-data)
- [Advanced self-checking of reproducibility](https://larsvilhuber.github.io/self-checking-reproducibility/presentation/)

To identify what we should be speaking about on Day 2, please fill out this other survey:

<`r file.path(QUALTRICS_FULL_URL,QUALTRICS_DAY2)`>

### Results

```{r downloaddata2,include=FALSE}
# download data to local location

# if the Qualtrics API key is not set, we can't fetch the data
if (Sys.getenv("QUALTRICS_API_KEY") != "") {
  data2.raw <- fetch_survey(surveyID = QUALTRICS_DAY2, verbose = TRUE) 
  data2 <- data2.raw |>
          filter(Status != "Survey Preview") |>
          filter(Consent == "I agree that my data will be used in the manner described.") |>
          filter(StartDate > QUALTRICS_DAY2_STIME & EndDate < QUALTRICS_DAY2_ETIME) |>
    # renaming variables
    select(StartDate,EndDate,Status,Finished,RecordedDate,ResponseId,Consent,Preferred_topic,Degree,JEL_primary,
          starts_with("JEL_secondary"),starts_with("Versioning_"))
} else {
  data2 <- data.frame()
}

```

```{r create_table2, results='asis', include=TRUE,echo=FALSE,message=FALSE}

if ( nrow(data2) >0 ) {
data2 |>
  select(Preferred_topic) |>
  group_by(Preferred_topic) |>
  summarise(Frequency=n()) |>
  ungroup() |>
  mutate(Percent = round(Frequency/nrow(data2)*100,2)) -> data2.table

data2.table |> kable()
} else {
  cat("No data yet. Check back later.")
}
```

```{r preserve data, include=FALSE,echo=FALSE,message=FALSE}
# Now save the data to a local file
if (nrow(data2) > 0) {
  write_csv(data2, here::here("data", "day2-survey.csv"))
  saveRDS(data2, here::here("data", "day2-survey.rds"))
} else {
  # message("No data to save.")
}
```

## Possible extra


- Discussions on concerns about ethics in data dissemination (privacy, scraping, copyright, etc.)
- [Reproducibility for LLM and AI](https://larsvilhuber.github.io/reproducibility-for-llm/presentation/)

```{r, child=c(here::here('99-links.md'))}
```

## Map

![UQAM Pavillon DS](https://plancampus.uqam.ca/fichiers/images/cartes_pavillons/DS.gif)




:::

