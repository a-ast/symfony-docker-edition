<?php

namespace Basecom\Bundle\DockerBundle\Service;

/**
 * Class Storage
 *
 * @package Basecom\Bundle\DockerBundle\Service
 */
class Storage
{
    /**
     * @var \AppKernel
     */
    private $kernel;

    /**
     * @param \AppKernel $kernel
     */
    public function __construct(\AppKernel $kernel)
    {
        $this->kernel = $kernel;
    }

    /**
     * @return string
     */
    public function getStorageDir()
    {
        if (Context::isDocker()) {
            return '/var/storage';
        }
        return $this->kernel->getRootDir() . '/storage';
    }

    /**
     * @param string $originalDir
     *
     * @return string
     */
    public function getCacheDir($originalDir)
    {
        if (Context::isDocker()) {
            return $this->getStorageDir() . '/cache/' . $this->kernel->getEnvironment();
        }
        return $originalDir;
    }

    /**
     * @param string $originalDir
     *
     * @return string
     */
    public function getLogDir($originalDir)
    {
        if (Context::isDocker()) {
            return $this->getStorageDir() . '/logs';
        }
        return $originalDir;
    }
}
