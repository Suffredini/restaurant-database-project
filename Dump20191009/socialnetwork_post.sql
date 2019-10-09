-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: socialnetwork
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `IdPost` int(11) NOT NULL AUTO_INCREMENT,
  `strPost` char(50) NOT NULL,
  `User` char(50) NOT NULL,
  `Date` timestamp NOT NULL,
  PRIMARY KEY (`IdPost`),
  KEY `User` (`User`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`User`) REFERENCES `user` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'Tre giorni fa sono andato a lavorare','Ginamarco','2019-10-14 22:00:00'),(2,'Tre giorni fa sono andato in piscina','Tiziana','2019-05-24 22:00:00'),(3,'Tre giorni fa sono andato al mare','Ginamarco','2019-04-23 22:00:00'),(4,'Oggi vado da mia mamma','Tiziana','2019-11-26 23:00:00'),(5,'Oggi vado a lavorare','Tiziana','2019-06-16 22:00:00'),(6,'Domani andrò in mntagna','Tiziana','2019-01-06 23:00:00'),(7,'Domani andrò a fare shopping','Tiziana','2019-05-19 22:00:00'),(8,'Domani andrò in mntagna','Tiziana','2019-03-15 23:00:00'),(9,'Tre giorni fa sono andato a lavorare','Erica','2019-07-05 22:00:00'),(10,'Domani andrò da mia mamma','Tiziana','2019-09-30 22:00:00'),(11,'Tre giorni fa sono andato a sciare','Mario','2019-12-04 23:00:00'),(12,'Tra due giorni andrò al mare','Tiziana','2019-12-26 23:00:00'),(13,'Tre giorni fa sono andato in campagna','Ginamarco','2019-05-04 22:00:00'),(14,'Ieri sono andato a fare shopping','Ginamarco','2019-03-05 23:00:00'),(15,'Tre giorni fa sono andato da mia mamma','Antonio','2019-07-02 22:00:00'),(16,'Domani andrò al mare','Antonio','2018-12-31 23:00:00'),(17,'Tre giorni fa sono andato al mare','Tiziana','2019-12-06 23:00:00'),(18,'Tre giorni fa sono andato in piscina','Ginamarco','2019-12-02 23:00:00'),(19,'Oggi vado a lavorare','Erica','2019-02-05 23:00:00'),(20,'Tre giorni fa sono andato in piscina','Antonio','2019-10-15 22:00:00'),(21,'Tra due giorni andrò in mntagna','Tiziana','2019-07-25 22:00:00'),(22,'Tre giorni fa sono andato da mia mamma','Tiziana','2019-03-22 23:00:00'),(23,'Tra due giorni andrò al mare','Tiziana','2019-04-11 22:00:00'),(24,'Ieri sono andato a sciare','Tiziana','2019-06-04 22:00:00'),(25,'Domani andrò al mare','Tiziana','2019-02-06 23:00:00'),(26,'Tra due giorni andrò al mare','Antonio','2019-09-11 22:00:00'),(27,'Oggi vado da mia mamma','Antonio','2019-11-04 23:00:00'),(28,'Tre giorni fa sono andato in piscina','Erica','2019-12-14 23:00:00'),(29,'Tra due giorni andrò in piscina','Antonio','2019-07-01 22:00:00'),(30,'Ieri sono andato in campagna','Erica','2019-02-02 23:00:00'),(31,'Tre giorni fa sono andato in piscina','Erica','2019-05-16 22:00:00'),(32,'Tre giorni fa sono andato a fare shopping','Erica','2019-01-26 23:00:00'),(33,'Domani andrò in mntagna','Erica','2019-02-20 23:00:00'),(34,'Tra due giorni andrò in piscina','Ginamarco','2019-04-12 22:00:00'),(35,'Tre giorni fa sono andato in campagna','Tiziana','2019-02-17 23:00:00'),(36,'Domani andrò a studiare','Mario','2019-09-30 22:00:00'),(37,'Tre giorni fa sono andato in campagna','Erica','2019-02-14 23:00:00'),(38,'Tre giorni fa sono andato a sciare','Erica','2019-10-20 22:00:00'),(39,'Tre giorni fa sono andato a studiare','Ginamarco','2019-07-18 22:00:00'),(40,'Domani andrò a fare shopping','Ginamarco','2019-09-15 22:00:00'),(41,'Tre giorni fa sono andato in piscina','Tiziana','2019-09-13 22:00:00'),(42,'Ieri sono andato da mia mamma','Mario','2019-12-20 23:00:00'),(43,'Oggi vado in campagna','Mario','2019-11-22 23:00:00'),(44,'Oggi vado a fare shopping','Erica','2019-08-22 22:00:00'),(45,'Tra due giorni andrò in piscina','Mario','2019-01-19 23:00:00'),(46,'Domani andrò a lavorare','Tiziana','2019-03-08 23:00:00'),(47,'Oggi vado da mia mamma','Antonio','2019-05-17 22:00:00'),(48,'Ieri sono andato a studiare','Antonio','2019-05-07 22:00:00'),(49,'Tra due giorni andrò a fare shopping','Mario','2019-02-16 23:00:00'),(50,'Tra due giorni andrò a fare shopping','Ginamarco','2019-02-16 23:00:00'),(51,'Ieri sono andato a sciare','Mario','2019-09-05 22:00:00'),(52,'Tra due giorni andrò in campagna','Erica','2019-02-09 23:00:00'),(53,'Tra due giorni andrò da mia mamma','Ginamarco','2019-12-02 23:00:00'),(54,'Tra due giorni andrò a lavorare','Erica','2019-04-05 22:00:00'),(55,'Domani andrò in piscina','Ginamarco','2019-05-03 22:00:00'),(56,'Tre giorni fa sono andato a sciare','Ginamarco','2019-01-20 23:00:00'),(57,'Ieri sono andato in campagna','Erica','2019-09-20 22:00:00'),(58,'Ieri sono andato a studiare','Antonio','2019-12-03 23:00:00'),(59,'Tra due giorni andrò in mntagna','Antonio','2019-12-02 23:00:00'),(60,'Domani andrò al mare','Erica','2019-11-08 23:00:00'),(61,'Tre giorni fa sono andato da mia mamma','Antonio','2019-02-23 23:00:00'),(62,'Ieri sono andato da mia mamma','Ginamarco','2019-09-10 22:00:00'),(63,'Tra due giorni andrò a studiare','Antonio','2019-04-26 22:00:00'),(64,'Tre giorni fa sono andato a studiare','Erica','2019-07-06 22:00:00'),(65,'Domani andrò al mare','Mario','2019-11-07 23:00:00'),(66,'Oggi vado a fare shopping','Mario','2019-01-05 23:00:00'),(67,'Ieri sono andato a sciare','Antonio','2019-03-13 23:00:00'),(68,'Tra due giorni andrò a fare shopping','Ginamarco','2019-02-12 23:00:00'),(69,'Tre giorni fa sono andato al mare','Tiziana','2019-05-23 22:00:00'),(70,'Tre giorni fa sono andato in mntagna','Tiziana','2019-03-26 23:00:00'),(71,'Tra due giorni andrò a lavorare','Antonio','2019-11-26 23:00:00'),(72,'Domani andrò in mntagna','Tiziana','2019-10-06 22:00:00'),(73,'Tre giorni fa sono andato a sciare','Mario','2019-03-15 23:00:00'),(74,'Domani andrò in campagna','Ginamarco','2019-04-23 22:00:00'),(75,'Oggi vado in mntagna','Mario','2019-03-02 23:00:00'),(76,'Domani andrò in mntagna','Erica','2019-03-19 23:00:00'),(77,'Domani andrò da mia mamma','Antonio','2019-02-16 23:00:00'),(78,'Oggi vado da mia mamma','Tiziana','2019-09-22 22:00:00'),(79,'Ieri sono andato a fare shopping','Antonio','2019-01-15 23:00:00'),(80,'Tra due giorni andrò al mare','Ginamarco','2019-10-02 22:00:00'),(81,'Tre giorni fa sono andato in mntagna','Ginamarco','2019-06-01 22:00:00'),(82,'Domani andrò in piscina','Antonio','2019-05-06 22:00:00'),(83,'Ieri sono andato al mare','Antonio','2019-11-18 23:00:00'),(84,'Tre giorni fa sono andato a sciare','Antonio','2019-07-01 22:00:00'),(85,'Tre giorni fa sono andato in mntagna','Antonio','2019-05-26 22:00:00'),(86,'Tre giorni fa sono andato a studiare','Ginamarco','2019-12-10 23:00:00'),(87,'Oggi vado in mntagna','Mario','2019-05-09 22:00:00'),(88,'Tre giorni fa sono andato a studiare','Tiziana','2019-04-05 22:00:00'),(89,'Ieri sono andato in piscina','Tiziana','2019-07-17 22:00:00'),(90,'Ieri sono andato a lavorare','Tiziana','2019-05-04 22:00:00'),(91,'Tra due giorni andrò in mntagna','Ginamarco','2019-10-07 22:00:00'),(92,'Ieri sono andato in mntagna','Ginamarco','2019-03-31 22:00:00'),(93,'Tra due giorni andrò a lavorare','Antonio','2019-12-12 23:00:00'),(94,'Oggi vado in mntagna','Mario','2019-02-13 23:00:00'),(95,'Oggi vado al mare','Mario','2019-12-26 23:00:00'),(96,'Ieri sono andato in piscina','Tiziana','2019-05-25 22:00:00'),(97,'Ieri sono andato in campagna','Erica','2019-06-30 22:00:00'),(98,'Tra due giorni andrò a fare shopping','Erica','2019-12-03 23:00:00'),(99,'Oggi vado al mare','Tiziana','2019-06-05 22:00:00');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-09 12:52:45
