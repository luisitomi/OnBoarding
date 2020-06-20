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
-- Table structure for table `vipchannel_tarea`
--

DROP TABLE IF EXISTS `vipchannel_tarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_tarea` (
  `tareaId` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `detalleid` int(11) DEFAULT NULL,
  `documento` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `nombre` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `asunto` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `asignado` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  `notificado` int(11) DEFAULT NULL,
  PRIMARY KEY (`tareaId`),
  KEY `vipchannel_tarea_fk` (`id`),
  KEY `vipchannel_tarea_fk_1` (`detalleid`),
  CONSTRAINT `vipchannel_tarea_fk` FOREIGN KEY (`id`) REFERENCES `vipchannel_usuario` (`id`),
  CONSTRAINT `vipchannel_tarea_fk_1` FOREIGN KEY (`detalleid`) REFERENCES `vipchannel_union_modulo` (`detalleid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_tarea`
--

LOCK TABLES `vipchannel_tarea` WRITE;
/*!40000 ALTER TABLE `vipchannel_tarea` DISABLE KEYS */;
INSERT INTO `vipchannel_tarea` VALUES (1,1,8,'75134791','anacleto','informe de pagos',2,1,1),(2,1,8,'75134791','anacleto','corta servicio',7,1,1),(4,1,9,'75134791','Luis miguel','contrato nuevo duo',0,1,1);
/*!40000 ALTER TABLE `vipchannel_tarea` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:26
