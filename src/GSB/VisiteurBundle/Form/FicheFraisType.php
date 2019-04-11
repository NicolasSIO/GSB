<?php

namespace GSB\VisiteurBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\ResetType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Validator\Mapping\ClassMetadata;
use Symfony\Component\Validator\Constraints as Assert;
use GSB\VisiteurBundle\Entity\Visiteur;
use GSB\VisiteurBundle\Entity\Etat;
use Symfony\Component\HttpFoundation\Session\Session;
use Doctrine\ORM\EntityRepository;


use Symfony\Bridge\Doctrine\Form\Type\EntityType;

class FicheFraisType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
	$session = new Session();
	$nom= $session->get('levisi')->getNom();

        $builder->add('id', TextType::class)
	->add('mois', TextType::class)
	->add('nbJustificatifs', IntegerType::class)
        ->add('montantValide', MoneyType::class)
        ->add('visiteur', EntityType::class, array('class'=> 'GSBVisiteurBundle:Visiteur',
                       'query_builder' => function (EntityRepository $er) use ($nom) {
                        return $er->createQueryBuilder('v')
                       ->where('v.nom = :nom')
                       ->setParameter('nom', $nom)   
                       ->orderBy('v.nom', 'ASC'); }
                    ,'choice_label' => 'nom'
                    ,'multiple'  => false
                    ,'required' => true
                    ,'placeholder' => '--- Choisir un visiteur ---'
                    ,'choice_label' => 'nom' ))
        ->add('etat', EntityType::class, array('class'=> Etat::class,'choice_label' => 'libelle'))      
        ->add('dateModif', DateType::class,array('years'=>range(1980,2030), 'format'=>'dd-MM-yyyy')) 
	->add('Annuler', ResetType::class)
	->add('Enregistrer', SubmitType::class);
    }
    
    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'GSB\VisiteurBundle\Entity\FicheFrais'
        ));
    }


    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'gsb_visiteurbundle_fichefrais';
    }


}
