#!/bin/bash

INSTANCE="$1"
LOGIN_USER="$2"

if [ "" == "$INSTANCE" ]; then
    INSTANCE="1"
fi

if [ "" == "$LOGIN_USER" ]; then
    LOGIN_USER="www-data"
fi

clear; echo "Logging in - have fun!"
docker exec -it ${PWD##*/}"_php5_"$INSTANCE /bin/bash -c "cd /var/www && sudo -u $LOGIN_USER TERM=\"xterm\" APP_CONTEXT=\"docker\" /bin/bash"
