FROM rocker/shiny:4.2.1

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    git-core \
    libssl-dev \
    libcurl4-gnutls-dev \
    curl \
    libsodium-dev \
    libxml2-dev \
    libicu-dev \
    texlive-xetex \
    software-properties-common \
    && apt-get update \
    && add-apt-repository universe \
    && add-apt-repository multiverse \
    && apt-get update \
    && yes | apt-get install -y ttf-mscorefonts-installer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r --error --skipinstalled \
    shiny \
    jsonlite \
    ggplot2 \
    htmltools \
    ggplot2 \
    png \
    extrafont \
    knitr \
    rmarkdown \
    shinydashboard \
    tinytex \
    here \
    RCurl \
    devtools \
    remotes \
    readr \
    readxl \
    DT \
    stringr \
    fs \
    lubridate \
    dplyr \
    purrr \
    janitor \
    shinycssloaders \
    zip \
    renv \
    pak \
    plumber

RUN Rscript -e "tinytex:::install_yihui_pkgs(); tinytex::tlmgr_install('adjustbox')"

WORKDIR /srv/shiny-server/
RUN git clone -b plumber https://github.com/chendaniely/bitsi.git bitsi-code && \
    chmod 777 -R bitsi-code && \
    ln -s /srv/shiny-server/bitsi-code/pictaACTinfographics/shiny bitsi

EXPOSE 3838
CMD ["/usr/bin/shiny-server"]
