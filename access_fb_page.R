library(Rfacebook)

# http://pablobarbera.com/blog/archives/3.html
# set environment variable using usethis::edit_r_environ()

# define keys
app_access_token <- Sys.getenv(x = "APP_ACCESS_TOKEN_HKDC")

# get page data
getPage(page = "huichifung913", token = app_access_token, n = 4)