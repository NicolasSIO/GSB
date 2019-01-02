<?php

	namespace GSB\VisiteurBundle\Controller;
	use Symfony\Bundle\FrameworkBundle\Controller\Controller;
	use GSB\VisiteurBundle\Entity\FicheFrais;
	use Symfony\Component\HttpFoundation\Request;
        use Symfony\Component\HttpFoundation\Response;
        use GSB\VisiteurBundle\Form\FicheFraisType;
	use GSB\VisiteurBundle\Entity\Visiteur;
	use Symfony\Component\Form\Extension\Core\Type\SubmitType;
	use Symfony\Component\Form\Extension\Core\Type\DateType;

	class FicheFraisController extends Controller
{
	public function fichefraisAction(Request $query)
{
		$fichefrais = new FicheFrais();

		$form = $this->createForm(FicheFraisType::class, $fichefrais);
		$em = $this->getDoctrine()->getManager();
		
		$session = $query->getSession('levisi');
		if ($session->get('levisi')!= null){

			if ($query->isMethod('POST')) {
				$form->handleRequest($query);

					if ($form->isValid()) {

					$nbJustificatifs = $form["nbJustificatifs"]->getData();
					$session->set('nbJustificatifs',$nbJustificatifs);
					$em->persist($fichefrais);
					$em->flush();
					$query->getSession()->getFlashBag()->add('notice', 'Fiche frais enregistré.');
					
					return $this->redirect('/lignefraisforfait/ajouter');
					}
			}
		}
		else{
			return new Response("Non connecté(e)");
		}

	return $this->render('GSBVisiteurBundle:Visiteur:vueFicheFrais.html.twig',array('form'=> $form->createView(),));
}

   function listerFicheFraisAction(request $query) { 
	$ficheFrais = new FicheFrais(); 
	
	$visiteur = $this->get('session')->get('levisi')->getId();
	
	$em = $this->getDoctrine()->getManager();
        $valeur = $em->getRepository("GSBVisiteurBundle:FicheFrais")->listerFicheFrais($visiteur);
       
        return $this->render('GSBVisiteurBundle:Visiteur:vueListerFicheFrais.html.twig',array('result'=>$valeur));
	
    }

}




