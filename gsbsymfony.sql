-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: symfony
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `etat`
--

DROP TABLE IF EXISTS `etat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etat` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etat`
--

LOCK TABLES `etat` WRITE;
/*!40000 ALTER TABLE `etat` DISABLE KEYS */;
INSERT INTO `etat` VALUES ('CL','Saisie clôturée'),('CR','Fiche crée, saisie en cours'),('RB','Remboursée'),('VA','Validée et mise en paiement');
/*!40000 ALTER TABLE `etat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fiche_frais`
--

DROP TABLE IF EXISTS `fiche_frais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fiche_frais` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `visiteur_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `etat_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mois` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `nbJustificatifs` int(11) NOT NULL,
  `montantValide` decimal(10,2) NOT NULL,
  `dateModif` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5FC0A6A77F72333D` (`visiteur_id`),
  KEY `IDX_5FC0A6A7D5E86FF` (`etat_id`),
  CONSTRAINT `FK_5FC0A6A77F72333D` FOREIGN KEY (`visiteur_id`) REFERENCES `visiteur` (`id`),
  CONSTRAINT `FK_5FC0A6A7D5E86FF` FOREIGN KEY (`etat_id`) REFERENCES `etat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fiche_frais`
--

LOCK TABLES `fiche_frais` WRITE;
/*!40000 ALTER TABLE `fiche_frais` DISABLE KEYS */;
INSERT INTO `fiche_frais` VALUES ('chdh','a17','CR','214224',2,58715345.00,'1980-01-01'),('dandre032019','a17','CR','042019',1,43549.00,'2019-03-01'),('dandre042019','a17','CR','042019',1,43549.00,'1980-01-01'),('dandre102010','a17','CL','202020',1,136453.00,'2019-01-01'),('dandre122012','a131','CL','012020',1,1231.00,'1980-01-01'),('dandre122018','a17','CR','012019',2,133.00,'2019-01-02');
/*!40000 ALTER TABLE `fiche_frais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frais_forfait`
--

DROP TABLE IF EXISTS `frais_forfait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frais_forfait` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `montant` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frais_forfait`
--

