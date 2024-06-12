# Copyright (c) Meta Platforms, Inc. and its affiliates.

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.


options(repos="https://ftp.yz.yamagata-u.ac.jp/pub/cran/")

#### Nevergrad installation guide
## ATTENTION: Python version 3.10+ version may cause Nevergrad error
## See here for more info about installing Python packages via reticulate
## https://rstudio.github.io/reticulate/articles/python_packages.html

# Install reticulate first if you haven't already
install.packages("reticulate")

#### Option 1: nevergrad installation via PIP
# 1. load reticulate
library("reticulate")
# 2. create virtual environment
virtualenv_create("r-reticulate")
# 3. use the environment created
use_virtualenv("r-reticulate", required = TRUE)
# 4. point Python path to the python file in the virtual environment. Below is
#    an example for MacOS M1 or above. The "~" is my home dir "/Users/gufengzhou".
#    Show hidden files in case you want to locate the file yourself.
Sys.setenv(RETICULATE_PYTHON = "~/.virtualenvs/r-reticulate/bin/python")
# 5. Check python path
py_config() # If the first path is not as 4, do 6
# 6. Restart R session, run #4 first, then load library("reticulate"), check
#    py_config() again, python should have path as in #4.
#    If you see: "NOTE: Python version was forced by RETICULATE_PYTHON_FALLBACK"
#    if you're using RStudio, go to Global Options > Python, and uncheck the
#    box for "Automatically activate project-local Python environments".
# 7. Install numpy if py_config shows it's not available
py_install("numpy", pip = TRUE)
# 8. Install nevergrad
py_install("nevergrad", pip = TRUE)
# 9. If successful, py_config() should show numpy and nevergrad with installed paths
# 10. Everytime R session is restarted, you need to run #4 first to assign python
#    path before loading Robyn
# 11. Alternatively, add the line RETICULATE_PYTHON = "~/.virtualenvs/r-reticulate/bin/python"
#    in the file Renviron in the the R directory to force R to always use this path by
#    default. One way to create and edit the Renviron file is to install the package "usethis" and run
#    the function usethis::edit_r_environ(). For Unix/Mac, there's also another Renviron file
#    located at path "/Library/Frameworks/R.framework/Resources/etc/". Add the line from above to this file.
#    This way, you don't need to run #4 everytime. Restart R session after editing.
