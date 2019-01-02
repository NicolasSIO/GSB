<?php

	namespace GSB\VisiteurBundle\Controller;
	use Symfony\Bundle\FrameworkBundle\Controller\Controller;
	use GSB\VisiteurBundle\Entity\LigneFraisHorsForfait;
	use Symfony\Component\HttpFoundation\Response;
	use Symfony\Component\HttpFoundation\Request;
	
        use GSB\VisiteurBundle\Form\LigneFraisHorsForfaitType;

	class LigneFraisHorsForfaitController extends Controller
{
	public function lignefraishorsforfaitAction(Request $query)
{
	$lignefraishorsforfait = new LigneFraisHorsForfait();
        $form = $this->createForm(LigneFraisHorsForfaitType::class, $lignefraishorsforfait);
	$em = $this->getDoctrine()->getManager();

	$session = $query->getSession('levisi');
	if ($session->get('levisi')!= null){

		if ($query->isMethod('POST')) {
			$form->handleRequest($query);

			if ($form->isValid()) {

	
				$em->persist($lignefraishorsforfait);
				$em->flush();
				$query->getSession()->getFlashBag()->add('notice', 'Ligne Frais hors forfait enregistré.');

				return $this->redirect('/lignefraishorsforfait/ajouter');

			}
		}
	}
	else { return new Response ("Non connecté(e)");}
	
	return $this->render('GSBVisiteurBundle:Visiteur:vueLigneFraisHorsForfait.html.twig',
	array('form' => $form->createView(),));
}
function listeLigneFraisHorsForfaitAction($fichefrais) {
            
        $em = $this->getDoctrine()->getManager();
        
        $valeur = $em->getRepository("GSBVisiteurBundle:LigneFraisHorsForfait")->listerLigneFraisHorsForfait($fichefrais);
        
        return $this->render('GSBVisiteurBundle:Visiteur:listerLigneFraisHorsForfait.html.twig',array('result'=>$valeur));
    }

}



