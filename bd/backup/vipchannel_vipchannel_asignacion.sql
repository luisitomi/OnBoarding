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
-- Table structure for table `vipchannel_asignacion`
--

DROP TABLE IF EXISTS `vipchannel_asignacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_asignacion` (
  `asigancionId` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `idrol` int(11) NOT NULL,
  `detalleid` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`asigancionId`),
  KEY `Refvipchannel_usuario51` (`id`),
  KEY `vipchannel_asignacion_fk_1` (`detalleid`),
  KEY `vipchannel_asignacion_fk_2` (`idrol`),
  CONSTRAINT `vipchannel_asignacion_fk_1` FOREIGN KEY (`detalleid`) REFERENCES `vipchannel_union_modulo` (`detalleid`),
  CONSTRAINT `vipchannel_asignacion_fk_2` FOREIGN KEY (`idrol`) REFERENCES `vipchannel_rol` (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_asignacion`
--

LOCK TABLES `vipchannel_asignacion` WRITE;
/*!40000 ALTER TABLE `vipchannel_asignacion` DISABLE KEYS */;
INSERT INTO `vipchannel_asignacion` VALUES (1,1,1,1,1),(2,1,1,2,1),(3,2,2,1,1),(4,2,2,2,1),(5,1,1,3,1),(6,3,2,1,1),(7,3,2,2,1),(8,4,2,1,1),(9,4,2,2,1),(10,5,3,3,1),(11,5,3,4,1),(12,6,4,3,1),(13,7,5,5,1),(14,1,1,4,1),(15,1,1,5,1),(17,7,5,6,1),(18,1,1,6,1),(19,1,1,7,1),(20,2,2,7,1),(21,3,2,7,1),(22,4,2,7,1),(23,5,3,7,1),(24,6,4,7,1),(25,7,5,10,1),(26,1,1,8,1),(27,5,3,9,1),(28,1,1,9,0),(29,1,1,10,1),(30,1,1,11,0),(31,1,1,11,0),(32,8,6,1,1);
/*!40000 ALTER TABLE `vipchannel_asignacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:17
