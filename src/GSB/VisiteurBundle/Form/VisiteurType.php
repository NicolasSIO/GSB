<?php

namespace GSB\VisiteurBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
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

class VisiteurType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
	->add('id',TextType::class)
	->add('nom', TextType::class)
	->add('prenom', TextType::class)
	->add('login', TextType::class)
	->add('mdp', PasswordType::class)
	->add('adresse', TextType::class)
	->add('cp', TextType::class)
	->add('ville', TextType::class)
	->add('dateEmbauche', DateType::class, array('years'=>range(1980,2020), 'format'=> 'dd-MM-yyyy'))
	->add('Annuler', ResetType::class)
	->add('Enregistrer', SubmitType::class)
	->getForm();
    }
    
    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'GSB\VisiteurBundle\Entity\Visiteur'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'gsb_visiteurbundle_visiteur';
    }


}
