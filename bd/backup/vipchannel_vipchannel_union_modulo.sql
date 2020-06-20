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
-- Table structure for table `vipchannel_union_modulo`
--

DROP TABLE IF EXISTS `vipchannel_union_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_union_modulo` (
  `detalleid` int(11) NOT NULL AUTO_INCREMENT,
  `idsubm` int(11) NOT NULL,
  `idmodulo` int(11) NOT NULL,
  `ruta` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `imagen` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`detalleid`),
  KEY `vipchannel_union_modulo_fk` (`idmodulo`),
  KEY `vipchannel_union_modulo_fk_1` (`idsubm`),
  CONSTRAINT `vipchannel_union_modulo_fk` FOREIGN KEY (`idmodulo`) REFERENCES `vipchannel_modulo` (`idmodulo`),
  CONSTRAINT `vipchannel_union_modulo_fk_1` FOREIGN KEY (`idsubm`) REFERENCES `vipchannel_submodulo` (`idsubm`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_union_modulo`
--

LOCK TABLES `vipchannel_union_modulo` WRITE;
/*!40000 ALTER TABLE `vipchannel_union_modulo` DISABLE KEYS */;
INSERT INTO `vipchannel_union_modulo` VALUES (1,1,1,'/cobranza/pago','icon-basket-loaded',1),(2,2,1,'/cobranza/listado','icon-list',1),(3,3,2,'/venta/registro','icon-user-follow',1),(4,4,2,'/venta/listado','icon-list',1),(5,5,3,'/atencion/registro','icon-people',1),(6,6,3,'/atencion/listado','icon-list',1),(7,7,4,'/actividad/listado','icon-bell',1),(8,8,1,'','',1),(9,8,2,'','',1),(10,8,3,'','',1),(11,8,1,'','',0);
/*!40000 ALTER TABLE `vipchannel_union_modulo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:23
