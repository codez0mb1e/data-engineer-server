#! /bin/bash

#
# Install R Studio Server via Docker
# WARN: deprecated, use rstudio-server/server/compose.yml instead
#

USR="<username>"
PWD="<your-very-secure-pwd-here>"
HOST="<host>"
SSH_KEY_PATH="$HOME/.ssh/<path-to-private-key>"

docker pull rocker/tidyverse:4.5
docker run -d -p 8787:8787 -e PASSWORD=$PWD -v /home/$USR/apps/:/home/rstudio/ --name rserver rocker/tidyverse:4.5

docker start -i rserver

ssh -i "$SSH_KEY_PATH" -N -L 8787:localhost:8787 "${USR}@${HOST}"
# Open rstudio http://localhost:8787/


## References
# [1] https://rocker-project.org/images/versioned/rstudio.html
# [2] https://hub.docker.com/r/rocker/tidyverse
