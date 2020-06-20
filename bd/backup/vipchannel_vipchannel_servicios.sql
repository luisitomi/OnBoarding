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
-- Table structure for table `vipchannel_servicios`
--

DROP TABLE IF EXISTS `vipchannel_servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_servicios` (
  `serviciosId` int(11) NOT NULL,
  `consecutivoId` int(11) NOT NULL,
  `detalleId` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `tecnicoId` int(11) NOT NULL,
  `fecha_instalacion` date NOT NULL,
  `fecha_instalacion_inicial` date NOT NULL,
  `hora_instalacion` time NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`serviciosId`,`consecutivoId`),
  KEY `vipchannel_servicios_fk` (`detalleId`,`consecutivo`),
  KEY `vipchannel_servicios_fk_1` (`tecnicoId`),
  CONSTRAINT `vipchannel_servicios_fk` FOREIGN KEY (`detalleId`, `consecutivo`) REFERENCES `vipchannel_detalle_cuenta` (`detalleid`, `consecutivo`),
  CONSTRAINT `vipchannel_servicios_fk_1` FOREIGN KEY (`tecnicoId`) REFERENCES `vipchannel_tecnico` (`tecnicoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_servicios`
--

LOCK TABLES `vipchannel_servicios` WRITE;
/*!40000 ALTER TABLE `vipchannel_servicios` DISABLE KEYS */;
INSERT INTO `vipchannel_servicios` VALUES (1,1,1,1,1,'2019-12-25','2019-12-25','20:00:00',1),(2,1,2,1,1,'2020-01-02','2020-01-02','20:00:00',1);
/*!40000 ALTER TABLE `vipchannel_servicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:24
