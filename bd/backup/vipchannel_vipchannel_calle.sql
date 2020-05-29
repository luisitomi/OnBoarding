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
-- Table structure for table `vipchannel_calle`
--

DROP TABLE IF EXISTS `vipchannel_calle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vipchannel_calle` (
  `calleId` int(11) NOT NULL AUTO_INCREMENT,
  `distritoId` int(11) NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `activo` int(11) NOT NULL,
  PRIMARY KEY (`calleId`),
  KEY `Refvipchannel_distrito10` (`distritoId`)
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vipchannel_calle`
--

LOCK TABLES `vipchannel_calle` WRITE;
/*!40000 ALTER TABLE `vipchannel_calle` DISABLE KEYS */;
INSERT INTO `vipchannel_calle` VALUES (1,1,'A.H. CRUZ MOTUPE-CARQUIN',1),(2,2,'A.H. EL FARO-ATALAYA',1),(3,2,'A.H. MEZA BRANDAN-ATALAYA',1),(4,3,'A.H. PORTILLO SILVA-HUAURA',1),(5,2,'AA.HH CERRO ZAPATA ENT AV. PERU',1),(6,2,'AA.HH. 1 DE JUNIO-STA MARIA',1),(7,3,'AA.HH. 21 DE ENERO - HUAURA',1),(8,2,'AA.HH. LOS PINOS II ETAPA-SRA.MARIA',1),(9,4,'AA.HH. MARIA DEL ROSARIO- HUALMAY',1),(10,3,'AA.HH. RIVERA DEL RIO - HUAURA',1),(11,2,'AA.HH. TRES PUENTES - AV. LIBERTAD',1),(12,2,'AA.HH.LOS PINOS - IETAPA STA. MARIA',1),(13,2,'AAHH LOS PINOS II ETAPA',1),(14,2,'AAHH.HUMILDAD Y PACIENCIA STA.MARIA',1),(15,5,'AMPARO CARDENAS (EX PJE. ESPINAR)',1),(16,2,'ASOC VIV. EL MIRADOR - ZAPATA',1),(17,1,'ASOC. BRISAS MARINAS - CARQUIN',1),(18,2,'ASOC. TOMA Y CALLA - SANTA MARIA',1),(19,2,'ASOC.DE VIV.VIRGEN DE LA ASUNCION',1),(20,5,'AV. 2 DE MAYO-HUACHO',1),(21,5,'AV. 28 JULIO-HUACHO',1),(22,5,'AV. 9 OCTUBRE-HUACHO',1),(23,4,'AV. ANTONIO RAYMONDI',1),(24,3,'AV. BLAS CARRERA-HUAURA',1),(25,2,'AV. BOLOGNESI-STA MARIA',1),(26,2,'AV. CENTENARIO',1),(27,4,'AV. CINCUENTENARIO-HUALMAY',1),(28,3,'AV. CNEL PORTILLO-HUAURA',1),(29,2,'AV. CRUZ BLANCA\r',1),(30,4,'AV. DOMINGO MANDAMIENTO',1),(31,5,'AV. ECHENIQUE',1),(32,2,'AV. EL MILAGRO-STA MARIA\r',1),(33,5,'AV. ESPINAR',1),(34,2,'AV. F.B.CARDENAS-STA MARIA',1),(35,5,'AV. FRANCISCO VIDAL',1),(36,3,'AV. FUMAGALLI-HUAURA',1),(37,5,'AV. GRAU-HUACHO',1),(38,4,'AV. HUALMAY',1),(39,1,'AV. INDUSTRIAL-CARQUIN',1),(40,4,'AV. JORGE CHAVEZ-HUALMAY',1),(41,3,'AV. LAS MALVINAS-HUAURA',1),(42,2,'AV. LIBERTAD-STA MARIA',1),(43,2,'AV. MANUELA DIAZ CHAFLOJO STA-MARIA',1),(44,5,'AV. MERCEDES INDACOCHEA',1),(45,5,'AV. MOORE',1),(46,5,'AV. PANAMERICANA NORTE',1),(47,2,'AV. PANAMERICANA SUR',1),(48,3,'AV. PERALVILLO',1),(49,2,'AV. PERU-STA MARIA',1),(50,2,'AV. REAL - SANTA MARIA',1),(51,2,'AV. SAN FRANCISCO-HUAURA',1),(52,5,'AV. SAN MARTIN-HUACHO',1),(53,1,'AV. SAN MARTIN - CARQUIN',1),(54,3,'AV. SAN MARTIN-HUAURA',1),(55,2,'AV. TORIBIO ACOSTA - SANTA MARIA',1),(56,1,'AV. TUPAC AMARU-CARQUIN',1),(57,5,'AV. TUPAC AMARU-HUACHO\r',1),(58,5,'BARRIO AMAY',1),(59,5,'BARRIO MARIN',1),(60,5,'C.P. DEF.DE VIDA Y SALUD - ATALAYA',1),(61,2,'CA MANUEL ANTONIO LINO STA MARIA',1),(62,4,'CA MARIA P. BELLIDO HUALMAY',1),(63,5,'CA. 14 NOVIEMBRE-MANZANARES',1),(64,5,'CA. 2 DE MAYO-ATALAYA',1),(65,5,'CA. 2 DE MAYO-MANZANARES',1),(66,4,'CA. 24 OCTUBRE-HUALMAY',1),(67,1,'CA. 27 OCTUBRE-CARQUIN',1),(68,1,'CA. 28 JULIO-CARQUIN',1),(69,5,'CA. 28 JULIO-MANZANARES',1),(70,2,'CA. 28 JULIO-STA MARIA',1),(71,1,'CA. 29 DE SETIEMBRE - CARQUIN',1),(72,1,'CA. 30 DICIEMBRE-CARQUIN',1),(73,2,'CA. 5 DICIEMBRE-STA. MARIA',1),(74,5,'CA. 8 JUNIO-MANZANARES',1),(75,5,'CA. A.B.LEGUIA',1),(76,2,'CA. A.CACERES-STA MARIA',1),(77,5,'CA. ADAN ACEVEDO',1),(78,5,'CA. ALFONSO UGARTE',1),(79,1,'CA. ALFONSO UGARTE-CARQUIN',1),(80,5,'CA. ALPAMAYO-CARQUIN',1),(81,4,'CA. ALPAMAYO-PUQUIO',1),(82,5,'CA. AMAZONAS-MANZANARES',1),(83,4,'CA. AMAZONAS-PUQUIO CANO',1),(84,5,'CA. ANCASH-LA ESPERANZA',1),(85,1,'CA. ANGEL AMAYA-CARQUIN',1),(86,5,'CA. ANTIG.PANAMERICANA - MANZANARES',1),(87,5,'CA. ARAMBULO LA ROSA - AMAY',1),(88,5,'CA. AREQUIPA',1),(89,1,'CA. ARICA-CARQUIN',1),(90,5,'CA. AROMITO',1),(91,5,'CA. ATAHUALPA',1),(92,5,'CA. AUSEJO PINTADO-AMAY',1),(93,5,'CA. AUSEJO SALAS',1),(94,5,'CA. AVELINO CACERES',1),(95,5,'CA. AYACUCHO MANZANAREZ I ETAPA',1),(96,4,'CA. B.ROSADIO-HUALMAY',1),(97,2,'CA. BARTOLOME PEREZ - ZAPATA',1),(98,4,'CA. BELLAVISTA',1),(99,1,'CA. BOLIVAR-CARQUIN',1),(100,4,'CA. BOLIVAR-HUACHO',1),(101,3,'CA. BOLIVAR-HUAURA',1),(102,5,'CA. BOLOGNESI',1),(103,1,'CA. BOLOGNESI-CARQUIN',1),(104,5,'CA. BUENOS AIRES - AMAY',1),(105,5,'CA. BUENOS AIRES-ATALAYA',1),(106,1,'CA. BUENOS AIRES-CARQUIN',1),(107,5,'CA. BUENOS AIRES-MANZANARES',1),(108,5,'CA. CAJAMARCA-MANZANARES',1),(109,3,'CA. CAMINO REAL-HUAURA',1),(110,4,'CA. CAMPO ALEGRE-HUALMAY',1),(111,5,'CA. CANTA-MANZANARES',1),(112,2,'CA. CEFERINO RAMIREZ - STA. MARIA',1),(113,4,'CA. CESAR VALLEJO - HUALMAY',1),(114,5,'CA. CHANCAY-ATALAYA',1),(115,1,'CA. CHANCAY-CARQUIN',1),(116,5,'CA. CHANCAY-MANZANARES',1),(117,2,'CA. CHURURO-TAMBO BLANCO',1),(118,5,'CA. CINCO-URB. HUACHO',1),(119,5,'CA. CIRO ALEGRIA-HUACHO',1),(120,4,'CA. CIRO ALEGRIA-PUQUIO - HUALMAY',1),(121,5,'CA. CIRO ALEGRIA-URB. LAS PALMAS',1),(122,5,'CA. CNEL PORTILLO',1),(123,5,'CA. COLON',1),(124,1,'CA. COSTANERA-CARQUIN',1),(125,4,'CA. CRUZ DE CANO',1),(126,5,'CA. DOMINGO COLOMA',1),(127,5,'CA. DOMINGO TORERO',1),(128,5,'CA. EL INCA',1),(129,5,'CA. EL PROGRESO',1),(130,5,'CA. ELCORROBARRUTIA',1),(131,5,'CA. ELIAS IPINCE',1),(132,1,'CA. EMILIANO MELENDEZ-CARQUIN',1),(133,5,'CA. ESTEBAN PICHILINGUE',1),(134,4,'CA. ESTEBAN PICHILINGUE-HUALMAY',1),(135,5,'CA. FCO VIDAL-MANZANARES',1),(136,5,'CA. FEDERICO VILLARREAL',1),(137,5,'CA. FERROCARRIL-MANZANARES',1),(138,5,'CA. FLORIAN DIAZ',1),(139,5,'CA. FRANCISCO ROSAS',1),(140,4,'CA. GABRIEL AGUILAR',1),(141,5,'CA. GALVEZ',1),(142,4,'CA. GARCILAZO VEGA-HUALMAY',1),(143,1,'CA. GENERAL VIDAL-CARQUIN',1),(144,5,'CA. GONZALES PRADA',1),(145,5,'CA. GRAU-ATALAYA',1),(146,1,'CA. GRAU-CARQUIN',1),(147,5,'CA. GUILLERMO VELASQUEZ',1),(148,2,'CA. H.OYOLA-STA MARIA',1),(149,4,'CA. HEROES CENEPA-PUQUIO',1),(150,4,'CA. HIPOLITO UNANUE-HUALMAY',1),(151,5,'CA. HUAURA - MANZANARES I ETAPA',1),(152,3,'CA. HUAURA-PUERTO',1),(153,3,'CA. INDEPENDENCIA-HUAURA',1),(154,4,'CA. INDEPENDENCIA-PUQUIO CANO',1),(155,2,'CA. INDEPENDENCIA-STA MARIA',1),(156,5,'CA. IRENE SALVADOR-MANZANARES',1),(157,2,'CA. IRENE SALVADOR-STA MARIA',1),(158,4,'CA. J. SANTOS CHOCANO - HUALMAY',1),(159,1,'CA. J.C.MARIATEGUI-CARQUIN',1),(160,4,'CA. J.C.MARIATEGUI-HUALMAY',1),(161,4,'CA. J.F.SANCHEZ C.',1),(162,3,'CA. JOSE CARLOS MARIATEGUI - HUAURA',1),(163,5,'CA. J.VELASCO ALVARADO',1),(164,1,'CA. JAVIER PRADO-CARQUIN',1),(165,5,'CA. JORGE CHAVEZ-ATALAYA',1),(166,1,'CA. JORGE CHAVEZ-CARQUIN',1),(167,5,'CA. JOSE GALVEZ - ATALAYA',1),(168,4,'CA. JOSE PARDO - HUALMAY',1),(169,5,'CA. JOSE T.GARCIA',1),(170,5,'CA. JUAN BARRETO',1),(171,4,'CA. JUAN BARRETO-HUALMAY',1),(172,4,'CA. JUAN J.CRESPO',1),(173,4,'CA. JULIO C. TELLO - HUALMAY',1),(174,5,'CA. JUNIN-MANZANARES',1),(175,5,'CA. LA MANCHURRIA',1),(176,5,'CA. LA MARINA',1),(177,4,'CA. LA MERCED',1),(178,5,'CA. LA MERCED-ATALAYA',1),(179,5,'CA. LA PALMA-HUACHO',1),(180,5,'CA. LA PAZ',1),(181,3,'CA. LA SELVA - EL INGENIO - HUAURA',1),(182,4,'CA. LA UNION',1),(183,5,'CA. LA VICTORIA-MANZANARES',1),(184,2,'CA. LAMPA-STA MARIA',1),(185,5,'CA. LAS DELICIAS-ATALAYA',1),(186,2,'CA. LAS DELICIAS-STA MARIA',1),(187,5,'CA. LAS FLORES',1),(188,2,'CA. LAS FLORES - LURIAMA STA.MARIA',1),(189,1,'CA. LAS FLORES-CARQUIN',1),(190,2,'CA. LAS FLORES-MANZANARES',1),(191,2,'CA. LAS ROSAS - LURIAMA - STA MARIA',1),(192,5,'CA. LEONCIO PRADO',1),(193,5,'CA. LIBERTAD-AMAY',1),(194,1,'CA. LIBERTADORES-CARQUIN',1),(195,4,'CA. LIMA-HUALMAY',1),(196,4,'CA. LIMA-LA ESPERANZA',1),(197,5,'CA. LIMA-MANZANARES',1),(198,2,'CA. LIMA-SAN LORENZO',1),(199,5,'CA. LOS ANGELES - HUACHO',1),(200,1,'CA. LOS ANGELES-CARQUIN',1),(201,2,'CA. LOS ANGELES-STA MARIA',1),(202,2,'CA. LOS HUACOS - HUALMAY',1),(203,4,'CA. LOS JARDINES-CARQUIN',1),(204,1,'CA. LOS OLIVOS-AMAY',1),(205,5,'CA. LOS PINOS-MANZANARES',1),(206,5,'CA. LUNA ARRIETA',1),(207,5,'CA. LUZ RISCO - AV. ESPINAR',1),(208,5,'CA. M.OYOLA-STA MARIA',1),(209,2,'CA. M.PARADO BELLIDO HUACHO',1),(210,5,'CA. M.UBALDE-HUALMAY',1),(211,4,'CA. MALECON ROCA',1),(212,5,'CA. MANCO CAPAC-CARQUIN',1),(213,1,'CA. MARIANO MELGAR-HUALMAY',1),(214,4,'CA. MATEO PUMACAHUA-HUALMAY',1),(215,4,'CA. MCAL CASTILLA',1),(216,5,'CA. MERCADO SUR',1),(217,5,'CA. MIRAFLORES - MANZANARES',1),(218,5,'CA. MIRAFLORES-ATALAYA',1),(219,1,'CA. MIRAMAR-CARQUIN',1),(220,5,'CA. MIRAMAR-MANZANARES',1),(221,5,'CA. MIRIAM WATANABE - ATALAYA',1),(222,2,'CA. NICANOR CHAGRAY-STA.MARIA',1),(223,0,'',1),(224,5,'CA. NICOLAS DE PIEROLA',1),(225,1,'CA. NICOLAS PIEROLA-CARQUIN',1),(226,4,'CA. NUEVO PROGRESO - HUALMAY',1),(227,1,'CA. OLAYA-CARQUIN',1),(228,5,'CA. OLAYA-HUACHO',1),(229,4,'CA. OLAYA-HUALMAY',1),(230,5,'CA. OLAYA-MANZANARES',1),(231,5,'CA. PACHACAMILLA-ATALAYA',1),(232,2,'CA. PACIFICO-STA. MARIA',1),(233,5,'CA. PAULA CHANGANAQUI',1),(234,1,'CA. PEDRO CUENCA-CARQUIN',1),(235,1,'CA. PEDRO HERRERA-CARQUIN',1),(236,4,'CA. PEDRO HERRERA-HUALMAY',1),(237,4,'CA. PEDRO REYES-HUALMAY',1),(238,1,'CA. PESCADORES-CARQUIN',1),(239,4,'CA. PLAYA HERMOSA-HUALMAY',1),(240,4,'CA. PUQUIO CANO',1),(241,5,'CA. QUINTA CARDENAS',1),(242,3,'CA. QUINTA ROTTA - HUAURA',1),(243,5,'CA. R.PALMA-ATALAYA',1),(244,4,'CA. RAMON CASTILLA-HUALMAY',1),(245,4,'CA. RUPERTA MONTES-HUALMAY',1),(246,5,'CA. SAENZ PE¥A',1),(247,5,'CA. SALAVERRY',1),(248,5,'CA. SAN ISIDRO - ATALAYA',1),(249,1,'CA. SAN ISIDRO-CARQUIN',1),(250,4,'CA. SAN ISIDRO-HUALMAY',1),(251,4,'CA. SAN MARTIN-HUALMAY',1),(252,2,'CA. SAN MARTIN-STA MARIA',1),(253,5,'CA. SAN MIGUEL-MANZANARES',1),(254,1,'CA. SAN PEDRO-CARQUIN',1),(255,5,'CA. SAN PEDRO-HUACHO',1),(256,5,'CA. SAN ROMAN',1),(257,2,'CA. SANTA MARIA-STA MARIA',1),(258,5,'CA. SANTA ROSA',1),(259,2,'CA. SEVILLA-STA MARIA',1),(260,5,'CA. SR DE LA ASCENCION-AMAY',1),(261,5,'CA. STA ROSA-MANZANARES',1),(262,5,'CA. SUCRE',1),(263,1,'CA. SUCRE-CARQUIN',1),(264,5,'CA. SUCRE-HUACHO',1),(265,5,'CA. SUCRE-MANZANARES',1),(266,3,'CA. TAMBO BLANCO',1),(267,3,'CA. TOMA Y CALLA-STA.MARIA',1),(268,5,'CA. TOMAS CARREÑO - AMAY',1),(269,5,'CA. TORRES PAZ',1),(270,5,'CA. TRUJILLO MANZANARES I ETAPA',1),(271,4,'CA. TUPAC AMARU-HUALMAY',1),(272,5,'CA. UGARTE-MANZANARES',1),(273,5,'CA. VALDIVIA-CENTENARIO',1),(274,5,'CA. VISTA ALEGRE-MANZANARES',1),(275,5,'CA.HONORATO CHIRITO - AMAY',1),(276,5,'CA.LA PAZ',1),(277,2,'CA.LAS FLORES - LURIAMA STA.MARIA',1),(278,5,'CALLE 1 MANZANARES - IV ETAPA',1),(279,5,'CALLE 2 - MANZANARES - IV ETAPA',1),(280,5,'CALLE 5 MANZANARES - IV ETAPA',1),(281,5,'HUACHO UNO',1),(282,2,'JIRON SANTA ANA - SANTA MARIA',1),(283,4,'JR. FRANCISCO DE ZELA - HUALMAY',1),(284,4,'JR. TOMA Y CALLA - STA. MARIA',1),(285,5,'LIMA',1),(286,5,'MANZANARES',1),(287,5,'MERCADO HUACHO',1),(288,5,'PASAJE LOS OLIVOS - AMAY',1),(289,4,'PJE CRUZ DE CANO',1),(290,3,'PJE FUMAGALLI - HUAURA',1),(291,5,'PJE LOS ALAMOS - HUACHO',1),(292,2,'PJE QUICHE - AV. LIBERTAD S.MARIA',1),(293,2,'PJE. 2 DE MAYO-STA MARIA',1),(294,5,'PJE. AMINCO MAR',1),(295,3,'PJE. ANTONIO ABAD-HUAURA',1),(296,5,'PJE. AREQUIPA',1),(297,4,'PJE. AVELINO CACERES - PUQUIO',1),(298,3,'PJE. BAQUIJANO-TAMBO BLANCO',1),(299,5,'PJE. BELLAVISTA-HUACHO',1),(300,4,'PJE. BELLAVISTA-HUALMAY',1),(301,5,'PJE. BENEDICTO - HUACHO',1),(302,5,'PJE. CAMINO REAL-HUACHO',1),(303,4,'PJE. CAMPO ALEGRE-HUALMAY',1),(304,5,'PJE. CATACAOS-URB HUACHO',1),(305,4,'PJE. CELSO DIAZ',1),(306,4,'PJE. CHANGANAQUI',1),(307,4,'PJE. CINCUENTENARIO-HUALMAY',1),(308,4,'PJE. CIRO ALEGRIA-PUQUIO',1),(309,4,'PJE. CRUZ DE CANO',1),(310,4,'PJE. DGO MANDAMIENTO-HUALMAY',1),(311,2,'PJE. DGO MANDAMIENTO-STA MARIA',1),(312,4,'PJE. EL ANGEL - HUALMAY',1),(313,5,'PJE. EL NIÑO',1),(314,2,'PJE. ELADIO ORTIZ',1),(315,2,'PJE. EMILIANO COLLANTES-STA MARIA',1),(316,4,'PJE. EMILIANO REYES-HUALMAY',1),(317,4,'PJE. EUDELIA',1),(318,2,'PJE. F.B.CARDENAS-STA MARIA',1),(319,2,'PJE. FATIMA-STA MARIA',1),(320,2,'PJE. FORTALEZA-TAMBO BLANCO',1),(321,4,'PJE. GRAU-PUQUIO CANO',1),(322,5,'PJE. IRENE SALVADOR-HUACHO',1),(323,3,'PJE. J.C.MARIATEGUI-HUAURA',1),(324,2,'PJE. J.C.MARIATEGUI-STA MARIA',1),(325,3,'PJE. JORGE CHAVEZ-HUAURA',1),(326,4,'PJE. LA FAMILIA',1),(327,4,'PJE. LA FLORIDA-HUALMAY',1),(328,2,'PJE. LA MERCED-STA MARIA',1),(329,2,'PJE. LA NEGRA-LURIAMA',1),(330,4,'PJE. LA UNION',1),(331,5,'PJE. LIBERTAD-URB HUACHO',1),(332,5,'PJE. LOBITOS',1),(333,4,'PJE. LOS FICUS - HUALMAY',1),(334,4,'PJE. LOS JARDINES-HUALMAY',1),(335,5,'PJE. LOS LAURELES',1),(336,4,'PJE. LOS OLIVOS-HUALMAY',1),(337,2,'PJE. LOS PINOS-STA MARIA',1),(338,5,'PJE. LOS SAUCES',1),(339,5,'PJE. LOZA',1),(340,5,'PJE. M.INDACOCHEA',1),(341,5,'PJE. MACNAMARA',1),(342,4,'PJE. MARIA ARGUEDAS - PUQUIO CANO',1),(343,5,'PJE. MARIN - HUACHO',1),(344,5,'PJE. NUEVA VICTORIA',1),(345,4,'PJE. NUEVO PORVENIR-HUALMAY',1),(346,5,'PJE. OLAYA-ATALAYA',1),(347,5,'PJE. P.RUIZ GALLO',1),(348,2,'PJE. PACOCHA-SANTA MARIA',1),(349,4,'PJE. PALOMARES-HUALMAY',1),(350,5,'PJE. RESID.ECHENIQUE',1),(351,5,'PJE. RESID.STA ROSA',1),(352,5,'PJE. ROMERO',1),(353,2,'PJE. SALVADOR - TAMBO BLANCO',1),(354,5,'PJE. SAN MARTIN-HUACHO',1),(355,4,'PJE. SAN MARTIN-HUALMAY',1),(356,3,'PJE. SAN MARTIN-HUAURA',1),(357,1,'PJE. SAN PABLO - CARQUIN',1),(358,4,'PJE. SAN PEDRO-HUALMAY',1),(359,2,'PJE. SANTA ANA-STA MARIA',1),(360,5,'PJE. SANTA ELENA',1),(361,5,'PJE. SARITA COLONIA-MANZANARES',1),(362,5,'PJE. STA ISABEL-HUACHO',1),(363,5,'PJE. STA ROSA',1),(364,5,'PJE. STA ROSA-ATALAYA',1),(365,5,'PJE. STA ROSA-HUACHO',1),(366,5,'PJE. STA ROSA-PUERTO',1),(367,5,'PJE. T.AMARU-HUACHO',1),(368,4,'PJE. T.AMARU-HUALMAY',1),(369,5,'PJE. TRES-MANZANARES',1),(370,4,'PJE.SARITA COLONIA-HUALMAY',1),(371,1,'PJE.VIRGEN CARMEN-CARQUIN',1),(372,5,'PLG. AREQUIPA',1),(373,4,'PLG. ATAHUALPA - HUALMAY',1),(374,5,'PLG. ESPINAR',1),(375,5,'PLG. FRANCISCO ROSAS',1),(376,5,'PLG. GALVEZ',1),(377,5,'PLG. GRAU-HUACHO',1),(378,5,'PLG. J.BARRETO',1),(379,5,'PLG. LA PALMA-HUACHO',1),(380,5,'PLG. LAS FLORES',1),(381,5,'PLG. LEONCIO PRADO',1),(382,5,'PLG. M.UBALDE',1),(383,5,'PLG. MCAL CASTILLA',1),(384,5,'PLG. MOORE',1),(385,5,'PLG. OLAYA-HUACHO',1),(386,5,'PLG. R.PALMA-HUACHO',1),(387,5,'PLG. SALAVERRY',1),(388,5,'PLG. SAN MARTIN-HUACHO',1),(389,5,'PLG. STA ROSA',1),(390,5,'PQ.HERNAN VELARDE - LIMA',1),(391,5,'PROLG. SANTA ANA - SANTA MARIA',1),(392,1,'PSJE. EL MORRO - CARQUIN',1),(393,5,'PSJE. PACOCHA - HUACHO',1),(394,5,'PUERTO HUACHO',1),(395,2,'SAN BARTOLOME II ETAPA',1),(396,5,'URB. 13 MAYO-PUERTO',1),(397,5,'URB. 18 OCTUBRE',1),(398,5,'URB. 18 OCTUBRE-HUACHO',1),(399,5,'URB. 23 ABRIL-PUERTO',1),(400,5,'URB. AUSEJO PINTADO',1),(401,3,'URB. EL CARMEN-HUAURA',1),(402,3,'URB. EL MILAGRO-HUAURA',1),(403,3,'URB. EL OLIVAR',1),(404,3,'URB. EL ROSARIO-HUAURA',1),(405,3,'URB. EL SOCORRO-HUAURA',1),(406,5,'URB. FONAVI',1),(407,5,'URB. HUACHO',1),(408,5,'URB. JOSE F. SANCHEZ CARRION',1),(409,5,'URB. LA ESPERANZA',1),(410,5,'URB. LAS BRISAS',1),(411,5,'URB. LAS FLORES',1),(412,4,'URB. LAS PALMAS-HUALMAY',1),(413,2,'URB. LORENZO MEZA-ATALAYA',1),(414,5,'URB. LOS CIPRECES',1),(415,2,'URB. LOS CISNES',1),(416,2,'URB. LOS JARDINES',1),(417,3,'URB. LOS PINOS-HUAURA',1),(418,5,'URB. LOS SAUCES',1),(419,1,'URB. OLAYA-CARQUIN',1),(420,2,'URB. PACOCHA',1),(421,5,'URB. RAMIRO PRIALE',1),(422,5,'URB. RIVA AGUERO-PUERTO',1),(423,2,'URB. SAN BARTOLOME',1),(424,2,'URB. SAN BARTOLOME 3-ETAPA',1),(425,2,'URB. SAN BARTOLOME-STA MARIA',1),(426,5,'URB. SAN FRANCISCO',1),(427,3,'URB. SAN MARTIN-HUAURA',1),(428,5,'URB. SAN PEDRO',1),(429,4,'URB. SR LOS MILAGROS-HUALMAY',1),(430,5,'URB. UNISAL',1),(431,4,'URB.JOSE F.SANCHEZ CARRION',1);
/*!40000 ALTER TABLE `vipchannel_calle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-29  0:15:56