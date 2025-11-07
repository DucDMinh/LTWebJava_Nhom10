CREATE DATABASE  IF NOT EXISTS `cellworld` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cellworld`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cellworld
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,2,'2025-01-05 03:20:45'),(2,3,'2025-01-06 07:43:10');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `id` int NOT NULL,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price_at_added` decimal(12,2) NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (1,1,1,'iPhone 15 Pro Max 256GB',29990000.00,1,'2025-01-05 03:21:10'),(2,1,3,'Xiaomi Redmi Note 13 Pro 5G',7990000.00,2,'2025-01-05 03:22:33'),(3,2,2,'Samsung Galaxy S23 Ultra 256GB',25990000.00,1,'2025-01-06 07:45:00');
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Apple','Các sản phẩm iPhone, iPad và phụ kiện Apple chính hãng','2025-11-06 14:32:44'),(2,'Samsung','Điện thoại và thiết bị thông minh Samsung','2025-11-06 14:32:44'),(3,'Xiaomi','Điện thoại giá tốt hiệu năng cao đến từ Xiaomi','2025-11-06 14:32:44'),(4,'OPPO','Điện thoại thời trang, chụp hình đẹp từ OPPO','2025-11-06 14:32:44');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `status` varchar(50) DEFAULT 'PENDING',
  `payment_method` varchar(50) DEFAULT 'COD',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,2,'Da Nang',420000.00,'pending','bank_transfer','2025-11-02 07:30:00'),(2,3,'Ho Chi Minh',1250000.00,'shipped','paypal','2025-11-03 02:45:00');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,250000.00,2),(2,1,2,350000.00,1),(3,2,3,210000.00,2),(4,2,2,350000.00,1);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT 'PENDING',
  `transaction_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,850000.00,'COD','success','2025-11-01 03:20:00'),(2,2,420000.00,'bank_transfer','pending','2025-11-02 07:40:00');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `price` decimal(15,2) NOT NULL,
  `discount_price` decimal(15,2) DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `image_url` varchar(500) DEFAULT NULL,
  `brand` varchar(100) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `release_year` year DEFAULT NULL,
  `screen_size` varchar(100) DEFAULT NULL,
  `screen_type` varchar(100) DEFAULT NULL,
  `cpu` varchar(150) DEFAULT NULL,
  `ram` varchar(100) DEFAULT NULL,
  `storage` varchar(100) DEFAULT NULL,
  `battery` varchar(100) DEFAULT NULL,
  `camera_spec` varchar(200) DEFAULT NULL,
  `os` varchar(100) DEFAULT NULL,
  `description` text,
  `status` tinyint DEFAULT '1',
  `category_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'iPhone 15 Pro Max 256GB','IP15PM-256',34990000.00,32990000.00,25,'/images/iphone15promax256.jpg','Apple','15 Pro Max',2023,'6.7\"','OLED 120Hz','A17 Pro','8GB','256GB','4422mAh, 27W','48MP + 12MP + 12MP','iOS 17','Flagship mạnh nhất của Apple với chip A17 Pro và khung titanium.',1,1,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(2,'iPhone 14 Pro 256GB','IP14P-256',28990000.00,25990000.00,18,'/images/iphone14pro256.jpg','Apple','14 Pro',2022,'6.1\"','OLED 120Hz','A16 Bionic','6GB','256GB','3200mAh, 20W','48MP + 12MP + 12MP','iOS 17','Sản phẩm cao cấp với Dynamic Island và camera 48MP.',1,1,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(3,'Samsung Galaxy S24 Ultra 256GB','SSS24U-256',31990000.00,29990000.00,22,'/images/s24ultra256.jpg','Samsung','Galaxy S24 Ultra',2024,'6.8\"','Dynamic AMOLED 2X 120Hz','Snapdragon 8 Gen 3','12GB','256GB','5000mAh, 45W','200MP + 50MP + 12MP + 10MP','Android 14','Flagship mạnh nhất của Samsung với S Pen và camera 200MP.',1,2,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(4,'Samsung Galaxy S23 Ultra 256GB','SSS23U-256',27990000.00,23990000.00,26,'/images/s23ultra256.jpg','Samsung','Galaxy S23 Ultra',2023,'6.8\"','Dynamic AMOLED 120Hz','Snapdragon 8 Gen 2','12GB','256GB','5000mAh, 45W','200MP + 12MP + 10MP + 10MP','Android 14','Hỗ trợ S Pen, camera siêu nét, hiệu năng mạnh.',1,2,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(5,'Xiaomi 14 256GB','XM14-256',18990000.00,17490000.00,35,'/images/xiaomi14_256.jpg','Xiaomi','14',2024,'6.36\"','OLED 120Hz','Snapdragon 8 Gen 3','12GB','256GB','4610mAh, 90W','50MP + 50MP + 50MP','Android 14','Flagship nhỏ gọn, camera Leica chất lượng.',1,3,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(6,'Xiaomi Redmi Note 13 Pro 128GB','RN13P-128',6990000.00,5990000.00,80,'/images/redmi_note13pro_128.jpg','Xiaomi','Redmi Note 13 Pro',2024,'6.67\"','AMOLED 120Hz','Snapdragon 7s Gen 2','8GB','128GB','5100mAh, 67W','200MP + 8MP + 2MP','Android 14','Giá rẻ cấu hình cao, phù hợp học sinh – sinh viên.',1,3,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(7,'OPPO Find X7 256GB','OPFX7-256',22990000.00,20990000.00,15,'/images/findx7_256.jpg','OPPO','Find X7',2024,'6.82\"','AMOLED 120Hz','Dimensity 9300','12GB','256GB','5000mAh, 100W','50MP + 50MP + 64MP','Android 14','Thiết kế cao cấp, camera đẹp, sạc siêu nhanh.',1,4,'2025-11-06 14:32:57','2025-11-06 14:32:57'),(8,'OPPO Reno10 Pro 256GB','OPR10P-256',13990000.00,11990000.00,45,'/images/reno10pro_256.jpg','OPPO','Reno10 Pro',2023,'6.7\"','AMOLED 120Hz','Snapdragon 778G','12GB','256GB','4600mAh, 80W','50MP + 32MP + 8MP','Android 14','Chụp chân dung đẹp, hiệu năng tốt, sạc nhanh.',1,4,'2025-11-06 14:32:57','2025-11-06 14:32:57');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN','Quản trị hệ thống, có toàn quyền thao tác'),(2,'STAFF','Nhân viên cửa hàng, có quyền quản lý sản phẩm và đơn hàng'),(3,'CUSTOMER','Khách hàng thông thường, có quyền mua hàng và chỉnh sửa thông tin cá nhân');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session`
--

LOCK TABLES `spring_session` WRITE;
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session_attributes`
--

LOCK TABLES `spring_session_attributes` WRITE;
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `avatar` varchar(1000) DEFAULT NULL,
  `role_id` int NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `provider` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin01','admin01@example.com','123456','Nguyen Van Admin','Ha Noi','0901234567','avatar1.png',1,'2025-11-06 21:59:39','local'),(2,'user01','user01@example.com','123456','Tran Thi A','Da Nang','0902345678','avatar2.png',2,'2025-11-06 21:59:39','local'),(3,'user02','user02@example.com','123456','Le Van B','Ho Chi Minh','0903456789','avatar3.png',2,'2025-11-06 21:59:39','google');
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

-- Dump completed on 2025-11-06 22:50:51
