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
-- Table structure for table `vipchannel_pago`
--

DROP TABLE IF EXISTS `vipchannel_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_pago` (
  `pagoId` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `cajeroId` int(11) NOT NULL,
  `serviciosId` int(11) NOT NULL,
  `consecutivoId` int(11) NOT NULL,
  `total` float(8,0) NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`pagoId`,`consecutivo`,`cajeroId`),
  KEY `Refvipchannel_cajero33` (`cajeroId`),
  KEY `vipchannel_pago_fk` (`serviciosId`,`consecutivoId`),
  CONSTRAINT `vipchannel_pago_fk` FOREIGN KEY (`serviciosId`, `consecutivoId`) REFERENCES `vipchannel_servicios` (`serviciosid`, `consecutivoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_pago`
--

LOCK TABLES `vipchannel_pago` WRITE;
/*!40000 ALTER TABLE `vipchannel_pago` DISABLE KEYS */;
INSERT INTO `vipchannel_pago` VALUES (1,1,2,1,1,10,1),(2,2,2,1,1,10,1);
/*!40000 ALTER TABLE `vipchannel_pago` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:13
