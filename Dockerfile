FROM r-base:latest

MAINTAINER Larry Hignight

# Install dependencies and download and install shiny server
RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev && \
    wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    rm -rf /var/lib/apt/lists/*

# Install the following R packages
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')"
RUN R -e "install.packages(c('maps', 'mapproj'), repos='https://cran.rstudio.com/')"
RUN R -e "install.packages(c('googleVis'), repos='https://cran.rstudio.com/')"
RUN R -e "install.packages(c('data.table', 'dplyr', 'httr', 'lubridate', 'plyr', 'reshape2', 'stringr'), repos='https://cran.rstudio.com/')"
RUN R -e "install.packages(c('curl', 'jpeg', 'jsonlite', 'openssl', 'png', 'uuid'), repos='https://cran.rstudio.com/')"

# If available, include Shiny app examples
RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN chown shiny:shiny /usr/bin/shiny-server.sh
RUN chmod 777 /usr/bin/shiny-server.sh
CMD ["/usr/bin/shiny-server.sh"]
