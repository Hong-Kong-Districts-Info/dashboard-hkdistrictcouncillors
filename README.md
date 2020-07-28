# Dashboard: Hong Kong District Councillors

[![Travis build status](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors.svg?branch=master)](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors) [![R build status](https://github.com/avisionh/dashboard-hkdistrictcouncillors/workflows/R-CMD-check/badge.svg)](https://github.com/avisionh/dashboard-hkdistrictcouncillors/actions) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> *To provide a convenient site for live information on the district councillors in Hong Kong, via aggregating posts and feeds from their public Facebook pages.*

The Shiny app is deployed onto shinyapps.io in the link below:

 - Production: https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors/
 - Pre-Production: https://hkdistricts-info.shinyapps.io/dashboard-hkdistrictcouncillors-preprod/

***

## Project organisation

    ├── LICENSE
    │
    ├── README.md               <- The top-level README for developers using this project
    │
    ├── DESCRIPTION             <- Store important metadata about project
    │
    ├── CONTRIBUTING.md         <- Guide to how potential contributors can help with your project
    │
    ├── NAMESPACE               <- Prevent conflict in package names
    │
    ├── .gitignore              <- Files and directories to be ignored by git
    │
    ├── src/
    │   ├── app.R               <- App script calling sub-scripts
    │   └── app/               
    |       ├── data/           <- Contains data for app
    |       ├── R/              <- Contains functions for app
    |       ├── google-analytics.html    <- Code to link app with Google Analytics
    |       ├── global.R        <- Static objects for app
    |       ├── server.R        <- Reactive objects for app
    |       └── ui.R            <- User-interface for app
    ├── .development/
    │   ├── googlesheets_dataclean.R    <- Wrangles Google Sheet data for app
    │
    ├── .github/                         
    │   └── pull_request_template.md    <- Pull request template
    |   └── ISSUE_TEMPLATE/
    |       ├── bug_report.md         <- Issue template for bugs
    |       └── feature_report.md     <- Issue template for features
    |   └── workflows/
    |       └── rcmd_build.yml    <- Instructions for R CMD checks
    │
    ├── renv/                     <- Contains config to use renv package
    │
    ├── renv.lock                 <- Contains package versions used for project
    │
    ├── travis.yml                <- Instructions for travis.ci checks
    │
    ├── dashboard-hkdistrictcouncillors.Rproj   <- Config to establish Rproject

***

### Components of the app
1. Data mapping the Facebook pages of each district councillor to their names, constituencies, and basic information
2. API connection to Facebook pages
3. Shiny front-end and visualisation

## Development considerations
1. Not all district councillors will have public Facebook pages, but the aim is for the app to be as comprehensive as possible in coverage.
2. Essential filters for the app
3. Question to whether display only a live feed, or to save a 'permanent' copy of the content as part of a post

## Data Source

A list of the District Councillors and their handles are compiled here:

https://docs.google.com/spreadsheets/d/1usk9Q-5lA4bL_z6KXpUohc_2x_KhDgLxtm-YEtim_yk/edit#gid=0
