#!/bin/bash

DO="$1"
MODE="$2"

CONF_SRC_CLI="/etc/php5/mods-available/xdebug.cli.ini"
CONF_SRC_FPM="/etc/php5/mods-available/xdebug.fpm.ini"
CONF_CLI="/etc/php5/cli/conf.d/20-xdebug.ini"
CONF_FPM="/etc/php5/fpm/conf.d/20-xdebug.ini"


# restart the FPM process
function restartFpm {
    killall --signal 9 -r php5-fpm
}

# enable debugging within FPM
function enableFpm {
    if [ ! -e $CONF_FPM ]; then
        ln -s $CONF_SRC_FPM $CONF_FPM
    fi
}

# disable debugging within FPM
function disableFpm {
    rm -rf $CONF_FPM
}

# enable debugging within CLI
function enableCli {
    if [ ! -e $CONF_CLI ]; then
        ln -s $CONF_SRC_CLI $CONF_CLI
    fi
}

# disable debugging within CLI
function disableCli {
    rm -rf $CONF_CLI
}


# enable xdebug
if [ "on" == "$DO" ]; then

    if [ "cli" == "$MODE" ]; then
        enableCli
    else
        if [ "fpm" == "$MODE" ]; then
            enableFpm
        else
            enableCli
            enableFpm
        fi
    fi

    restartFpm
fi


# disable xdebug
if [ "off" == "$DO" ]; then

    if [ "cli" == "$MODE" ]; then
        disableCli
    else
        if [ "fpm" == "$MODE" ]; then
            disableFpm
        else
            disableCli
            disableFpm
        fi
    fi

    restartFpm
fi
