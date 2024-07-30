# Set base image
FROM ohdsi/broadsea-shiny:1.0.0

# install additional required OS dependencies
RUN apt-get update && \
    apt-get install -y python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install additional required Python packages
RUN pip install faicons

# install OhdsiShinyModules R package from GitHub, temporarily adding a GitHub Personal Access Token (PAT) to the Renviron file
RUN --mount=type=secret,id=build_github_pat \
	cp /usr/local/lib/R/etc/Renviron /tmp/Renviron \
        && echo "GITHUB_PAT=$(cat /run/secrets/build_github_pat)" >> /usr/local/lib/R/etc/Renviron \
        && R -e "remotes::install_github(repo = 'OHDSI/OhdsiShinyModules@v1.0.1', upgrade = 'always')" \
        && cp /tmp/Renviron /usr/local/lib/R/etc/Renviron

# install additional required R packages
RUN R -e "install.packages('kableExtra')"

# Set an argument for the app name
ARG APP_NAME

# Set arguments for the GitHub branch and commit id abbreviation
ARG GIT_BRANCH=unknown
ARG GIT_COMMIT_ID_ABBREV=unknown

# Set workdir and copy app files
WORKDIR /srv/shiny-server/${APP_NAME}
COPY . .

# Expose default Shiny app port
EXPOSE 3838

# Run the Shiny app
CMD R -e "shiny::runApp('/srv/shiny-server/${APP_NAME}', host = '0.0.0.0', port = 3838)"
