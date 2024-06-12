FROM rocker/r-ubuntu:18.04

# install python dependencies
RUN apt-get update && apt-get install -y python3-pip python3-dev python3-venv
ADD install_nevergrad.R /tmp/install_nevergrad.R
RUN Rscript /tmp/install_nevergrad.R

# Install system dependencies
RUN Rscript -e "install.packages('tidyverse', dependencies=TRUE)"
RUN Rscript -e "install.packages('Robyn', dependencies=TRUE)"
RUN Rscript -e "install.packages('prophet', dependencies=TRUE)"
RUN Rscript -e "install.packages('reticulate', dependencies=TRUE)"
RUN Rscript -e "install.packages('remotes', dependencies=TRUE)"
RUN Rscript -e "install.packages('rstan', dependencies=TRUE)"

# add app
ADD sample.R /app/sample.R
CMD ["Rscript", "/app/sample.R"]
