# Modifications

To run Symfony apps within boot2docker you'll have to fight some limitations due to the [VirtualBox][1] VM containing the Docker daemon.
In fact there is only one realy annoying issue, but it's so important and central that it affacts some of the core components of Symfony.


## The Problem: missing write permissions

As you might know, boot2docker will create a VirtualBox VM running the Docker daemon. This is necessary as Windows and Mac OS X doesn't support kernel based virtualisation.

If you start a container with an volume (e.g. your project sourcecode) it will be mounted into the boot2docker VM and from the VM into the containers filesystem.
And exactly this is the problem, as only the root user within the container is allowed to write, modify oder delete files in shared volumes of the container.

Even granting the `--privileged` flag to the container won't help as the source of the problem is the boot2docker VM and not the container itself.


### How does this issue affect a Symfony app?

This issue affects at least this components and features (specific vendor functions not included):

* All file-based cache operations such as `php app/console cache:clear`
* Asset installation `php app/console assets:install`
* Assetic operations `php app/console assetic:dump` or `php app/console assetic:watch`
* Uploads (e.g. into `web/uploads` etc.)
* Logging into `app/logs`
* ...


### The Workaround
  
After hours and hours of trying to fix this issue I gave up and developed an simple but kind of dirty way around this.


#### Modified AppKernel 

At first, let me say: "Yep, i know - and i'm not proud of it."

Within the app kernel we need to override the locations for the application cache `app/cache` and the logs `app/logs`.
But as we only need this modificaion within an docker environment I created an service wich will check for the `APP_CONTEXT`.
If it's set to `docker` we know we are within an docker container.


```php

    // File: app/AppKernel.php

    // ...

    /**
     * @return \Basecom\Bundle\DockerBundle\Service\Storage
     */
    protected function getStorage()
    {
        if (!$this->storage) {
            $this->storage = new \Basecom\Bundle\DockerBundle\Service\Storage($this);
        }
        return $this->storage;
    }
    
    /**
     * @return string
     */
    public function getCacheDir()
    {
        return $this->getStorage()->getCacheDir(parent::getCacheDir());
    }
    
    /**
     * @return string
     */
    public function getLogDir()
    {
        return $this->getStorage()->getLogDir(parent::getLogDir());
    }

```

If the `docker` context was found, the cache directory will be `/var/storage/cache` and the default logs directory will be `/var/storage/logs`.
If we aren't in the `docker` context the default paths beneath `app/` will be used. 


#### Modified assets and assetic handling

Just like the AppKernel changes this is done by providing an different target location for writing:

* `web/bundles` -> `/var/storage/bundles`
* `web/js` -> `/var/storage/assetic/js`
* `web/css` -> `/var/storage/assetic/css`
* `web/uploads` -> `/var/storage/shared/uploads`
* `shared` -> `/var/storage/shared` (for general data storage)

But as you can't deliver the content from the `/var/storage` we link this folders via symlinks into the storage folder.
This is done at the container startup (as root user) or by calling `assetic:dump`, `assetic:watch` or `assets:install` through the [./console][2] shortcut (as root user too).

**ATTENTION**

If we aren't in the `docker` context the default paths will be used.
If the docker symlink is still present, a command like `assets:install` will fail because the symlink refers to a folder within an container (so you have to remove the created symlinks first)!



# Please help

If you know a better way to solve this problems please feel free to create an issue or pull request!



[1]:    https://www.virtualbox.org/
[2]:    ./commands.md