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
-- Table structure for table `vipchannel_detalle_cuenta`
--

DROP TABLE IF EXISTS `vipchannel_detalle_cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_detalle_cuenta` (
  `detalleId` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `servicioId` int(11) NOT NULL,
  `cuentaId` int(11) NOT NULL,
  `consecutivoId` int(11) NOT NULL,
  `tipoId` int(11) NOT NULL,
  `comprobanteId` int(11) NOT NULL,
  `instalacionId` int(11) NOT NULL,
  `mensualidad_mensual` float(8,0) NOT NULL,
  `mensualidad_primera` float(8,0) NOT NULL,
  `mensualidad_mes_instalacion` float(8,0) NOT NULL,
  `motivo_instalacion` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `motivo_corte` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `motivo_cancelacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`detalleId`,`consecutivo`),
  KEY `Refvipchannel_cuenta19` (`cuentaId`,`consecutivoId`),
  KEY `Refvipchannel_servicio20` (`servicioId`),
  KEY `Refvipchannel_tipo22` (`tipoId`),
  KEY `Refvipchannel_comprobante26` (`comprobanteId`),
  KEY `Refvipchannel_instalacion32` (`instalacionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_detalle_cuenta`
--

LOCK TABLES `vipchannel_detalle_cuenta` WRITE;
/*!40000 ALTER TABLE `vipchannel_detalle_cuenta` DISABLE KEYS */;
INSERT INTO `vipchannel_detalle_cuenta` VALUES (2,1,2,1,1,2,1,1,22,0,0,'','','',1),(1,1,1,1,1,3,1,1,28,0,0,'','','',1);
/*!40000 ALTER TABLE `vipchannel_detalle_cuenta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-29  0:15:55
