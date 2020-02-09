-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: db_aviation
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `db_aviation`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_aviation` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_aviation`;

--
-- Table structure for table `compagnies`
--

DROP TABLE IF EXISTS `compagnies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compagnies` (
  `comp` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numStreet` tinyint(3) unsigned DEFAULT NULL,
  `status` enum('published','unpublished','draft') COLLATE utf8mb4_unicode_ci DEFAULT 'draft',
  PRIMARY KEY (`comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compagnies`
--

LOCK TABLES `compagnies` WRITE;
/*!40000 ALTER TABLE `compagnies` DISABLE KEYS */;
INSERT INTO `compagnies` VALUES ('AUS','sidney','Australie','AUSTRA Air',19,'draft'),('CHI','chi','Chine','CHINA Air',NULL,'draft'),('FRE1','beaubourg','France','Air France',17,'draft'),('FRE2','paris','France','Air Electric',22,'draft'),('ITA','mapoli','Rome','Italia Air',20,'draft'),('PILL',NULL,NULL,'pillili',NULL,'draft'),('SIN','pasir','Singapour','SIN A',15,'draft');
/*!40000 ALTER TABLE `compagnies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilot_trip`
--

DROP TABLE IF EXISTS `pilot_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilot_trip` (
  `certificate` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trip_id` int(6) unsigned DEFAULT NULL,
  KEY `fk_certificate_pilots` (`certificate`),
  KEY `fk_id_trips` (`trip_id`),
  CONSTRAINT `fk_certificate_pilots` FOREIGN KEY (`certificate`) REFERENCES `pilots` (`certificate`),
  CONSTRAINT `fk_id_trips` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilot_trip`
--

LOCK TABLES `pilot_trip` WRITE;
/*!40000 ALTER TABLE `pilot_trip` DISABLE KEYS */;
INSERT INTO `pilot_trip` VALUES ('ct-10',1),('ct-6',2),('ct-100',1),('ct-11',3),('ct-12',4),('ct-10',4),('ct-12',5);
/*!40000 ALTER TABLE `pilot_trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilots`
--

DROP TABLE IF EXISTS `pilots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilots` (
  `certificate` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lead_pl` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numFlying` decimal(7,1) DEFAULT NULL,
  `compagny` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bonus` decimal(5,1) DEFAULT NULL,
  `num_jobs` tinyint(3) unsigned DEFAULT NULL,
  `next_flight` datetime DEFAULT NULL,
  `birth_date` datetime DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `plane_id` int(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`certificate`),
  UNIQUE KEY `un_name` (`name`),
  KEY `fk_pilots_compagny` (`compagny`),
  KEY `lead_pl` (`lead_pl`),
  KEY `fk_pilots_planes` (`plane_id`),
  CONSTRAINT `fk_pilots_compagny` FOREIGN KEY (`compagny`) REFERENCES `compagnies` (`comp`),
  CONSTRAINT `fk_pilots_planes` FOREIGN KEY (`plane_id`) REFERENCES `planes` (`id`),
  CONSTRAINT `pilots_ibfk_1` FOREIGN KEY (`lead_pl`) REFERENCES `pilots` (`certificate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilots`
--

LOCK TABLES `pilots` WRITE;
/*!40000 ALTER TABLE `pilots` DISABLE KEYS */;
INSERT INTO `pilots` VALUES ('ct-1','ct-7',90.0,'AUS','Alan',1000.0,NULL,NULL,NULL,'2020-02-09 13:40:27',3),('ct-10','ct-7',90.0,'FRE1','Tom',500.0,NULL,NULL,NULL,'2020-02-09 13:40:27',1),('ct-100','ct-7',200.0,'SIN','Yi',500.0,NULL,NULL,NULL,'2020-02-09 13:40:27',2),('ct-11','ct-6',200.0,'AUS','Sophie',1000.0,NULL,NULL,NULL,'2020-02-09 13:40:27',3),('ct-12','ct-6',190.0,'AUS','Albert',1000.0,NULL,NULL,NULL,'2020-02-09 13:40:27',3),('ct-16','ct-6',190.0,'SIN','Yan',500.0,NULL,NULL,NULL,'2020-02-09 13:40:27',2),('ct-56',NULL,300.0,'AUS','Benoit',2000.0,NULL,NULL,NULL,'2020-02-09 13:40:27',3),('ct-6',NULL,20.0,'FRE1','Jhon',500.0,NULL,NULL,NULL,'2020-02-09 13:40:27',1),('ct-7',NULL,80.0,'CHI','Pierre',500.0,NULL,NULL,NULL,'2020-02-09 13:40:27',1);
/*!40000 ALTER TABLE `pilots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes`
--

DROP TABLE IF EXISTS `planes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planes` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(5) CHARACTER SET latin1 DEFAULT NULL,
  `description` text CHARACTER SET latin1,
  `numFlying` decimal(8,1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes`
--

LOCK TABLES `planes` WRITE;
/*!40000 ALTER TABLE `planes` DISABLE KEYS */;
INSERT INTO `planes` VALUES (1,'A380','Gros porteur',12000.0),(2,'A320','Avion de ligne quadriréacteur',17000.0),(3,'A340','Moyen Courrier',50000.0);
/*!40000 ALTER TABLE `planes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trips`
--

DROP TABLE IF EXISTS `trips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trips` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departure` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrival` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trips`
--

LOCK TABLES `trips` WRITE;
/*!40000 ALTER TABLE `trips` DISABLE KEYS */;
INSERT INTO `trips` VALUES (1,'direct','Paris','Brest','2020-01-01 00:00:00'),(2,'direct','Paris','Berlin','2020-02-01 00:00:00'),(3,'direct','Paris','Barcelone','2020-08-01 00:00:00'),(4,'direct','Amsterdan','Brest','2020-11-11 00:00:00'),(5,'direct','Alger','Paris','2020-09-01 00:00:00'),(6,'direct','Brest','Paris','2020-12-01 00:00:00');
/*!40000 ALTER TABLE `trips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-09 19:53:08
