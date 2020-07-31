# Dashboard: Hong Kong District Councillors <img src="https://raw.githubusercontent.com/avisionh/dashboard-hkdistrictcouncillors/master/inst/app/www/logo.png" align="right" height="140" />

[![Travis build status](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors.svg?branch=master)](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors) [![R build status](https://github.com/avisionh/dashboard-hkdistrictcouncillors/workflows/R-CMD-check/badge.svg)](https://github.com/avisionh/dashboard-hkdistrictcouncillors/actions) [![Codecov test coverage](https://codecov.io/gh/avisionh/dashboard-hkdistrictcouncillors/branch/master/graph/badge.svg)](https://codecov.io/gh/avisionh/dashboard-hkdistrictcouncillors?branch=master) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 

> *To provide a convenient site for live information on the district councillors in Hong Kong, via aggregating posts and feeds from their public Facebook pages.*

The Shiny app is deployed onto shinyapps.io in the links below:

 - Production: https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors/
 - Pre-Production: https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors-preprod/
 - Development: https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors-dev/

***

## Project organisation

    ├── LICENSE                                 <- Sharing agreement
    │
    ├── README.md                               <- Introduces project
    │
    ├── DESCRIPTION                             <- Store important metadata about project
    │
    ├── CODE_OF_CONDUCT.md                      <- Guide to define community standards
    │
    ├── CONTRIBUTING.md                         <- Guide to how contributors can help
    │
    ├── NAMESPACE                               <- Prevent conflict in package names
    │
    ├── .gitignore                              <- Files and folders to be ignored by git
    │
    ├── inst/
    │   ├── app.R                               <- App script calling sub-scripts
    │   └── app/               
    |       ├── extdata/                        <- Data for app
    |       ├── R/                              <- Functions for app
    |       ├── google-analytics.html           <- Link app with Google Analytics
    |       ├── global.R                        <- Static objects for app
    |       ├── server.R                        <- Reactive objects for app
    |       └── ui.R                            <- User-interface for app
    |
    ├── .development/
    │   ├── googlesheets_dataclean.R            <- Wrangles Google Sheet data for app
    │   └── func_clean_gsheet_data.R            <- Function to clean Google Sheet
    │
    ├── .github/                         
    │   ├── pull_request_template.md            <- Pull request template
    |   └── ISSUE_TEMPLATE/
    |       ├── bug_report.md                   <- Issue template for bugs
    |       └── feature_report.md               <- Issue template for features
    |   └── workflows/
    |       └── rcmd_build.yml                  <- Instructions for R CMD checks
    │
    ├── renv/                                   <- Config to use renv package
    │
    ├── renv.lock                               <- Package versions used for project
    │
    ├── travis.yml                              <- Instructions for travis.ci checks
    │
    ├── codecov.yml                             <- Instructions for codecov.io checks
    │
    └── dashboard-hkdistrictcouncillors.Rproj   <- Config to establish Rproject

***

## Installation
Install and run this app locally in your command shell (instructions for iOS):

```shell
git clone https://github.com/avisionh/dashboard-hkdistrictcouncillors.git
cd dashboard-hkdistrictcouncillors
r
shiny::runApp(appDir = "inst/app.R")
```

### Components of the app
1. Data mapping the Facebook pages of each district councillor to their names, constituencies, and basic information
2. API connection to Facebook pages
3. Shiny front-end and visualisation

## Development considerations
- Not all district councillors will have public Facebook pages, but the aim is for the app to be as comprehensive as possible in coverage.

## Data Source

A list of the District Councillors and their Facebooks page hyperlinks are publicly-accessible on Google Drive [here](https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/edit#gid=0).

***

## Getting help
If you encounter a clear bug, please file an issue with a minimal reproducible example on [GitHub](https://github.com/avisionh/dashboard-hkdistrictcouncillors/issues).


## Code of Conduct

Please note that the hkdistrictcouncillors project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
