<?php

namespace Basecom\Bundle\DockerBundle\Service;

/**
 * Class Context
 *
 * @package Basecom\Bundle\DockerBundle\Service
 */
class Context
{
    /**
     * @return bool
     */
    public static function isDocker()
    {
        static $isDocker;
        if (null === $isDocker) {
            $isDocker = ('docker' === @getenv('APP_CONTEXT'));
        }
        return $isDocker;
    }
}