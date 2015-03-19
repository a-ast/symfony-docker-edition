FROM ubuntu:14.04
MAINTAINER Simon Schröer


#
# install dependencies
#
RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y nano phpmyadmin && \
    rm -rf /etc/apache2/sites-enabled/* && \
    rm -rf /var/www/* && \
    echo "<?php header('Location: /phpmyadmin');" > /var/www/index.php


#
# use the given config file
#
COPY entrypoint.sh /entrypoint.sh
COPY config.inc.php /etc/phpmyadmin/config.inc.tpl.php
COPY apache.conf /etc/apache2/sites-enabled/000-phpmyadmin.conf


#
# Set permissions
#
RUN chmod +x /entrypoint.sh


#
# port-configuration
#
EXPOSE 80


#
# default entrypoint
#
CMD ["/entrypoint.sh"]
