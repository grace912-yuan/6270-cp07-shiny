# Data Explorer

## Overview
This repository contains a Shiny app developed for VTPEH 6270 Check Point 07. The app explores relationships between life expectancy and selected human development indicators across countries using the `HDR23-24_subset.csv` dataset.

The app allows users to select two numeric variables, generate a scatter plot, view a fitted linear regression line with a 95% confidence band, and examine a short statistical summary including the Pearson correlation, p-value, sample size, and a brief interpretation.

## App Goal
The goal of this app is to provide an interactive way to explore how life expectancy is associated with education, income, inequality, and other development-related indicators across countries.

## Motivating Question
How is life expectancy associated with education, income, inequality, and other development indicators?

## Features
- Interactive selection of X-axis and Y-axis variables
- A **Run Analysis** button that updates the visual and summary output
- Scatter plot with fitted linear regression line
- 95% confidence band around the regression line
- Summary output including:
  - Pearson correlation
  - p-value
  - complete-case sample size
  - brief interpretation of the linear association
- An **About** tab describing the app purpose, data source, methods, authorship, repository link, and AI disclosure

## Files in This Repository
- `app.R` — main Shiny app code
- `HDR23-24_subset.csv` — dataset used by the app
- `README.md` — repository overview and instructions

## Data Source
The app uses the file `HDR23-24_subset.csv`, which contains country-level human development indicators including life expectancy and related development measures.

## Variables Used in the App
The current app allows users to explore the following numeric variables:
- `hdi_2022`
- `le_2022`
- `mys_2022`
- `gnipc_2022`
- `ineq_le_2022`
- `ineq_edu_2022`
- `ineq_inc_2022`
- `co2_prod_2022`

## Methods
For a selected pair of variables, the app:
1. keeps complete cases only,
2. creates a scatter plot,
3. adds a fitted linear regression line with a 95% confidence band,
4. computes the Pearson correlation,
5. reports the p-value and sample size, and
6. provides a brief interpretation of the direction and strength of the linear association.

## How to Run the App Locally
1. Clone or download this repository.
2. Open the project in RStudio.
3. Make sure `app.R` and `HDR23-24_subset.csv` are in the same folder.
4. Install required packages if needed:
   ```r
   install.packages("shiny")
   install.packages("ggplot2")
   install.packages("readr")

## Run the app using
shiny::runApp()
Or open app.R in RStudio and click Run App.

## APP structure

### Explore
Users select two variables and click Run Analysis to update:
1. the scatter plot
2. the regression line
3. the statistical summary

### About
This tab provides:
1. the app goal
2. the motivating question
3. author information
4. data source
5. methods
6. GitHub repository information
7. AI disclosure

### Author
Mengzhi “Grace” Yuan

### Course Information
VTPEH 6270
Check Point 07 — Shiny App

### GitHub Repository
https://github.com/grace912-yuan/6270-cp07-shiny

### AI Disclosure
This app was developed with coding support from ChatGPT. All final decisions, testing, debugging, and interpretation were reviewed by the author.
Notes
This app is intended for educational use as part of a course assignment. It is designed to be simple, readable, and easy to use while demonstrating basic Shiny functionality, interactive plotting, and statistical summary output.

