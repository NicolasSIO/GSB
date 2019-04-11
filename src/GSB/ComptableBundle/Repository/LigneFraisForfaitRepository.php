<?php

namespace GSB\ComptableBundle\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\Expr\Join;

/**
 * LigneFraisForfaitRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class LigneFraisForfaitRepository extends \Doctrine\ORM\EntityRepository
{ 
    function listerLigneFraisForfait($fichefrais)
    {
    $qb = $this->_em->createQueryBuilder();
    $qb->select('v')
    ->from('GSBVisiteurBundle:LigneFraisForfait', 'v')
    ->where ($qb->expr()->eq('v.fichefrais',':val'))
    ->setParameter('val',$fichefrais);
    $query = $qb->getQuery();
    $resultat = $query->getResult();
    return $resultat;
    }
    
    function modifierLigneFraisForfait($fichefrais, $mois, $quantite)
    {
    $qb = $this->_em->createQueryBuilder('v');
    
    $qb->update('GSBVisiteurBundle:LigneFraisForfait','v')
    ->set('v.quantite',$quantite)
    ->set('v.mois',$mois)
    ->where ('v.fichefrais = :val')
    ->setParameter('val',$fichefrais);
    
    $query = $qb->getQuery();
            
    $resultat = $query->getResult();
    
    return $resultat;
    }
    
    
}