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
-- Table structure for table `vipchannel_datos_sumatoria`
--

DROP TABLE IF EXISTS `vipchannel_datos_sumatoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_datos_sumatoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `monto` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `intervalo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1267 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_datos_sumatoria`
--

LOCK TABLES `vipchannel_datos_sumatoria` WRITE;
/*!40000 ALTER TABLE `vipchannel_datos_sumatoria` DISABLE KEYS */;
INSERT INTO `vipchannel_datos_sumatoria` VALUES (1226,'AREVALO RUIZ HILDA ZONIA','0',1),(1227,'BAZALAR LOPEZ HEBERT YOEL','0',1),(1228,'','0',1),(1229,'','0',1),(1230,'','0',1),(1231,'','0',1),(1232,'','0',1),(1233,'','0',1),(1234,'Total','0',1),(1235,'','',2),(1236,'','',2),(1237,'','',2),(1238,'','',2),(1239,'INTERVALO DE:  2 MESES','',2),(1240,'','',2),(1241,'','',2),(1242,'AREVALO RUIZ HILDA ZONIA','0',2),(1243,'BAZALAR LOPEZ HEBERT YOEL','0',2),(1244,'','0',2),(1245,'','0',2),(1246,'','0',2),(1247,'','0',2),(1248,'','0',2),(1249,'','0',2),(1250,'Total','0',2),(1251,'','',3),(1252,'','',3),(1253,'','',3),(1254,'','',3),(1255,'INTERVALO DE:  3 A MÁS MESES','',3),(1256,'','',3),(1257,'','',3),(1258,'AREVALO RUIZ HILDA ZONIA','258',3),(1259,'BAZALAR LOPEZ HEBERT YOEL','0',3),(1260,'','0',3),(1261,'','0',3),(1262,'','0',3),(1263,'','0',3),(1264,'','0',3),(1265,'','0',3),(1266,'Total','258',3);
/*!40000 ALTER TABLE `vipchannel_datos_sumatoria` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 11:45:07
