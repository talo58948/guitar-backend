-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: guitar-db
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('classical'),('electric');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colors` (
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `id_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colors`
--

LOCK TABLES `colors` WRITE;
/*!40000 ALTER TABLE `colors` DISABLE KEYS */;
INSERT INTO `colors` VALUES ('blue'),('brown'),('green'),('red');
/*!40000 ALTER TABLE `colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES ('music man'),('yamaha');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) DEFAULT '0.00',
  `user_id` int NOT NULL,
  `payed` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_fk_idx` (`user_id`),
  CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (22,1.00,3,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passwords`
--

DROP TABLE IF EXISTS `passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passwords` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hash` tinyblob NOT NULL,
  `salt` tinyblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passwords`
--

LOCK TABLES `passwords` WRITE;
/*!40000 ALTER TABLE `passwords` DISABLE KEYS */;
INSERT INTO `passwords` VALUES (1,_binary '%oþ ½‡ªSß’¸¸_\\;§^ÿ\Ý&Syˆ\à9>IXU',_binary '\ê(ª²\Í¬_©n^\0ý\Èb\ÒÇ¢\ï¬6!žƒ*ô\ÌqÊ¹Z°y{Z´0‚*$ª;|\èÝ®Pf8:n¡…\r™'),(3,_binary 'e7sWŸ>Q¢ªc¡ø_\\˜(:Áö_¹Qr­À',_binary '\Å\rù\Çýf«\ÄÛ¸F\Î\íz\Ï R\å\Zm\Ý#o\î\ny>*¦Œ)\Ð\ÎÜ³¾-5DmJ\âx°F\Ã^\Ârµ	q');
/*!40000 ALTER TABLE `passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sold` int DEFAULT '0',
  `name` varchar(64) DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `quantity` int DEFAULT '0',
  `shipping` tinyint DEFAULT '0',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `category` varchar(64) DEFAULT '',
  `imageUrl` varchar(512) DEFAULT '',
  `company` varchar(64) DEFAULT '',
  `color` varchar(64) DEFAULT '',
  `price` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `category_idx` (`category`),
  KEY `company_fk_idx` (`company`),
  KEY `color_fk_idx` (`color`),
  CONSTRAINT `category_fk` FOREIGN KEY (`category`) REFERENCES `categories` (`name`),
  CONSTRAINT `color_fk` FOREIGN KEY (`color`) REFERENCES `colors` (`name`),
  CONSTRAINT `company_fk` FOREIGN KEY (`company`) REFERENCES `companies` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (17,0,'guitar1','string',0,0,'2022-08-17 21:34:39','2022-08-17 21:34:39','electric','','yamaha','red',1.00),(18,0,'string','string',0,1,'2022-08-17 21:34:48','2022-08-17 21:34:48','electric','','yamaha','green',1.00),(19,0,'string','string',0,1,'2022-08-17 21:34:52','2022-08-17 21:34:52','electric','','yamaha','blue',0.00),(20,0,'dummy guitar0','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(21,0,'dummy guitar1','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(22,0,'dummy guitar2','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(23,0,'dummy guitar3','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(24,0,'dummy guitar4','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(25,0,'dummy guitar5','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(26,0,'dummy guitar6','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(27,0,'dummy guitar7','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(28,0,'dummy guitar8','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(29,0,'dummy guitar9','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(30,0,'dummy guitar10','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(31,0,'dummy guitar11','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(32,0,'dummy guitar12','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(33,0,'dummy guitar13','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(34,0,'dummy guitar14','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(35,0,'dummy guitar15','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(36,0,'dummy guitar16','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(37,0,'dummy guitar17','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(38,0,'dummy guitar18','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(39,0,'dummy guitar19','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(40,0,'dummy guitar20','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(41,0,'dummy guitar21','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(42,0,'dummy guitar22','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(43,0,'dummy guitar23','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(44,0,'dummy guitar24','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(45,0,'dummy guitar25','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(46,0,'dummy guitar26','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(47,0,'dummy guitar27','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(48,0,'dummy guitar28','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(49,0,'dummy guitar29','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(50,0,'dummy guitar30','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(51,0,'dummy guitar31','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(52,0,'dummy guitar32','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(53,0,'dummy guitar33','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(54,0,'dummy guitar34','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(55,0,'dummy guitar35','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(56,0,'dummy guitar36','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(57,0,'dummy guitar37','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(58,0,'dummy guitar38','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(59,0,'dummy guitar39','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(60,0,'dummy guitar40','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(61,0,'dummy guitar41','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(62,0,'dummy guitar42','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(63,0,'dummy guitar43','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(64,0,'dummy guitar44','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(65,0,'dummy guitar45','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(66,0,'dummy guitar46','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(67,0,'dummy guitar47','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(68,0,'dummy guitar48','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(69,0,'dummy guitar49','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(70,0,'dummy guitar50','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(71,0,'dummy guitar51','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(72,0,'dummy guitar52','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(73,0,'dummy guitar53','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(74,0,'dummy guitar54','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(75,0,'dummy guitar55','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(76,0,'dummy guitar56','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(77,0,'dummy guitar57','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(78,0,'dummy guitar58','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(79,0,'dummy guitar59','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(80,0,'dummy guitar60','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(81,0,'dummy guitar61','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(82,0,'dummy guitar62','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(83,0,'dummy guitar63','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(84,0,'dummy guitar64','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(85,0,'dummy guitar65','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(86,0,'dummy guitar66','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(87,0,'dummy guitar67','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(88,0,'dummy guitar68','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(89,0,'dummy guitar69','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(90,0,'dummy guitar70','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(91,0,'dummy guitar71','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(92,0,'dummy guitar72','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(93,0,'dummy guitar73','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(94,0,'dummy guitar74','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(95,0,'dummy guitar75','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(96,0,'dummy guitar76','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(97,0,'dummy guitar77','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(98,0,'dummy guitar78','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(99,0,'dummy guitar79','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(100,0,'dummy guitar80','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(101,0,'dummy guitar81','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(102,0,'dummy guitar82','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(103,0,'dummy guitar83','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(104,0,'dummy guitar84','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(105,0,'dummy guitar85','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(106,0,'dummy guitar86','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(107,0,'dummy guitar87','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(108,0,'dummy guitar88','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(109,0,'dummy guitar89','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(110,0,'dummy guitar90','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(111,0,'dummy guitar91','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(112,0,'dummy guitar92','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(113,0,'dummy guitar93','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(114,0,'dummy guitar94','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(115,0,'dummy guitar95','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(116,0,'dummy guitar96','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(117,0,'dummy guitar97','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(118,0,'dummy guitar98','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(119,0,'dummy guitar99','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(120,0,'dummy guitar100','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(121,0,'dummy guitar101','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(122,0,'dummy guitar102','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(123,0,'dummy guitar103','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(124,0,'dummy guitar104','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(125,0,'dummy guitar105','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(126,0,'dummy guitar106','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(127,0,'dummy guitar107','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(128,0,'dummy guitar108','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(129,0,'dummy guitar109','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(130,0,'dummy guitar110','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(131,0,'dummy guitar111','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(132,0,'dummy guitar112','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(133,0,'dummy guitar113','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(134,0,'dummy guitar114','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(135,0,'dummy guitar115','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(136,0,'dummy guitar116','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(137,0,'dummy guitar117','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(138,0,'dummy guitar118','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(139,0,'dummy guitar119','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(140,0,'dummy guitar120','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(141,0,'dummy guitar121','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(142,0,'dummy guitar122','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(143,0,'dummy guitar123','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(144,0,'dummy guitar124','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(145,0,'dummy guitar125','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(146,0,'dummy guitar126','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(147,0,'dummy guitar127','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(148,0,'dummy guitar128','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(149,0,'dummy guitar129','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(150,0,'dummy guitar130','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(151,0,'dummy guitar131','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(152,0,'dummy guitar132','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(153,0,'dummy guitar133','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(154,0,'dummy guitar134','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(155,0,'dummy guitar135','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(156,0,'dummy guitar136','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(157,0,'dummy guitar137','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(158,0,'dummy guitar138','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(159,0,'dummy guitar139','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(160,0,'dummy guitar140','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(161,0,'dummy guitar141','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(162,0,'dummy guitar142','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(163,0,'dummy guitar143','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(164,0,'dummy guitar144','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(165,0,'dummy guitar145','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(166,0,'dummy guitar146','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(167,0,'dummy guitar147','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(168,0,'dummy guitar148','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(169,0,'dummy guitar149','product created in script',0,0,'2022-08-18 14:50:14','2022-08-18 14:50:14','electric','https://thumbs.static-thomann.de/thumb/padthumb600x600/pics/bdb/145594/7082188_800.jpg','yamaha','red',0.00),(170,0,'my guitar 1','',1,1,'2022-08-21 13:06:56','2022-08-21 13:06:56','classical','','Music Man','brown',0.00);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsorders`
--

DROP TABLE IF EXISTS `productsorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsorders` (
  `product` int NOT NULL,
  `order` int NOT NULL,
  PRIMARY KEY (`product`,`order`),
  KEY `order-fk_idx` (`order`),
  CONSTRAINT `order-fk` FOREIGN KEY (`order`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product-fk` FOREIGN KEY (`product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsorders`
--

LOCK TABLES `productsorders` WRITE;
/*!40000 ALTER TABLE `productsorders` DISABLE KEYS */;
INSERT INTO `productsorders` VALUES (18,22),(19,22);
/*!40000 ALTER TABLE `productsorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `passwordId` int NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `password_idx` (`passwordId`),
  CONSTRAINT `password_fk` FOREIGN KEY (`passwordId`) REFERENCES `passwords` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'string',1,'string@string.strong','2022-08-15 23:21:01',NULL),(3,'tal',3,'tal@tal.tal','2022-08-20 01:13:11','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-21 20:34:41
