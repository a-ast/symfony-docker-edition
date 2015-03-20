# Installation

*I asume that you properly installed `docker` (min. 1.5), `boot2docker` and `docker-comopose` on your host system.*


The installation is very simple:

1. Download the ZIP archive of this respository from GitHub and unzip it
2. Open up an terminal and switch into the `symfony` sub-directory of the downloaded project template
3. Install vendors as usual (e.g. by using `composer install` etc.)
4. Switch to the project root (`cd ../`)
5. Start your container environment: `docker-compose up -d` (this might take some time if you haven't build this project before!)
6. If something goes wrong, have a look into the logs: `docker-compose logs`

