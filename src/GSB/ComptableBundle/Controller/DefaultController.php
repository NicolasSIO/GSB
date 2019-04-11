<?php

namespace GSB\ComptableBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('GSBComptableBundle:Default:index.html.twig');
    }
}
