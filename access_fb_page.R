library(httr)
library(httpuv)
library(jsonlite)
library(dplyr)
library(lubridate)

# define keys
app_id <- Sys.getenv(x = "APP_ID_HKDC")
app_secret <- Sys.getenv(x = "APP_SECRET_KEY_HKDC")
app_access_token <- Sys.getenv(x = "APP_ACCESS_TOKEN_HKDC")

# define app
app_fb <- oauth_app(appname = "facebook",
                    key = app_id,
                    secret = app_secret)

# get OAuth app-access token
token_fb <- oauth2.0_token(endpoint = oauth_endpoints("facebook"),
                           app = app_fb,
                           scope = 'public_profile',
                           type = "application/x-www-form-urlencoded",
                           cache = TRUE)

# test token works with basic API call
response <- GET(url = "https://graph.facebook.com",
                path = "/me",
                config = config(token = token_fb))


###
getPage(page = "huichifung913", token = app_access_token, n = 4)