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
-- Table structure for table `vipchannel_detalle_cuenta_deuda`
--

DROP TABLE IF EXISTS `vipchannel_detalle_cuenta_deuda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_detalle_cuenta_deuda` (
  `deudaId` int(11) NOT NULL AUTO_INCREMENT,
  `detalleId` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `servicioId` int(11) NOT NULL,
  `monto` float(8,0) NOT NULL,
  `monto_restante` decimal(10,2) DEFAULT NULL,
  `mes` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`deudaId`),
  KEY `Refvipchannel_detalle_cuenta46` (`detalleId`,`consecutivo`),
  KEY `Refvipchannel_servicio47` (`servicioId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='estado = 3';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_detalle_cuenta_deuda`
--

LOCK TABLES `vipchannel_detalle_cuenta_deuda` WRITE;
/*!40000 ALTER TABLE `vipchannel_detalle_cuenta_deuda` DISABLE KEYS */;
/*!40000 ALTER TABLE `vipchannel_detalle_cuenta_deuda` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-29  0:15:44
