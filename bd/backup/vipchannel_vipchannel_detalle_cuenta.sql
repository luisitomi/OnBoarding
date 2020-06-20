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
  `mensualidad_mensual` float(8,2) NOT NULL,
  `mensualidad_primera` float(8,2) NOT NULL,
  `mensualidad_mes_instalacion` float(8,2) NOT NULL,
  `fecha_pactada` date DEFAULT NULL,
  `motivo_instalacion` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `motivo_corte` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `motivo_cancelacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `vendedorid` int(11) DEFAULT NULL,
  `venta` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`detalleId`,`consecutivo`),
  KEY `Refvipchannel_cuenta19` (`cuentaId`,`consecutivoId`),
  KEY `Refvipchannel_servicio20` (`servicioId`),
  KEY `Refvipchannel_tipo22` (`tipoId`),
  KEY `Refvipchannel_comprobante26` (`comprobanteId`),
  KEY `Refvipchannel_instalacion32` (`instalacionId`),
  KEY `vipchannel_detalle_cuenta_fk` (`vendedorid`),
  CONSTRAINT `vipchannel_detalle_cuenta_fk` FOREIGN KEY (`cuentaId`, `consecutivoId`) REFERENCES `vipchannel_cuenta` (`cuentaid`, `consecutivoid`),
  CONSTRAINT `vipchannel_detalle_cuenta_fk_1` FOREIGN KEY (`vendedorid`) REFERENCES `vipchannel_vendedor` (`vendedorid`),
  CONSTRAINT `vipchannel_detalle_cuenta_fk_2` FOREIGN KEY (`servicioId`) REFERENCES `vipchannel_servicio` (`servicioid`),
  CONSTRAINT `vipchannel_detalle_cuenta_fk_3` FOREIGN KEY (`tipoId`) REFERENCES `vipchannel_tipo` (`tipoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_detalle_cuenta`
--

LOCK TABLES `vipchannel_detalle_cuenta` WRITE;
/*!40000 ALTER TABLE `vipchannel_detalle_cuenta` DISABLE KEYS */;
INSERT INTO `vipchannel_detalle_cuenta` VALUES (1,1,1,1,1,1,1,1,28.00,0.00,0.00,'2020-06-07','MIGRACION','','',1,1,1),(2,1,2,1,1,1,1,1,22.00,0.00,0.00,'2020-06-07','MIGRACION','','',1,1,1);
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

-- Dump completed on 2020-06-20 11:45:31
