-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cellworld_db
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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Apple','Thương hiệu nổi tiếng với dòng iPhone cao cấp.'),(2,'Samsung','Thương hiệu điện thoại Android hàng đầu thế giới.'),(3,'Xiaomi','Điện thoại cấu hình mạnh, giá hợp lý.'),(4,'Oppo','Thương hiệu phổ biến tại Việt Nam, nổi bật với camera selfie.'),(5,'Vivo','Hãng điện thoại chú trọng âm thanh và camera.');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,3,5,1,'2025-10-21 23:34:02'),(2,4,6,2,'2025-10-21 23:34:02'),(3,3,8,1,'2025-10-21 23:34:02');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Điện thoại thông minh','Các dòng smartphone hiện đại.'),(2,'Điện thoại phổ thông','Các dòng điện thoại cơ bản, giá rẻ.'),(3,'Phụ kiện','Các phụ kiện đi kèm điện thoại như tai nghe, sạc, ốp lưng.');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,1,34990000.00),(2,2,4,1,10990000.00),(3,3,7,1,5990000.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `status` varchar(50) DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,3,35990000.00,'DELIVERED','2025-10-10 03:15:00'),(2,4,10990000.00,'PENDING','2025-10-18 07:20:00'),(3,3,5990000.00,'DELIVERED','2025-09-25 02:30:00');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_promotions`
--

DROP TABLE IF EXISTS `product_promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_promotions` (
  `product_id` int NOT NULL,
  `promotion_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`promotion_id`),
  KEY `promotion_id` (`promotion_id`),
  CONSTRAINT `product_promotions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_promotions_ibfk_2` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_promotions`
--

LOCK TABLES `product_promotions` WRITE;
/*!40000 ALTER TABLE `product_promotions` DISABLE KEYS */;
INSERT INTO `product_promotions` VALUES (1,1),(2,1),(7,2),(8,2),(3,3),(4,3);
/*!40000 ALTER TABLE `product_promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `original_price` decimal(12,2) DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `ram` varchar(50) DEFAULT NULL,
  `storage` varchar(50) DEFAULT NULL,
  `battery` varchar(50) DEFAULT NULL,
  `screen` varchar(100) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `camera` varchar(100) DEFAULT NULL,
  `chipset` varchar(100) DEFAULT NULL,
  `sim` varchar(50) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'iPhone 15 Pro Max',34990000.00,NULL,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Flagship cao cấp của Apple, chip A17 Pro, khung titan.',NULL,1,1,'2025-10-21 23:32:25'),(2,'iPhone 15 Pro',31990000.00,NULL,40,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Chip A17 Pro, màn hình 6.1 inch Super Retina XDR.',NULL,1,1,'2025-10-21 23:32:25'),(3,'iPhone 15',25990000.00,NULL,60,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Thiết kế Dynamic Island, chip A16 Bionic.',NULL,1,1,'2025-10-21 23:32:25'),(4,'iPhone 14 Pro Max',29990000.00,NULL,35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Camera 48MP, màn hình 120Hz ProMotion.',NULL,1,1,'2025-10-21 23:32:25'),(5,'iPhone 13',18990000.00,NULL,70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hiệu năng mạnh mẽ với chip A15 Bionic.',NULL,1,1,'2025-10-21 23:32:25'),(6,'iPhone SE 2022',10990000.00,NULL,90,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mẫu iPhone nhỏ gọn, chip A15 Bionic.',NULL,1,1,'2025-10-21 23:32:25'),(7,'iPhone 12',15990000.00,NULL,80,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Thiết kế phẳng, màn hình OLED sắc nét.',NULL,1,1,'2025-10-21 23:32:25'),(8,'iPhone 11',11990000.00,NULL,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Chip A13, camera kép 12MP.',NULL,1,1,'2025-10-21 23:32:25'),(9,'AirPods Pro 2',5990000.00,NULL,120,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tai nghe chống ồn chủ động, pin 6 giờ.',NULL,3,1,'2025-10-21 23:32:25'),(10,'Apple Watch Series 9',11990000.00,NULL,45,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Đồng hồ thông minh chip S9, hỗ trợ Siri offline.',NULL,3,1,'2025-10-21 23:32:25'),(11,'Samsung Galaxy S24 Ultra',31990000.00,NULL,40,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Camera 200MP, bút S-Pen, Snapdragon 8 Gen 3.',NULL,1,2,'2025-10-21 23:32:25'),(12,'Samsung Galaxy S24+',28990000.00,NULL,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Màn hình Dynamic AMOLED 2X, pin 4700mAh.',NULL,1,2,'2025-10-21 23:32:25'),(13,'Samsung Galaxy S23 FE',16990000.00,NULL,70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hiệu năng mạnh, camera 50MP.',NULL,1,2,'2025-10-21 23:32:25'),(14,'Samsung Galaxy Z Fold5',40990000.00,NULL,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Điện thoại gập cao cấp, màn hình 7.6 inch.',NULL,1,2,'2025-10-21 23:32:25'),(15,'Samsung Galaxy Z Flip5',25990000.00,NULL,40,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Thiết kế gập dọc thời trang.',NULL,1,2,'2025-10-21 23:32:25'),(16,'Samsung Galaxy A55',10990000.00,NULL,120,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tầm trung mạnh mẽ, camera tốt.',NULL,1,2,'2025-10-21 23:32:25'),(17,'Samsung Galaxy A35',8990000.00,NULL,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Chip Exynos 1380, camera 50MP.',NULL,1,2,'2025-10-21 23:32:25'),(18,'Samsung Galaxy M14',4990000.00,NULL,200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Pin 6000mAh, sạc nhanh 25W.',NULL,1,2,'2025-10-21 23:32:25'),(19,'Tai nghe Galaxy Buds2 Pro',4990000.00,NULL,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tai nghe không dây chống ồn, âm thanh 360 độ.',NULL,3,2,'2025-10-21 23:32:25'),(20,'Sạc nhanh Samsung 45W',990000.00,NULL,300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sạc chuẩn PD, tương thích S Series.',NULL,3,2,'2025-10-21 23:32:25'),(21,'Xiaomi 14 Ultra',24990000.00,NULL,60,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Camera Leica, Snapdragon 8 Gen 3.',NULL,1,3,'2025-10-21 23:32:25'),(22,'Xiaomi 14',19990000.00,NULL,70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Màn hình AMOLED 120Hz, sạc nhanh 90W.',NULL,1,3,'2025-10-21 23:32:25'),(23,'Redmi Note 13 Pro+',9990000.00,NULL,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Thiết kế kính cong, camera 200MP.',NULL,1,3,'2025-10-21 23:32:25'),(24,'Redmi Note 13',6990000.00,NULL,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Chip Dimensity 6080, pin 5000mAh.',NULL,1,3,'2025-10-21 23:32:25'),(25,'Redmi 13C',3990000.00,NULL,200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Giá rẻ, hiệu năng ổn định.',NULL,1,3,'2025-10-21 23:32:25'),(26,'Xiaomi 13T Pro',15990000.00,NULL,80,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Chip Dimensity 9200+, camera Leica.',NULL,1,3,'2025-10-21 23:32:25'),(27,'Xiaomi Pad 6',8990000.00,NULL,90,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Máy tính bảng 11 inch, Snapdragon 870.',NULL,3,3,'2025-10-21 23:32:25'),(28,'Mi Band 8',1190000.00,NULL,150,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Vòng đeo tay thông minh, pin 16 ngày.',NULL,3,3,'2025-10-21 23:32:25'),(29,'Tai nghe Redmi Buds 5 Pro',1490000.00,NULL,200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tai nghe chống ồn chủ động, pin 10h.',NULL,3,3,'2025-10-21 23:32:25'),(30,'Sạc nhanh Xiaomi 120W',1290000.00,NULL,180,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sạc siêu nhanh cho dòng 13T, 14 Series.',NULL,3,3,'2025-10-21 23:32:25'),(31,'Oppo Reno 12 Pro',13990000.00,NULL,80,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Thiết kế cao cấp, camera 50MP.',NULL,1,4,'2025-10-21 23:32:25'),(32,'Oppo Reno 12',10990000.00,NULL,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hiệu năng tốt, pin 5000mAh.',NULL,1,4,'2025-10-21 23:32:25'),(33,'Oppo A79 5G',6990000.00,NULL,130,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Màn hình 90Hz, sạc nhanh 33W.',NULL,1,4,'2025-10-21 23:32:25'),(34,'Oppo A38',4990000.00,NULL,200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Camera kép, thiết kế trẻ trung.',NULL,1,4,'2025-10-21 23:32:25'),(35,'Oppo Find N3 Flip',24990000.00,NULL,40,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Điện thoại gập nhỏ gọn, màn hình AMOLED.',NULL,1,4,'2025-10-21 23:32:25'),(36,'Oppo Find N3',35990000.00,NULL,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gập ngang, cấu hình cao cấp.',NULL,1,4,'2025-10-21 23:32:25'),(37,'Oppo A18',3990000.00,NULL,220,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Giá rẻ, pin 5000mAh.',NULL,1,4,'2025-10-21 23:32:25'),(38,'Tai nghe Oppo Enco Air3',1290000.00,NULL,180,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Tai nghe TWS chất âm rõ, pin 25h.',NULL,3,4,'2025-10-21 23:32:25'),(39,'Sạc nhanh SuperVOOC 80W',990000.00,NULL,200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sạc nhanh độc quyền cho dòng Oppo.',NULL,3,4,'2025-10-21 23:32:25'),(40,'Oppo Watch X',9990000.00,NULL,70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Đồng hồ thông minh WearOS, GPS chính xác.',NULL,3,4,'2025-10-21 23:32:25'),(41,'iPhone 15 Pro Max 256GB',33990000.00,36990000.00,20,'8GB','256GB','4422mAh','6.7 inch OLED 120Hz','iOS 17','48MP + 12MP','Apple A17 Pro','2 Nano SIM/eSIM','221g','Titan Xám','Flagship cao cấp nhất của Apple năm 2025','iphone15promax.jpg',1,1,'2025-10-22 04:31:23'),(42,'Samsung Galaxy S24 Ultra 256GB',29990000.00,32990000.00,25,'12GB','256GB','5000mAh','6.8 inch Dynamic AMOLED 2X 120Hz','Android 14','200MP + 12MP + 10MP','Snapdragon 8 Gen 3','2 Nano SIM/eSIM','233g','Đen Phantom','Siêu phẩm Android mạnh mẽ nhất của Samsung','galaxys24ultra.jpg',1,2,'2025-10-22 04:31:23'),(43,'Xiaomi 14 Pro 512GB',15990000.00,17990000.00,30,'12GB','512GB','4880mAh','6.73 inch AMOLED 120Hz','Android 14','50MP + 50MP + 50MP','Snapdragon 8 Gen 3','2 Nano SIM','210g','Xanh Lục','Hiệu năng khủng, giá hợp lý','xiaomi14pro.jpg',1,3,'2025-10-22 04:31:23'),(44,'Oppo Reno 11 256GB',10990000.00,11990000.00,40,'8GB','256GB','4600mAh','6.7 inch AMOLED 120Hz','Android 14','50MP + 32MP + 8MP','MediaTek Dimensity 7050','2 Nano SIM','182g','Xanh Ngọc','Thiết kế đẹp, camera selfie chất lượng','opporeno11.jpg',1,4,'2025-10-22 04:31:23'),(45,'Vivo V30 256GB',9990000.00,10990000.00,35,'8GB','256GB','5000mAh','6.78 inch AMOLED 120Hz','Android 14','50MP + 50MP','Snapdragon 7 Gen 3','2 Nano SIM','185g','Tím Nhạt','Điện thoại tầm trung nổi bật với camera và sạc nhanh','vivov30.jpg',1,5,'2025-10-22 04:31:23');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `discount_type` enum('PERCENT','AMOUNT') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
