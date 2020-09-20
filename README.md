# Dashboard: Hong Kong District Councillors <img src="https://raw.githubusercontent.com/avisionh/dashboard-hkdistrictcouncillors/master/inst/app/www/logo.png" align="right" height="140" />

[![Travis build status](https://travis-ci.org/Hong-Kong-Districts-Info/dashboard-hkdistrictcouncillors.svg?branch=master)](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors) [![R build status](https://github.com/avisionh/dashboard-hkdistrictcouncillors/workflows/R-CMD-check/badge.svg)](https://github.com/avisionh/dashboard-hkdistrictcouncillors/actions) [![Codecov test coverage](https://codecov.io/gh/avisionh/dashboard-hkdistrictcouncillors/branch/master/graph/badge.svg)](https://codecov.io/gh/avisionh/dashboard-hkdistrictcouncillors?branch=master) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) 

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
    |       ├── extdata/                        <- External data gathered for app
    |       ├── data/                           <- Internal data created for app
    |       ├── R/                              <- Functions for app
    |       ├── www/                            <- Logo files for app
    |       ├── modules/                        <- Components of server.R objects
    |       ├── helpfiles/                      <- Markdown of shinyhelper tips
    |       ├── google-analytics.html           <- Link app with Google Analytics
    |       ├── global.R                        <- Static objects for app
    |       ├── server.R                        <- Reactive objects for app
    |       └── ui.R                            <- User-interface for app
    |
    ├── tests/                                  <- Files for unit-testing
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
    ├── Dockerfile                              <- Create Docker container
    │
    └── dashboard-hkdistrictcouncillors.Rproj   <- Config to establish Rproject

***

## Installation
Ensure you have R version 3.6.2. Install and run this app locally in your command shell (instructions for iOS):

```shell
git clone https://github.com/Hong-Kong-Districts-Info/dashboard-hkdistrictcouncillors.git
cd dashboard-hkdistrictcouncillors
r
install.packages(pkgs = "renv", Ncpus = 1)
renv::restore()
shiny::runApp(appDir = "inst/app.R")
```

To run this app via Docker, in the directory where the `Dockerfile` is, execute the following in your command shell (instructions for iOS):

```shell

# build and run Docker container
docker build -t dashboard-hkdistrictcouncillors .
docker run -rm -p 3838:3838 dashboard-hkdistrictcouncillors

# get your IP address
ipconfig getifaddr en0
```

Then, in your web-browser, type in:

```
http://<your_ip_address>:3838/
```

***

## Development considerations
- Not all district councillors will have public Facebook pages, but the aim is for the app to be as comprehensive as possible in coverage.

## Data Source

A list of the District Councillors and their Facebooks page hyperlinks are publicly-accessible on Google Drive [here](https://docs.google.com/spreadsheets/d/1007RLMHSukSJ5OfCcDJdnJW5QMZyS2P-81fe7utCZwk/).

The data is also available as an R package on https://github.com/Hong-Kong-Districts-Info/hkdatasets.

***

## Getting help
If you encounter a clear bug, please file an issue with a minimal reproducible example on [GitHub](https://github.com/avisionh/dashboard-hkdistrictcouncillors/issues).


## Code of Conduct

Please note that the hkdistrictcouncillors project is released with a [Contributor Code of Conduct](https://github.com/avisionh/dashboard-hkdistrictcouncillors/blob/feature/code-coverage/CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

## Project Team website
To find out more about our project team and other projects by us, please visit our [website](https://hong-kong-districts-info.github.io/).

You can find out about our current backlog of work on our public [Trello Doing board](https://trello.com/b/n5l7DMS5/doing).
