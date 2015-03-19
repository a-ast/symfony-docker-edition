#!/bin/bash

# modify the config
rm /etc/phpmyadmin/config.inc.php
cp /etc/phpmyadmin/config.inc.tpl.php /etc/phpmyadmin/config.inc.php

# modify
/bin/sed -i "s/DB_PORT_3306_TCP_ADDR/${DB_PORT_3306_TCP_ADDR}/" /etc/phpmyadmin/config.inc.php
/bin/sed -i "s/DB_PORT_3306_TCP_PROTO/${DB_PORT_3306_TCP_PROTO}/" /etc/phpmyadmin/config.inc.php
/bin/sed -i "s/DB_PORT_3306_TCP_PORT/${DB_PORT_3306_TCP_PORT}/" /etc/phpmyadmin/config.inc.php

# start apache service
/usr/sbin/apache2ctl -D FOREGROUND
