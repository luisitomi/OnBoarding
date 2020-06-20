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
-- Table structure for table `vipchannel_correlativo`
--

DROP TABLE IF EXISTS `vipchannel_correlativo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_correlativo` (
  `correlativoId` int(11) NOT NULL AUTO_INCREMENT,
  `cajeroId` int(11) NOT NULL,
  `comprobanteid` int(11) NOT NULL,
  `activo` int(11) DEFAULT NULL,
  `valor` int(11) NOT NULL,
  PRIMARY KEY (`correlativoId`),
  KEY `Refvipchannel_cajero43` (`cajeroId`),
  KEY `vipchannel_correlativo_fk` (`comprobanteid`),
  CONSTRAINT `vipchannel_correlativo_fk` FOREIGN KEY (`comprobanteid`) REFERENCES `vipchannel_comprobante` (`comprobanteid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_correlativo`
--

LOCK TABLES `vipchannel_correlativo` WRITE;
/*!40000 ALTER TABLE `vipchannel_correlativo` DISABLE KEYS */;
INSERT INTO `vipchannel_correlativo` VALUES (1,1,1,1,2),(2,1,2,1,1),(3,1,3,1,1),(4,2,1,1,3),(5,2,2,1,1),(6,2,3,1,1),(7,3,1,1,1),(8,3,2,1,1),(9,3,3,1,1);
/*!40000 ALTER TABLE `vipchannel_correlativo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:33
