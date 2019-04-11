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
				
			$dateAJD = new \DateTime();
			$dateForm = $form["date"]->getData();

			$diff =$dateForm->diff($dateAJD);
			$interval = $diff->format('%R%a jours');
			
			if($interval> 365){
				return new Response('Trop vieux');
			}
			
			$em->persist($lignefraishorsforfait);
			$em->flush();
			$query->getSession()->getFlashBag()->add('notice', 'Ligne frais hors forfait enregistré.');

			return $this->redirect('/lignefraishorsforfait/ajouter');

			}
		}
	}
	else { return new Response ("Non connecté(e)");}
	
	return $this->render('GSBVisiteurBundle:Visiteur:vueLigneFraisHorsForfait.html.twig',
	array('form' => $form->createView(),));
}

public function lignefraishorsforfaitModifAction(Request $query,$id)
{

	 $em = $this->getDoctrine()->getManager();
	$rep = $this->getDoctrine()->getManager()->getRepository('GSBVisiteurBundle:LigneFraisHorsForfait') ;
	$lignefraishorsforfait= $rep->findOneById($id);
        $form = $this->createForm(LigneFraisHorsForfaitType::class, $lignefraishorsforfait);
	

			if ($query->isMethod('POST')) {
				$form->handleRequest($query);

				if ($form->isValid()) {
				
				
				$em->persist($lignefraishorsforfait);
				$em->flush();
				$query->getSession()->getFlashBag()->add('notice', 'Ligne Frais forfait enregistré.');
				
			return new Response ('Modification effectuée.');
		}
	
	}

	

return $this->render('GSBVisiteurBundle:Visiteur:vueLigneFraisHorsForfait.html.twig',
	array('form' => $form->createView(),));
}

function listerFraisHorsForfaitAction($fichefrais){
	$em=$this->getDoctrine()->getManager();
	$valeur= $em->getRepository("GSBVisiteurBundle:LigneFraisHorsForfait")->listerLigneFraisHorsForfait($fichefrais);
	return $this->render('GSBVisiteurBundle:Visiteur:lesLFHF.html.twig',array('result'=>$valeur));

}

function deleteFraisHorsForfaitAction($id){
	$em = $this->getDoctrine()->getEntityManager();
 	$lfhf = $em->getRepository('GSBVisiteurBundle:LigneFraisHorsForfait')->find($id);
   	 $em->remove($lfhf);
   	 $em->flush();
	return $this->redirect('/fichefrais/consulter');

}
}



