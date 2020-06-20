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
-- Table structure for table `vipchannel_datos_vendedor`
--

DROP TABLE IF EXISTS `vipchannel_datos_vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_datos_vendedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detalleId` int(11) DEFAULT NULL,
  `documento` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `codigo` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `cliente` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `fechainicip` date DEFAULT NULL,
  `motivo` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `servicio` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `fechafinal` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `vendedor` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `activo` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `busqueda` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_datos_vendedor`
--

LOCK TABLES `vipchannel_datos_vendedor` WRITE;
/*!40000 ALTER TABLE `vipchannel_datos_vendedor` DISABLE KEYS */;
INSERT INTO `vipchannel_datos_vendedor` VALUES (407,1,'15614626','08183','JOSE LUIS LA ROSA RAMIREZ','2020-06-07','MIGRACION','CABLE','2019-12-25','HILDA ZONIA AREVALO RUIZ','INSTALADO',0),(408,2,'15614626','08183','JOSE LUIS LA ROSA RAMIREZ','2020-06-07','MIGRACION','INTERNET','2020-01-02','HILDA ZONIA AREVALO RUIZ','INSTALADO',0);
/*!40000 ALTER TABLE `vipchannel_datos_vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:28
