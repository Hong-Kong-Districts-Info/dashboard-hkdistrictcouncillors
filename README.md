# dashboard-hkdistrictcouncillors
Repository for code underlying the Shiny app dashboard for HK district councillors

## Background
The aim of this app is to provide a live one-stop-shop for information on the district councillors in Hong Kong, via aggregating posts and feeds from their public Facebook pages. 

This is a proof-of-concept implementation using Shiny, but there is an ambition to take this fully into production once the pipelines are figured out.

### Components of the app
1. Data mapping the Facebook pages of each district councillor to their names, constituencies, and basic information
2. API connection to Facebook pages
3. Shiny front-end and visualisation

## Development considerations
1. Not all district councillors will have public Facebook pages, but the aim is for the app to be as comprehensive as possible in coverage. 
2. Essential filters for the app
3. Question to whether display only a live feed, or to save a 'permanent' copy of the content as part of a post
