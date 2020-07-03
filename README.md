# Dashboard: Hong Kong District Councillors

[![Travis build status](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors.svg?branch=master)](https://travis-ci.com/avisionh/dashboard-hkdistrictcouncillors)

[![R build status](https://github.com/avisionh/dashboard-hkdistrictcouncillors/workflows/R-CMD-check/badge.svg)](https://github.com/avisionh/dashboard-hkdistrictcouncillors/actions)

Repository for code underlying the Shiny app dashboard for HK district councillors

The Shiny app is deployed onto shinyapps.io in the link below:
 - https://avisionh.shinyapps.io/dashboard-hkdistrictcouncillors/

## Background
The aim of this app is to provide a convenient site for live information on the district councillors in Hong Kong, via aggregating posts and feeds from their public Facebook pages.

This is a proof-of-concept implementation using Shiny, but there is an ambition to take this fully into production once the pipelines are figured out.

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
