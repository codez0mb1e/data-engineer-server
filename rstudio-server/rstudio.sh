
docker pull rocker/tidyverse:4.4
docker run -d -p 8787:8787 -e PASSWORD=<pwd> -v /home/<user>/apps/:/home/rstudio/ --name rx rocker/tidyverse:4.4

ssh -i ~/.ssh/codez0mb1e -N -L 8787:localhost:8787 <user>@<host>