LOCK TABLES `frais_forfait` WRITE;
/*!40000 ALTER TABLE `frais_forfait` DISABLE KEYS */;
INSERT INTO `frais_forfait` VALUES ('ETP','Forfait Etape',110.00),('KM','Frais Kilométrique',0.62),('NUI','Nuitée Hôtel',80.00),('REP','Repas Restaurant',25.00);
/*!40000 ALTER TABLE `frais_forfait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligne_frais_forfait`
--

DROP TABLE IF EXISTS `ligne_frais_forfait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ligne_frais_forfait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fichefrais_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fraisforfait_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mois` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `quantite` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BD293ECFD318D763` (`fichefrais_id`),
  KEY `IDX_BD293ECFCEAFB3F4` (`fraisforfait_id`),
  CONSTRAINT `FK_BD293ECFCEAFB3F4` FOREIGN KEY (`fraisforfait_id`) REFERENCES `frais_forfait` (`id`),
  CONSTRAINT `FK_BD293ECFD318D763` FOREIGN KEY (`fichefrais_id`) REFERENCES `fiche_frais` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligne_frais_forfait`
--

LOCK TABLES `ligne_frais_forfait` WRITE;
/*!40000 ALTER TABLE `ligne_frais_forfait` DISABLE KEYS */;
INSERT INTO `ligne_frais_forfait` VALUES (13,'dandre122018','KM','012019',2),(14,'dandre122012','ETP','202020',123),(15,'dandre102010','ETP','202020',12),(16,'dandre032019','ETP','042019',12),(17,'chdh','ETP','545135',1351),(18,'chdh','ETP','452443',435443);
/*!40000 ALTER TABLE `ligne_frais_forfait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligne_frais_hors_forfait`
--

DROP TABLE IF EXISTS `ligne_frais_hors_forfait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ligne_frais_hors_forfait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fichefrais_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `libelle` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EC01626DD318D763` (`fichefrais_id`),
  CONSTRAINT `FK_EC01626DD318D763` FOREIGN KEY (`fichefrais_id`) REFERENCES `fiche_frais` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligne_frais_hors_forfait`
--

LOCK TABLES `ligne_frais_hors_forfait` WRITE;
/*!40000 ALTER TABLE `ligne_frais_hors_forfait` DISABLE KEYS */;
INSERT INTO `ligne_frais_hors_forfait` VALUES (3,'dandre122018','plein d\'essence','2007-01-01 00:00:00',323.00),(5,'dandre122018','egshddjgf,hgdcj,hgc,hgc,hgc54643','1980-01-01 00:00:00',99999999.99),(6,'dandre122018','egshddjgf,hgdcj,hgc,hgc,hgc54643','1980-01-01 00:00:00',99999999.99),(8,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(9,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(10,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(11,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(12,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(13,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(14,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(15,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(16,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(17,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(18,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(19,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(20,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(21,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(22,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(23,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(24,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(25,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(26,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(27,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(28,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(29,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(30,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(31,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(32,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(33,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(34,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(35,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(36,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(37,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(38,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(39,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(40,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(41,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(42,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(43,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(44,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(45,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(46,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(47,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(48,'dandre122018','azeazeazeazeaeazeaze','1980-01-01 00:00:00',99999999.99),(49,'dandre122018','azeazeazeazeaeazeaze','1980-01-10 00:00:00',99999999.99),(50,'dandre122018','azeazeazeazeaeazeaze','1980-01-28 00:00:00',99999999.99),(51,'dandre122018','azeazeazeazeaeazeaze','1980-01-10 00:00:00',99999999.99),(52,'dandre122018','azeazeazeazeaeazeaze','1980-01-16 00:00:00',99999999.99),(53,'dandre122018','azeazeazeazeaeazeaze','1980-01-27 00:00:00',99999999.99),(54,'dandre122018','azeazeazeazeaeazeaze','1980-01-25 00:00:00',99999999.99),(55,'dandre122018','azeazeazeazeaeazeaze','1980-01-25 00:00:00',99999999.99),(56,'dandre122018','azeazeazeazeaeazeaze','1980-01-25 00:00:00',99999999.99),(57,'dandre122018','azeazeazeazeaeazeaze','2019-03-15 00:00:00',99999999.99),(58,'dandre122018','azeazeazeazeaeazeaze','2019-02-15 00:00:00',99999999.99),(59,'dandre122012','zelfhygqzliugfqzeiluf','2019-01-01 00:00:00',2132135.00),(60,'dandre032019','xdfbklxjbn','2019-01-01 00:00:00',354354.00),(61,'chdh','543842584354','2025-01-01 00:00:00',99999999.99);
/*!40000 ALTER TABLE `ligne_frais_hors_forfait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visiteur`
--

DROP TABLE IF EXISTS `visiteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visiteur` (
  `id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `nom` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `prenom` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `login` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `mdp` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `adresse` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cp` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `ville` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `dateEmbauche` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4EA587B8AA08CB10` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visiteur`
--

LOCK TABLES `visiteur` WRITE;
/*!40000 ALTER TABLE `visiteur` DISABLE KEYS */;
INSERT INTO `visiteur` VALUES ('a131','Villechalane','Louis','lvillechalane','jux7g','8 rue des Charmes','46000','Cahors','2005-12-21'),('a17','Andre','David','dandre','oppg5','1 rue Petit','46200','Lalbenque','1998-11-23'),('a55','Bedos','Christian','cbedos','gmhxd','1 rue Peranud','46250','Montcuq','1995-01-12'),('a93','Tusseau','Louis','ltusseau','ktp3s','22 rue des Ternes','46123','Gramat','2000-05-01'),('b13','Bentot','Pascal','pbentot','doyw1','11 allée des Cerises','46512','Bessines','1992-07-09'),('b16','Bioret','Luc','lbioret','hrjfs','1 Avenue gambetta','46000','Cahors','1998-05-11'),('b19','Bunisset','Francis','fbunisset','4fbnd','10 rue des Perles','93100','Montreuil','1987-10-21'),('b25','Bunisset','Denise','dbunisset','s1y1r','23 rue Manin','75019','Paris','2010-12-05');
/*!40000 ALTER TABLE `visiteur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-11 14:51:06
