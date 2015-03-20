<?php

if (!function_exists('check_file_access')) {
    function check_file_access($path)
    {
        if (is_readable($path)) {
            return true;
        } else {
            error_log(
                'phpmyadmin: Failed to load ' . $path
                . ' Check group www-data has read access and open_basedir restrictions.'
            );
            return false;
        }
    }
}

// Load secret generated on postinst
if (check_file_access('/var/lib/phpmyadmin/blowfish_secret.inc.php')) {
    require('/var/lib/phpmyadmin/blowfish_secret.inc.php');
}

// Load autoconf local config
if (check_file_access('/var/lib/phpmyadmin/config.inc.php')) {
    require('/var/lib/phpmyadmin/config.inc.php');
}

/**
 * Server(s) configuration
 */
$i = 1;

/**
 * Read configuration from dbconfig-common
 * You can regenerate it using: dpkg-reconfigure -plow phpmyadmin
 */
if (check_file_access('/etc/phpmyadmin/config-db.php')) {
    require('/etc/phpmyadmin/config-db.php');
}

/**
 * Configure server
 */
$cfg['Servers'] = array();
$cfg['Servers'][$i]['auth_type'] = 'http';
$cfg['Servers'][$i]['host'] = 'DB_PORT_3306_TCP_ADDR';
$cfg['Servers'][$i]['connect_type'] = 'DB_PORT_3306_TCP_PROTO';
$cfg['Servers'][$i]['port'] = 'DB_PORT_3306_TCP_PORT';
$cfg['Servers'][$i]['extension'] = 'mysqli';

/**
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

/**
 * Support additional configurations
 */
foreach (glob('/etc/phpmyadmin/conf.d/*.php') as $filename) {
    include($filename);
}
