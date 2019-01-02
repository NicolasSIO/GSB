<?php

namespace GSB\VisiteurBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use GSB\VisiteurBundle\Entity\Visiteur;
use Doctrine\ORM\VisiteurRepository;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\FormType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\ResetType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use GSB\VisiteurBundle\Form\VisiteurType;

class FormulaireController extends Controller{

	public function formAction(Request $query)
	{
	// On crée un objet Visiteur
	$visi = new Visiteur();
	$form = $this->createForm(VisiteurType::class, $visi);


	// Méthode d'envoi de la requête
	if ($query->isMethod('POST')) {
	$form->handleRequest($query); 

	// On vérifie que les valeurs entrées sont correctes (Nous verrons la validation des objets en détail dans le prochain chapitre)
	if ($form->isValid()) {
	// On enregistre notre objet $advert dans la base de données, par exemple
	$em = $this->getDoctrine()->getManager();
	$em->persist($visi);
	$em->flush();
	$query->getSession()->getFlashBag()->add('notice', 'Visiteur enregistré.');
	// On redirige vers la page de visualisation du visiteur créé
	return new Response('Visiteur créer');
	}
	}
	// Erreur dans le formulaire => retour vers ce dernier
	return $this->render('GSBVisiteurBundle:Visiteur:vueFormulaire.html.twig',
	array('form' => $form->createView(),));

	}
}
?>
