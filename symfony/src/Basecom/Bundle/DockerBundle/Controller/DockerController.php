<?php

namespace Basecom\Bundle\DockerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;


/**
 * Class DockerController
 *
 * @package Basecom\Bundle\DockerBundle\Controller
 */
class DockerController extends Controller
{
    /**
     * @Route("/", name="docker_splashscreen")
     * @Template()
     */
    public function splashscreenAction()
    {
        return array();
    }
}
