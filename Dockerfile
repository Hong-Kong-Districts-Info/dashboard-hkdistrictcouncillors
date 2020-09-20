# get shiny image
FROM rocker/shiny:3.5.1

# install linux utilities necessary to run shiny and the app
RUN apt-get update && apt-get install -y \
  libcurl4-gnutls-dev \ 
  libxml2-dev \
  libssl-dev \
  libudunits2-dev \
  libgdal-dev \
  libgeos-dev \
  libproj-dev

# install renv on Docker image
ENV RENV_VERSION 0.12.0-3
RUN R -e "install.packages(pkgs = 'remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# use renv.lock to install R packages when Docker image is built
WORKDIR /project
COPY renv.lock renv.lock
RUN R -e 'renv::restore()'

# copy app to image
COPY dashboard-hkdistrictcouncillors.Rproj /srv/shiny-server/
COPY inst/app.R /srv/shiny-server/
COPY inst/app /srv/shiny-server/app

# change mode our folder so files can be run by container
RUN chmod -R +rx /srv/shiny-server/

# declare USER, shiny, for container
USER shiny

# expose app to port number so can access Shiny app via a URL
EXPOSE 3838

# run shiny-server shell script to kick off shiny server
CMD ["/usr/bin/shiny-server.sh"]