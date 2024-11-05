#! /bin/bash

USR="<username>"
PWD="*****"
HOST="<host>"

docker pull rocker/tidyverse:4.4
docker run -d -p 8787:8787 -e PASSWORD=**** -v /home/$USR/apps/:/home/rstudio/ --name rserver rocker/tidyverse:4.4

docker start -i rserver

ssh -i ~/.ssh/codez0mb1e -N -L 8787:localhost:8787 $USR@$HOST
# Open rstudio http://localhost:8787/


## References

# [1] https://cran.r-project.org/
# [2] https://www.rstudio.com/products/rstudio/download-server/
# [3] https://rocker-project.org/images/versioned/rstudio.html
# [4] https://hub.docker.com/r/rocker/tidyverse
