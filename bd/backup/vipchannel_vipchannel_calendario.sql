-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: vipchannel
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `vipchannel_calendario`
--

DROP TABLE IF EXISTS `vipchannel_calendario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_calendario` (
  `calendarioId` int(11) NOT NULL AUTO_INCREMENT,
  `mesid` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `semana` int(11) DEFAULT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  PRIMARY KEY (`calendarioId`)
) ENGINE=MyISAM AUTO_INCREMENT=367 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_calendario`
--

LOCK TABLES `vipchannel_calendario` WRITE;
/*!40000 ALTER TABLE `vipchannel_calendario` DISABLE KEYS */;
INSERT INTO `vipchannel_calendario` VALUES (1,1,1,11,2019,0,0,0),(2,1,2,11,2019,0,0,0),(3,1,1,11,2019,0,0,0),(4,1,4,11,2019,0,0,0),(5,1,5,11,2019,0,0,0),(6,1,6,11,2019,0,0,0),(7,1,7,11,2019,0,0,0),(8,1,8,11,2019,0,0,0),(9,1,9,11,2019,0,0,0),(10,1,10,11,2019,0,0,0),(11,1,11,11,2019,0,0,0),(12,1,12,11,2019,0,0,0),(13,1,13,11,2019,0,0,0),(14,1,14,11,2019,0,0,0),(15,1,15,11,2019,0,0,0),(16,1,16,11,2019,0,0,0),(17,1,17,11,2019,0,0,0),(18,1,18,11,2019,0,0,0),(19,1,19,11,2019,0,0,0),(20,1,20,11,2019,0,0,0),(21,1,21,11,2019,0,0,0),(22,1,22,11,2019,0,0,0),(23,1,23,11,2019,0,0,0),(24,1,24,11,2019,0,0,0),(25,1,25,11,2019,0,0,0),(26,1,26,11,2019,0,0,0),(27,1,27,11,2019,0,0,0),(28,1,28,11,2019,0,0,0),(29,1,29,11,2019,0,0,0),(30,1,30,11,2019,0,0,0),(31,2,1,12,2019,0,0,0),(32,2,2,12,2019,0,0,0),(33,2,3,12,2019,0,0,0),(34,2,4,12,2019,0,0,0),(35,2,5,12,2019,0,0,0),(36,2,6,12,2019,0,0,0),(37,2,7,12,2019,0,0,0),(38,2,8,12,2019,0,0,0),(39,2,9,12,2019,0,0,0),(40,2,10,12,2019,0,0,0),(41,2,11,12,2019,0,0,0),(42,2,12,12,2019,0,0,0),(43,2,13,12,2019,0,0,0),(44,2,14,12,2019,0,0,0),(45,2,15,12,2019,0,0,0),(46,2,16,12,2019,0,0,0),(47,2,17,12,2019,0,0,0),(48,2,18,12,2019,0,0,0),(49,2,19,12,2019,0,0,0),(50,2,20,12,2019,0,0,0),(51,2,21,12,2019,0,0,0),(52,2,22,12,2019,0,0,0),(53,2,23,12,2019,0,0,0),(54,2,24,12,2019,0,0,0),(55,2,25,12,2019,0,0,0),(56,2,26,12,2019,0,0,0),(57,2,27,12,2019,0,0,0),(58,2,28,12,2019,0,0,0),(59,2,29,12,2019,0,0,0),(60,2,30,12,2019,0,0,0),(61,2,31,12,2019,0,0,0),(62,3,1,1,2020,0,0,0),(63,3,2,1,2020,0,0,0),(64,3,3,1,2020,0,0,0),(65,3,4,1,2020,0,0,0),(66,3,5,1,2020,0,0,0),(67,3,6,1,2020,0,0,0),(68,3,7,1,2020,0,0,0),(69,3,8,1,2020,0,0,0),(70,3,9,1,2020,0,0,0),(71,3,10,1,2020,0,0,0),(72,3,11,1,2020,0,0,0),(73,3,12,1,2020,0,0,0),(74,3,13,1,2020,0,0,0),(75,3,14,1,2020,0,0,0),(76,3,15,1,2020,0,0,0),(77,3,16,1,2020,0,0,0),(78,3,17,1,2020,0,0,0),(79,3,18,1,2020,0,0,0),(80,3,19,1,2020,0,0,0),(81,3,20,1,2020,0,0,0),(82,3,21,1,2020,0,0,0),(83,3,22,1,2020,0,0,0),(84,3,23,1,2020,0,0,0),(85,3,24,1,2020,0,0,0),(86,3,25,1,2020,0,0,0),(87,3,26,1,2020,0,0,0),(88,3,27,1,2020,0,0,0),(89,3,28,1,2020,0,0,0),(90,3,29,1,2020,0,0,0),(91,3,30,1,2020,0,0,0),(92,3,31,1,2020,0,0,0),(93,4,1,2,2020,0,0,0),(94,4,2,2,2020,0,0,0),(95,4,3,2,2020,0,0,0),(96,4,4,2,2020,0,0,0),(97,4,5,2,2020,0,0,0),(98,4,6,2,2020,0,0,0),(99,4,7,2,2020,0,0,0),(100,4,8,2,2020,0,0,0),(101,4,9,2,2020,0,0,0),(102,4,10,2,2020,0,0,0),(103,4,11,2,2020,0,0,0),(104,4,12,2,2020,0,0,0),(105,4,13,2,2020,0,0,0),(106,4,14,2,2020,0,0,0),(107,4,15,2,2020,0,0,0),(108,4,16,2,2020,0,0,0),(109,4,17,2,2020,0,0,0),(110,4,18,2,2020,0,0,0),(111,4,19,2,2020,0,0,0),(112,4,20,2,2020,0,0,0),(113,4,21,2,2020,0,0,0),(114,4,22,2,2020,0,0,0),(115,4,23,2,2020,0,0,0),(116,4,24,2,2020,0,0,0),(117,4,25,2,2020,0,0,0),(118,4,26,2,2020,0,0,0),(119,4,27,2,2020,0,0,0),(120,4,28,2,2020,0,0,0),(121,4,29,2,2020,0,0,0),(122,5,1,3,2020,0,0,0),(123,5,2,3,2020,0,0,0),(124,5,3,3,2020,0,0,0),(125,5,4,3,2020,0,0,0),(126,5,5,3,2020,0,0,0),(127,5,6,3,2020,0,0,0),(128,5,7,3,2020,0,0,0),(129,5,8,3,2020,0,0,0),(130,5,9,3,2020,0,0,0),(131,5,10,3,2020,0,0,0),(132,5,11,3,2020,0,0,0),(133,5,12,3,2020,0,0,0),(134,5,13,3,2020,0,0,0),(135,5,14,3,2020,0,0,0),(136,5,15,3,2020,0,0,0),(137,5,16,3,2020,0,0,0),(138,5,17,3,2020,0,0,0),(139,5,18,3,2020,0,0,0),(140,5,19,3,2020,0,0,0),(141,5,20,3,2020,0,0,0),(142,5,21,3,2020,0,0,0),(143,5,22,3,2020,0,0,0),(144,5,23,3,2020,0,0,0),(145,5,24,3,2020,0,0,0),(146,5,25,3,2020,0,0,0),(147,5,26,3,2020,0,0,0),(148,5,27,3,2020,0,0,0),(149,5,28,3,2020,0,0,0),(150,5,29,3,2020,0,0,0),(151,5,30,3,2020,0,0,0),(152,5,31,3,2020,0,0,0),(153,6,1,4,2020,0,0,0),(154,6,2,4,2020,0,0,0),(155,6,3,4,2020,0,0,0),(156,6,4,4,2020,0,0,0),(157,6,5,4,2020,0,0,0),(158,6,6,4,2020,0,0,0),(159,6,7,4,2020,0,0,0),(160,6,8,4,2020,0,0,0),(161,6,9,4,2020,0,0,0),(162,6,10,4,2020,0,0,0),(163,6,11,4,2020,0,0,0),(164,6,12,4,2020,0,0,0),(165,6,13,4,2020,0,0,0),(166,6,14,4,2020,0,0,0),(167,6,15,4,2020,0,0,0),(168,6,16,4,2020,0,0,0),(169,6,17,4,2020,0,0,0),(170,6,18,4,2020,0,0,0),(171,6,19,4,2020,0,0,0),(172,6,20,4,2020,0,0,0),(173,6,21,4,2020,0,0,0),(174,6,22,4,2020,0,0,0),(175,6,23,4,2020,0,0,0),(176,6,24,4,2020,0,0,0),(177,6,25,4,2020,0,0,0),(178,6,26,4,2020,0,0,0),(179,6,27,4,2020,0,0,0),(180,6,28,4,2020,0,0,0),(181,6,29,4,2020,0,0,0),(182,6,30,4,2020,0,0,0),(183,7,1,5,2020,0,0,0),(184,7,2,5,2020,0,0,0),(185,7,3,5,2020,0,0,0),(186,7,4,5,2020,0,0,0),(187,7,5,5,2020,0,0,0),(188,7,6,5,2020,0,0,0),(189,7,7,5,2020,0,0,0),(190,7,8,5,2020,0,0,0),(191,7,9,5,2020,0,0,0),(192,7,10,5,2020,0,0,0),(193,7,11,5,2020,0,0,0),(194,7,12,5,2020,0,0,0),(195,7,13,5,2020,0,0,0),(196,7,14,5,2020,0,0,0),(197,7,15,5,2020,0,0,0),(198,7,16,5,2020,0,0,0),(199,7,17,5,2020,0,0,0),(200,7,18,5,2020,0,0,0),(201,7,19,5,2020,0,0,0),(202,7,20,5,2020,0,0,0),(203,7,21,5,2020,0,0,0),(204,7,22,5,2020,0,0,0),(205,7,23,5,2020,0,0,0),(206,7,24,5,2020,0,0,0),(207,7,25,5,2020,0,0,0),(208,7,26,5,2020,0,0,0),(209,7,27,5,2020,0,0,0),(210,7,28,5,2020,0,0,0),(211,7,29,5,2020,0,0,0),(212,7,30,5,2020,0,0,0),(213,7,31,5,2020,0,0,0),(214,8,1,6,2020,0,0,0),(215,8,2,6,2020,0,0,0),(216,8,3,6,2020,0,0,0),(217,8,4,6,2020,0,0,0),(218,8,5,6,2020,0,0,0),(219,8,6,6,2020,0,0,0),(220,8,7,6,2020,0,0,0),(221,8,8,6,2020,0,0,0),(222,8,9,6,2020,0,0,0),(223,8,10,6,2020,0,0,0),(224,8,11,6,2020,0,0,0),(225,8,12,6,2020,0,0,0),(226,8,13,6,2020,0,0,0),(227,8,14,6,2020,0,0,0),(228,8,15,6,2020,0,0,0),(229,8,16,6,2020,0,0,0),(230,8,17,6,2020,0,0,0),(231,8,18,6,2020,0,0,0),(232,8,19,6,2020,0,0,0),(233,8,20,6,2020,0,0,0),(234,8,21,6,2020,0,0,0),(235,8,22,6,2020,0,0,0),(236,8,23,6,2020,0,0,0),(237,8,24,6,2020,0,0,0),(238,8,25,6,2020,0,0,0),(239,8,26,6,2020,0,0,0),(240,8,27,6,2020,0,0,0),(241,8,28,6,2020,0,0,0),(242,8,29,6,2020,0,0,0),(243,8,30,6,2020,0,0,0),(244,9,1,7,2020,0,0,0),(245,9,2,7,2020,0,0,0),(246,9,3,7,2020,0,0,0),(247,9,4,7,2020,0,0,0),(248,9,5,7,2020,0,0,0),(249,9,6,7,2020,0,0,0),(250,9,7,7,2020,0,0,0),(251,9,8,7,2020,0,0,0),(252,9,9,7,2020,0,0,0),(253,9,10,7,2020,0,0,0),(254,9,11,7,2020,0,0,0),(255,9,12,7,2020,0,0,0),(256,9,13,7,2020,0,0,0),(257,9,14,7,2020,0,0,0),(258,9,15,7,2020,0,0,0),(259,9,16,7,2020,0,0,0),(260,9,17,7,2020,0,0,0),(261,9,18,7,2020,0,0,0),(262,9,19,7,2020,0,0,0),(263,9,20,7,2020,0,0,0),(264,9,21,7,2020,0,0,0),(265,9,22,7,2020,0,0,0),(266,9,23,7,2020,0,0,0),(267,9,24,7,2020,0,0,0),(268,9,25,7,2020,0,0,0),(269,9,26,7,2020,0,0,0),(270,9,27,7,2020,0,0,0),(271,9,28,7,2020,0,0,0),(272,9,29,7,2020,0,0,0),(273,9,30,7,2020,0,0,0),(274,9,31,7,2020,0,0,0),(275,10,1,8,2020,0,0,0),(276,10,2,8,2020,0,0,0),(277,10,3,8,2020,0,0,0),(278,10,4,8,2020,0,0,0),(279,10,5,8,2020,0,0,0),(280,10,6,8,2020,0,0,0),(281,10,7,8,2020,0,0,0),(282,10,8,8,2020,0,0,0),(283,10,9,8,2020,0,0,0),(284,10,10,8,2020,0,0,0),(285,10,11,8,2020,0,0,0),(286,10,12,8,2020,0,0,0),(287,10,13,8,2020,0,0,0),(288,10,14,8,2020,0,0,0),(289,10,15,8,2020,0,0,0),(290,10,16,8,2020,0,0,0),(291,10,17,8,2020,0,0,0),(292,10,18,8,2020,0,0,0),(293,10,19,8,2020,0,0,0),(294,10,20,8,2020,0,0,0),(295,10,21,8,2020,0,0,0),(296,10,22,8,2020,0,0,0),(297,10,23,8,2020,0,0,0),(298,10,24,8,2020,0,0,0),(299,10,25,8,2020,0,0,0),(300,10,26,8,2020,0,0,0),(301,10,27,8,2020,0,0,0),(302,10,28,8,2020,0,0,0),(303,10,29,8,2020,0,0,0),(304,10,30,8,2020,0,0,0),(305,10,31,8,2020,0,0,0),(306,11,1,9,2020,0,0,0),(307,11,2,9,2020,0,0,0),(308,11,3,9,2020,0,0,0),(309,11,4,9,2020,0,0,0),(310,11,5,9,2020,0,0,0),(311,11,6,9,2020,0,0,0),(312,11,7,9,2020,0,0,0),(313,11,8,9,2020,0,0,0),(314,11,9,9,2020,0,0,0),(315,11,10,9,2020,0,0,0),(316,11,11,9,2020,0,0,0),(317,11,12,9,2020,0,0,0),(318,11,13,9,2020,0,0,0),(319,11,14,9,2020,0,0,0),(320,11,15,9,2020,0,0,0),(321,11,16,9,2020,0,0,0),(322,11,17,9,2020,0,0,0),(323,11,18,9,2020,0,0,0),(324,11,19,9,2020,0,0,0),(325,11,20,9,2020,0,0,0),(326,11,21,9,2020,0,0,0),(327,11,22,9,2020,0,0,0),(328,11,23,9,2020,0,0,0),(329,11,24,9,2020,0,0,0),(330,11,25,9,2020,0,0,0),(331,11,26,9,2020,0,0,0),(332,11,27,9,2020,0,0,0),(333,11,28,9,2020,0,0,0),(334,11,29,9,2020,0,0,0),(335,11,30,9,2020,0,0,0),(336,12,1,10,2020,0,0,0),(337,12,2,10,2020,0,0,0),(338,12,3,10,2020,0,0,0),(339,12,4,10,2020,0,0,0),(340,12,5,10,2020,0,0,0),(341,12,6,10,2020,0,0,0),(342,12,7,10,2020,0,0,0),(343,12,8,10,2020,0,0,0),(344,12,9,10,2020,0,0,0),(345,12,10,10,2020,0,0,0),(346,12,11,10,2020,0,0,0),(347,12,12,10,2020,0,0,0),(348,12,13,10,2020,0,0,0),(349,12,14,10,2020,0,0,0),(350,12,15,10,2020,0,0,0),(351,12,16,10,2020,0,0,0),(352,12,17,10,2020,0,0,0),(353,12,18,10,2020,0,0,0),(354,12,19,10,2020,0,0,0),(355,12,20,10,2020,0,0,0),(356,12,21,10,2020,0,0,0),(357,12,22,10,2020,0,0,0),(358,12,23,10,2020,0,0,0),(359,12,24,10,2020,0,0,0),(360,12,25,10,2020,0,0,0),(361,12,26,10,2020,0,0,0),(362,12,27,10,2020,0,0,0),(363,12,28,10,2020,0,0,0),(364,12,29,10,2020,0,0,0),(365,12,30,10,2020,0,0,0),(366,12,31,10,2020,0,0,0);
/*!40000 ALTER TABLE `vipchannel_calendario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-29  0:15:42