INSERT INTO `promotions` VALUES (1,'Giảm giá mùa lễ hội','Giảm 10% cho tất cả điện thoại trong tháng 12.','PERCENT',10.00,'2025-12-01','2025-12-31',1),(2,'Khuyến mãi phụ kiện','Giảm 200,000đ cho đơn hàng phụ kiện trên 1 triệu.','AMOUNT',200000.00,'2025-11-01','2025-12-30',1),(3,'Flash Sale cuối tuần','Giảm 15% cho các dòng smartphone hot.','PERCENT',15.00,'2025-10-25','2025-10-27',1);
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,3,1,5,'Điện thoại rất tốt, mượt mà, pin ổn.','2025-10-21 23:34:13'),(2,4,4,4,'Máy đẹp, camera tốt nhưng pin hơi yếu.','2025-10-21 23:34:13'),(3,3,7,5,'Tai nghe chất lượng, chống ồn rất tốt.','2025-10-21 23:34:13');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_SALE'),(3,'ROLE_USER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2),(3,3),(4,3);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','{bcrypt}$2a$10$YfQ6z0u3Z0YbA2OxTthH6eZ5mQW4mC0mPY4aITa59Xz1Z4C3L/yeC','admin@cellworld.vn','Nguyen Van Admin','0900000001','1 Nguyen Trai, Q1, TP.HCM'),(2,'sale','{bcrypt}$2a$10$Aoc3W8z8Q2HzRtA1dYoHYewjq5ZV1epIbP4cAqEr9YjT7Gp2K93US','sale@cellworld.vn','Tran Thi Nhan Vien Ban Hang','0900000002','15 Le Duan, Q1, TP.HCM'),(3,'customer1','{bcrypt}$2a$10$4MEyPKj4zA8Cw6g7C/NvHu.JhRJxXJfP3oF6YFQ9xE8/y2ZZXwqKi','khach1@gmail.com','Le Hong Khach','0900000003','20 Hai Ba Trung, Q1, TP.HCM'),(4,'customer2','{bcrypt}$2a$10$y5blKM4N0U.tstqP8Wyz8uXqCPLbFq.2RIMNH7oFq0iSqt4lMZyxi','khach2@gmail.com','Pham Minh Quoc','0900000004','45 Vo Thi Sau, Q3, TP.HCM');
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

-- Dump completed on 2025-10-30 13:26:05
