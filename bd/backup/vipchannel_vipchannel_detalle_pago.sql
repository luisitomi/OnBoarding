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
-- Table structure for table `vipchannel_detalle_pago`
--

DROP TABLE IF EXISTS `vipchannel_detalle_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_detalle_pago` (
  `detalleId` int(11) NOT NULL AUTO_INCREMENT,
  `pagoId` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `cajeroId` int(11) NOT NULL,
  `tipoId` int(11) NOT NULL,
  `calendarioId` int(11) DEFAULT NULL,
  `fechaId` int(11) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `monto` float(8,0) NOT NULL,
  `serie` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gestor` int(11) DEFAULT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`detalleId`),
  KEY `Refvipchannel_calendario41` (`fechaId`),
  KEY `Refvipchannel_calendario39` (`calendarioId`),
  KEY `Refvipchannel_tipo_pago38` (`tipoId`),
  KEY `Refvipchannel_pago37` (`pagoId`,`consecutivo`,`cajeroId`),
  CONSTRAINT `vipchannel_detalle_pago_fk` FOREIGN KEY (`pagoId`, `consecutivo`, `cajeroId`) REFERENCES `vipchannel_pago` (`pagoid`, `consecutivo`, `cajeroid`),
  CONSTRAINT `vipchannel_detalle_pago_fk_1` FOREIGN KEY (`fechaId`) REFERENCES `vipchannel_calendario` (`calendarioid`),
  CONSTRAINT `vipchannel_detalle_pago_fk_2` FOREIGN KEY (`tipoId`) REFERENCES `vipchannel_tipo_pago` (`tipoid`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_detalle_pago`
--

LOCK TABLES `vipchannel_detalle_pago` WRITE;
/*!40000 ALTER TABLE `vipchannel_detalle_pago` DISABLE KEYS */;
INSERT INTO `vipchannel_detalle_pago` VALUES (21,1,1,2,1,3,219,1,10,'B002 N 1',0,1),(22,2,2,2,1,3,221,1,10,'B002 N 2',0,1);
/*!40000 ALTER TABLE `vipchannel_detalle_pago` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:15
