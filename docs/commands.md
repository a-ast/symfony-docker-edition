
# login

This command opens a bash shell within the `php5-fpm` container. Please note that you will be logged in as `www-data` ant NOT `root`.

## Options

**Instance selection**

By default you will be logged into instance 1 of your container (you can spawn multiple instances of an container with docker-compose). 
If you like to be logged into an other instance you can define the number of the desired instace as the first parameter:
 
```bash

    # this will log you in into instance '1'
    ./login

    # this will log you in into instance '5'
    ./login 5

```

**User selection**

By default you will be logged in as `www-data` but you can change this with the second command parameter:

```bash

    # this will log you in into instance '1' with the user 'root'
    ./login 1 root

    # this will log you in into instance '27' with the user 'fancy-user' (you can only use existing user, so this example will fail)
    ./login 27 fancy-user

```

# console

If you like to execute symfony commands it's ***highly recommended*** to use this console script, as some special preparations (for some symfony commands) are requred.

You can use any symfony command as this console script will pipe all your arguments into the container:

```bash

    ./console cache:clear
    
    ./console cache:clear --env=prod --no-debug
        
    ./console assetic:watch
    
    ./console assetic:dump --env=prod
    
    # ...

```

**ATTENTION**

As described in the [Modifications][1] section, there are some commands that require additional preparations to work with boot2docker (assets and assetic).

This commands will only work with the `./console` command wrapper properly!

**Switch instance**

By Default the console script will execute the commands on instance '1' as user 'www-data'. 
If you need to modify this behavor you can pass temporary environment variables to the command:

```bash
    
    # the followin command equals an command call without any additional env-vars:
    INSTANCE=1 LOGIN_USER=www-data ./console cache:clear
    
    # if you like to switch the instance or user just define it like this:
    INSTANCE=17 LOGIN_USER=root ./console cache:clear

```


# xdebug

This script toggles the xDebug support for CLI and FPM debugging (by default xDebug is **disabled**):

```bash

    # enable/disable for CLI and FPM
    ./xdebug on
    ./xdebug off

    # enable/disable for CLI only
    ./xdebug [on/off] cli

    # enable/disable for FPM only
    ./xdebug [on/off] fpm

    # by default this commands will be executed for instance '1' but you can change this:
    ./xdebug [on/off] [all/cli/fpm] 17

```


[1]:    ./modifications.md