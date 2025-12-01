SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS order_product;
DROP TABLE IF EXISTS cart_detail;
DROP TABLE IF EXISTS wishlist;
DROP TABLE IF EXISTS pro_configuration;
DROP TABLE IF EXISTS product_review;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS spring_session;
DROP TABLE IF EXISTS spring_session_attributes;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Bảng Roles (Được Users tham chiếu)
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Bảng Products (Được ProConfiguration, OrderProduct, Wishlist tham chiếu)
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `detail_desc` mediumtext NOT NULL,
  `short_desc` varchar(255) NOT NULL,
  `sold` bigint NOT NULL DEFAULT '0',
  `factory` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `pin` int DEFAULT NULL,
  `screen_type` varchar(255) DEFAULT NULL,
  `screen_size` double DEFAULT NULL,
  `operating_system` varchar(255) DEFAULT NULL,
  `view` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Bảng Spring Session (Độc lập)
CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `SESSION_ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- 4. Bảng Users (Phụ thuộc Roles)
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `avatar` varchar(1000) DEFAULT NULL,
  `role_id` int NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `provider` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`),
  KEY `fk_user_role` (`role_id`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 5. Bảng Pro Configuration (Phụ thuộc Products)
CREATE TABLE `pro_configuration` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `color` varchar(255) DEFAULT NULL,
  `ram` int NOT NULL,
  `storage` int NOT NULL,
  `variant_price` double DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `pro_configuration_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 6. Bảng Spring Session Attributes (Phụ thuộc Spring Session)
CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- 7. Bảng Carts (Phụ thuộc Users)
CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sum` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 8. Bảng Orders (Phụ thuộc Users)
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `total_product` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `payment_ref` varchar(50) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `order_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=716 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 9. Bảng Wishlist (Phụ thuộc Users và Products)
CREATE TABLE `wishlist` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6p7qhvy1bfkri13u29x6pu8au` (`product_id`),
  KEY `FKtrd6335blsefl2gxpb8lr0gr7` (`user_id`),
  CONSTRAINT `FK6p7qhvy1bfkri13u29x6pu8au` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKtrd6335blsefl2gxpb8lr0gr7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Bảng Cart Detail (Phụ thuộc Carts và ProConfiguration)
CREATE TABLE `cart_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` bigint NOT NULL,
  `price` double NOT NULL,
  `cart_id` bigint NOT NULL,
  `pro_configuration_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_id` (`cart_id`),
  KEY `pro_configuration_id` (`pro_configuration_id`),
  CONSTRAINT `cart_detail_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_detail_ibfk_2` FOREIGN KEY (`pro_configuration_id`) REFERENCES `pro_configuration` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 11. Bảng Order Product (Phụ thuộc Orders, Products và ProConfiguration)
CREATE TABLE `order_product` (
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  `pro_configuration_id` bigint DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  KEY `FKr751ejbun2urxd0fd5qv94oqx` (`pro_configuration_id`),
  CONSTRAINT `FKr751ejbun2urxd0fd5qv94oqx` FOREIGN KEY (`pro_configuration_id`) REFERENCES `pro_configuration` (`id`),
  CONSTRAINT `order_product_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime(6) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'ADMIN', 'ADMIN'),
(2, 'STAFF', 'STAFF'),
(3, 'USER', 'USER');

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `address`, `phone`, `avatar`, `role_id`, `created_date`, `provider`) VALUES
(1, 'admin', 'admin@gmail.com', '$2a$10$ueNj0aVmpMD2Y0Sn61gBmOT97MRHelbSZPlECUSDY5Mj.oBpX90XS', 'admin', 'hanoi', '0971152248', '1764127048642-1.png', 1, '2025-11-26 09:58:30', 'LOCAL'),
(2, 'user', 'user@gmail.com', '$2a$10$ncfpSCvXregePVB0pX6epeoODJAx0tQfzuXHOYHSSJEcyRTZKIoh.', 'user', 'saigon', '0954486635', '1764137420616-1.png', 3, '2025-11-26 13:10:21', 'LOCAL'),
(3, 'user1', 'user1@gmail.com', '$2a$10$/xq.5Y17/ayeks93olTGP.r.bcMn0CxcvfuhjR.7D7VaTBH0aggGe', 'user1', 'hai phong', '0954486631', '1764137485063-3.png', 2, '2025-11-26 13:11:25', 'LOCAL'),
(4, 'user2', 'user2@gmail.com', '$2a$10$bB64NVxqz.wqo1Q.eTB/uuNmivazdPpVYVFd72iyCXivnQ/QM9uU.', 'user2', 'ninh binh', '0954486632', '1764137516252-6.png', 3, '2025-11-26 13:11:56', 'LOCAL'),
(5, 'user3', 'user3@gmail.com', '$2a$10$8QdCr.4piWUieZfXDuTyhe6sQRfK4epIBjp0vYxFHKz6BPQ69lgUO', 'user3', 'quang ninh', '0954486633', '1764137544078-7.png', 3, '2025-11-26 13:12:24', 'LOCAL');

INSERT INTO `products` (`id`, `name`, `price`, `image`, `detail_desc`, `short_desc`, `sold`, `factory`, `category`, `pin`, `screen_type`, `screen_size`, `operating_system`, `view`) VALUES
(1, 'iPhone 15 Pro Max', 34990000, '1.png', 'Mô tả chi tiết sản phẩm iPhone 15...', 'Flagship mới nhất từ Apple', 18, 'Apple', 'Điện Thoại', 4422, 'OLED', 6.7, 'iOS', 150),
(2, 'Dell XPS 13 Plus', 45000000, '2.png', 'Mô tả chi tiết laptop Dell XPS...', 'Laptop doanh nhân cao cấp', 26, 'Dell', 'Máy Tính', 5000, 'IPS', 13.4, 'Windows', 241),
(3, 'Asus ROG Phone 7', 21990000, '3.png', 'Mô tả chi tiết Asus ROG...', 'Điện thoại gaming đỉnh cao', 23, 'Asus', 'Điện Thoại', 6000, 'AMOLED', 6.78, 'Android', 120),
(4, 'Apple Watch Series 9', 10500000, '4.png', 'Mô tả chi tiết Apple Watch...', 'Đồng hồ thông minh thế hệ mới', 70, 'Apple', 'Đồng Hồ', 308, 'Retina', 1.9, 'iOS', 500),
(5, 'HP Spectre x360', 38000000, '5.png', 'Mô tả chi tiết HP Spectre...', 'Laptop xoay gập sang trọng', 9, 'HP', 'Máy Tính', 4800, 'OLED', 14, 'Windows', 90),
(6, 'Lenovo ThinkPad X1', 42000000, '6.png', 'Mô tả chi tiết ThinkPad...', 'Bền bỉ, hiệu năng mạnh mẽ', 38, 'Lenovo', 'Máy Tính', 5200, 'IPS', 14, 'Windows', 312),
(7, 'Macbook Air M2', 27000000, '7.png', 'Mô tả chi tiết Macbook Air...', 'Mỏng nhẹ, pin trâu', 173, 'Apple', 'Máy Tính', 5000, 'Liquid Retina', 13.6, 'iOS', 600),
(8, 'Samsung Galaxy S23', 18000000, '8.png', 'Mô tả chi tiết Galaxy S23...', 'Điện thoại Android tốt nhất', 34, 'Android', 'Điện Thoại', 3900, 'Dynamic AMOLED', 6.1, 'Android', 451),
(9, 'Asus Vivobook 15', 16000000, '9.png', 'Mô tả chi tiết Vivobook...', 'Laptop văn phòng giá rẻ', 1, 'Asus', 'Máy Tính', 4200, 'IPS', 15.6, 'Windows', 100),
(10, 'Dell Inspiron 15', 15500000, '10.png', 'Mô tả chi tiết Inspiron...', 'Laptop sinh viên bền bỉ', 70, 'Dell', 'Máy Tính', 4100, 'LCD', 15.6, 'Windows', 200),
(11, 'iPhone 13', 14000000, '11.png', 'Mô tả chi tiết iPhone 13...', 'Giá tốt, hiệu năng cao', 163, 'Apple', 'Điện Thoại', 3240, 'OLED', 6.1, 'iOS', 800),
(12, 'Lenovo Legion 5', 29000000, '12.png', 'Mô tả chi tiết Legion 5...', 'Laptop gaming quốc dân', 160, 'Lenovo', 'Máy Tính', 5500, 'IPS 165Hz', '15.6', 'Windows', 340),
(13, 'Asus ZenWatch', 5000000, '13.png', 'Mô tả chi tiết ZenWatch...', 'Đồng hồ thời trang', 12, 'Asus', 'Đồng Hồ', 300, 'AMOLED', 1.4, 'Android', 50),
(14, 'HP Pavilion 15', 17000000, '14.png', 'Mô tả chi tiết HP Pavilion...', 'Thiết kế đẹp, mỏng nhẹ', 48, 'HP', 'Máy Tính', 4000, 'IPS', 15.6, 'Windows', 150),
(15, 'Macbook Pro M3', 45000000, '15.png', 'Mô tả chi tiết Macbook Pro...', 'Dành cho dân đồ họa', 147, 'Apple', 'Máy Tính', 6000, 'XDR', 14.2, 'iOS', 400),
(16, 'iPhone 11', 9000000, '16.png', 'Mô tả chi tiết iPhone 11...', 'Huyền thoại giá rẻ', 374, 'Apple', 'Điện Thoại', 3110, 'LCD', 6.1, 'iOS', 999),
(17, 'Asus TUF Gaming', 22000000, '17.png', 'Mô tả chi tiết Asus TUF...', 'Chuẩn quân đội, giá tốt', 59, 'Asus', 'Máy Tính', 4800, 'IPS 144Hz', 15.6, 'Windows', 220),
(18, 'Galaxy Watch 6', 6500000, '18.png', 'Mô tả chi tiết Galaxy Watch...', 'Theo dõi sức khỏe toàn diện', 28, 'Android', 'Đồng Hồ', 425, 'Super AMOLED', 1.5, 'Android', 130),
(19, 'Dell Latitude', 20000000, '19.png', 'Mô tả chi tiết Latitude...', 'Bảo mật cao cho doanh nghiệp', 20, 'Dell', 'Máy Tính', 4500, 'IPS', 14, 'Windows', 70),
(20, 'HP Envy 13', 24000000, '20.png', 'Mô tả chi tiết HP Envy...', 'Nhỏ gọn, màn hình đẹp', 50, 'HP', 'Máy Tính', 4300, 'OLED', 13.3, 'Windows', 180),
(21, '123', 1000, '1764157046887-addtocart.png', '123', '123', 0, 'Apple (Macbook)', 'Máy Tính', 123, '123', 123, 'Windows', 3);

INSERT INTO `orders` (`id`, `user_id`, `total_price`, `address`, `total_product`, `status`, `payment_ref`, `payment_status`, `payment_method`, `created_date`, `order_date`) VALUES
('522', '2', '71666165', 'Tòa nhà Keangnam, HN', '5', 'COMPLETED', 'VNPAY_0601_688', 'UNPAID', 'BANKING', '2025-06-01 14:17:03', '2025-06-01 14:17:03.000000'),
('523', '1', '30465981', '88 Láng Hạ, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-01 18:09:06', '2025-06-01 18:09:06.000000'),
('524', '3', '12804408', 'Số 45 Nguyễn Chí Thanh', '1', 'COMPLETED', 'VNPAY_0602_501', 'UNPAID', 'BANKING', '2025-06-02 21:06:18', '2025-06-02 21:06:18.000000'),
('525', '1', '45863948', 'Khu tập thể Thành Công', '4', 'COMPLETED', 'VNPAY_0602_437', 'UNPAID', 'BANKING', '2025-06-02 08:50:58', '2025-06-02 08:50:58.000000'),
('526', '4', '5814918', 'Vinhomes Ocean Park', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-02 10:13:39', '2025-06-02 10:13:39.000000'),
('527', '3', '12881486', 'Ngõ Gốc Đề, Minh Khai', '2', 'PENDING', 'VNPAY_0603_419', 'UNPAID', 'BANKING', '2025-06-03 19:11:56', '2025-06-03 19:11:56.000000'),
('528', '2', '41337147', '88 Láng Hạ, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-03 13:02:58', '2025-06-03 13:02:58.000000'),
('529', '4', '13490398', 'Số 45 Nguyễn Chí Thanh', '2', 'COMPLETED', 'VNPAY_0603_393', 'PAID', 'BANKING', '2025-06-03 19:19:34', '2025-06-03 19:19:34.000000'),
('530', '3', '11878416', 'Ngõ 105 Láng Hạ', '3', 'PENDING', 'VNPAY_0605_775', 'UNPAID', 'BANKING', '2025-06-05 14:56:55', '2025-06-05 14:56:55.000000'),
('531', '1', '20835090', 'Số 5 Trần Phú, Hà Đông', '2', 'COMPLETED', 'VNPAY_0605_353', 'PAID', 'BANKING', '2025-06-05 20:43:37', '2025-06-05 20:43:37.000000'),
('532', '4', '33243628', '88 Láng Hạ, HN', '4', 'PENDING', 'VNPAY_0606_633', 'UNPAID', 'BANKING', '2025-06-06 11:49:56', '2025-06-06 11:49:56.000000'),
('533', '4', '16791090', 'Số 5 Trần Phú, Hà Đông', '2', 'COMPLETED', 'VNPAY_0606_115', 'PAID', 'BANKING', '2025-06-06 12:24:24', '2025-06-06 12:24:24.000000'),
('534', '5', '33623655', '88 Láng Hạ, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-09 20:56:33', '2025-06-09 20:56:33.000000'),
('535', '1', '59007915', 'Số 12 Chùa Bộc, Đống Đa, HN', '5', 'PENDING', NULL, 'UNPAID', 'COD', '2025-06-09 11:39:20', '2025-06-09 11:39:20.000000'),
('536', '3', '25004982', 'Ngõ 68 Cầu Giấy', '3', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-06-10 13:29:52', '2025-06-10 13:29:52.000000'),
('537', '3', '33431619', 'Ngõ 175 Xuân Thủy', '3', 'SHIPPING', 'VNPAY_0610_453', 'UNPAID', 'BANKING', '2025-06-10 17:16:25', '2025-06-10 17:16:25.000000'),
('538', '5', '11437555', 'Số 5 Trần Phú, Hà Đông', '5', 'COMPLETED', 'VNPAY_0611_697', 'PAID', 'BANKING', '2025-06-11 11:19:52', '2025-06-11 11:19:52.000000'),
('539', '5', '17681648', 'Khu đô thị Ecopark', '4', 'COMPLETED', 'VNPAY_0612_762', 'PAID', 'BANKING', '2025-06-12 14:55:00', '2025-06-12 14:55:00.000000'),
('540', '4', '3420117', 'Khu tập thể Thành Công', '1', 'COMPLETED', 'VNPAY_0613_402', 'PAID', 'BANKING', '2025-06-13 09:58:45', '2025-06-13 09:58:45.000000'),
('541', '4', '33076296', 'Số 10 Trần Duy Hưng', '3', 'CANCELLED', 'VNPAY_0613_157', 'UNPAID', 'BANKING', '2025-06-13 10:42:23', '2025-06-13 10:42:23.000000'),
('542', '4', '20764254', 'Ngõ 20 Hồ Tùng Mậu, HN', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-14 14:11:38', '2025-06-14 14:11:38.000000'),
('543', '4', '15825789', 'Vinhomes Ocean Park', '3', 'COMPLETED', 'VNPAY_0618_771', 'PAID', 'BANKING', '2025-06-18 09:48:49', '2025-06-18 09:48:49.000000'),
('544', '1', '28572969', 'Số 9 Lê Thanh Nghị', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-20 08:03:15', '2025-06-20 08:03:15.000000'),
('545', '3', '21811302', 'Tòa IPH Xuân Thủy', '2', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-06-20 14:28:40', '2025-06-20 14:28:40.000000'),
('546', '2', '11960803', 'Khu đô thị Ecopark', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-20 08:09:01', '2025-06-20 08:09:01.000000'),
('547', '5', '30943704', 'Khu tập thể Thành Công', '4', 'COMPLETED', 'VNPAY_0622_136', 'PAID', 'BANKING', '2025-06-22 17:15:47', '2025-06-22 17:15:47.000000'),
('548', '2', '2795796', 'Ngõ 68 Cầu Giấy', '4', 'PENDING', NULL, 'UNPAID', 'COD', '2025-06-22 18:42:31', '2025-06-22 18:42:31.000000'),
('549', '2', '45094190', 'Số 33 Tràng Thi', '5', 'SHIPPING', 'VNPAY_0622_307', 'UNPAID', 'BANKING', '2025-06-22 14:12:17', '2025-06-22 14:12:17.000000'),
('550', '1', '35460639', 'Ngõ 20 Hồ Tùng Mậu, HN', '3', 'PENDING', NULL, 'UNPAID', 'COD', '2025-06-23 14:41:40', '2025-06-23 14:41:40.000000'),
('551', '2', '16255115', 'Số 10 Trần Duy Hưng', '5', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-06-24 18:43:26', '2025-06-24 18:43:26.000000'),
('552', '3', '10485049', 'Gamuda Gardens, Hoàng Mai', '1', 'PENDING', 'VNPAY_0624_500', 'UNPAID', 'BANKING', '2025-06-24 17:35:22', '2025-06-24 17:35:22.000000'),
('553', '2', '15402732', 'Gamuda Gardens, Hoàng Mai', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-24 13:54:49', '2025-06-24 13:54:49.000000'),
('554', '1', '4781381', '88 Láng Hạ, HN', '1', 'PENDING', 'VNPAY_0626_223', 'UNPAID', 'BANKING', '2025-06-26 20:32:38', '2025-06-26 20:32:38.000000'),
('555', '2', '8533150', 'Khu đô thị Ecopark', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-06-27 09:16:02', '2025-06-27 09:16:02.000000'),
('556', '5', '3246398', 'Ngõ 105 Láng Hạ', '2', 'COMPLETED', 'VNPAY_0628_329', 'PAID', 'BANKING', '2025-06-28 08:28:26', '2025-06-28 08:28:26.000000'),
('557', '5', '21940300', 'P.405, KTX Bách Khoa, HN', '4', 'PENDING', NULL, 'UNPAID', 'COD', '2025-06-29 08:05:58', '2025-06-29 08:05:58.000000'),
('558', '5', '46934760', 'Gamuda Gardens, Hoàng Mai', '5', 'COMPLETED', 'VNPAY_0702_421', 'PAID', 'BANKING', '2025-07-02 17:54:12', '2025-07-02 17:54:12.000000'),
('559', '2', '13683388', '102 Thái Thịnh, HN', '2', 'COMPLETED', 'VNPAY_0704_791', 'PAID', 'BANKING', '2025-07-04 17:43:40', '2025-07-04 17:43:40.000000'),
('560', '5', '31889472', 'Ngõ 68 Cầu Giấy', '4', 'COMPLETED', 'VNPAY_0704_880', 'PAID', 'BANKING', '2025-07-04 20:06:15', '2025-07-04 20:06:15.000000'),
('561', '1', '49859724', '102 Thái Thịnh, HN', '4', 'SHIPPING', 'VNPAY_0704_685', 'UNPAID', 'BANKING', '2025-07-04 14:03:37', '2025-07-04 14:03:37.000000'),
('562', '4', '12324168', 'Số 45 Nguyễn Chí Thanh', '2', 'CANCELLED', 'VNPAY_0705_348', 'UNPAID', 'BANKING', '2025-07-05 12:51:02', '2025-07-05 12:51:02.000000'),
('563', '5', '37413395', '88 Láng Hạ, HN', '5', 'COMPLETED', 'VNPAY_0705_448', 'PAID', 'BANKING', '2025-07-05 12:19:38', '2025-07-05 12:19:38.000000'),
('564', '3', '17827458', 'Ngõ 20 Hồ Tùng Mậu, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-07-05 09:33:20', '2025-07-05 09:33:20.000000'),
('565', '5', '19921437', 'Ngõ 175 Xuân Thủy', '3', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-07-06 19:47:58', '2025-07-06 19:47:58.000000'),
('566', '3', '12274446', 'Số 12 Chùa Bộc, Đống Đa, HN', '2', 'COMPLETED', 'VNPAY_0707_818', 'PAID', 'BANKING', '2025-07-07 08:43:35', '2025-07-07 08:43:35.000000'),
('567', '4', '18947924', 'Ngõ 20 Hồ Tùng Mậu, HN', '2', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-10 17:00:50', '2025-07-10 17:00:50.000000'),
('568', '5', '5457831', 'Số 45 Nguyễn Chí Thanh', '1', 'CANCELLED', 'VNPAY_0711_128', 'UNPAID', 'BANKING', '2025-07-11 10:12:18', '2025-07-11 10:12:18.000000'),
('569', '5', '4034724', 'Số 33 Tràng Thi', '4', 'SHIPPING', 'VNPAY_0711_857', 'UNPAID', 'BANKING', '2025-07-11 16:47:54', '2025-07-11 16:47:54.000000'),
('570', '3', '22587400', 'Khu tập thể Thành Công', '4', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-12 17:23:26', '2025-07-12 17:23:26.000000'),
('571', '3', '25805750', 'Ngõ Gốc Đề, Minh Khai', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-07-14 11:26:08', '2025-07-14 11:26:08.000000'),
('572', '1', '36586881', '88 Láng Hạ, HN', '3', 'COMPLETED', 'VNPAY_0716_777', 'PAID', 'BANKING', '2025-07-16 11:43:14', '2025-07-16 11:43:14.000000'),
('573', '5', '6496084', 'Khu tập thể Thành Công', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-07-16 16:28:15', '2025-07-16 16:28:15.000000'),
('574', '2', '1926492', '102 Thái Thịnh, HN', '1', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-07-16 12:05:06', '2025-07-16 12:05:06.000000'),
('575', '3', '870372', 'Ngõ 175 Xuân Thủy', '1', 'COMPLETED', 'VNPAY_0717_476', 'PAID', 'BANKING', '2025-07-17 17:03:17', '2025-07-17 17:03:17.000000'),
('576', '2', '27382466', 'Gamuda Gardens, Hoàng Mai', '2', 'COMPLETED', 'VNPAY_0717_542', 'PAID', 'BANKING', '2025-07-17 14:51:46', '2025-07-17 14:51:46.000000'),
('577', '4', '8076644', 'Ngõ 105 Láng Hạ', '2', 'PENDING', NULL, 'UNPAID', 'COD', '2025-07-18 18:34:02', '2025-07-18 18:34:02.000000'),
('578', '3', '29710405', 'Ngõ 20 Hồ Tùng Mậu, HN', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-07-18 16:47:48', '2025-07-18 16:47:48.000000'),
('579', '1', '2643783', 'Số 9 Lê Thanh Nghị', '1', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-20 21:31:16', '2025-07-20 21:31:16.000000'),
('580', '4', '2154678', '88 Láng Hạ, HN', '2', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-07-22 17:57:27', '2025-07-22 17:57:27.000000'),
('581', '1', '30905684', '102 Thái Thịnh, HN', '4', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-23 17:06:29', '2025-07-23 17:06:29.000000'),
('582', '1', '68090540', 'Số 45 Nguyễn Chí Thanh', '5', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-28 16:13:15', '2025-07-28 16:13:15.000000'),
('583', '1', '37322448', '88 Láng Hạ, HN', '4', 'CANCELLED', 'VNPAY_0728_164', 'UNPAID', 'BANKING', '2025-07-28 21:24:51', '2025-07-28 21:24:51.000000'),
('584', '5', '63074340', 'Số 5 Trần Phú, Hà Đông', '5', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-28 12:53:23', '2025-07-28 12:53:23.000000'),
('585', '5', '3318304', 'Số 2 Bà Triệu', '1', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-07-30 21:48:56', '2025-07-30 21:48:56.000000'),
('586', '5', '16779824', 'Ngõ 175 Xuân Thủy', '2', 'PENDING', 'VNPAY_0801_685', 'UNPAID', 'BANKING', '2025-08-01 13:26:33', '2025-08-01 13:26:33.000000'),
('587', '3', '8202494', 'Số 45 Nguyễn Chí Thanh', '2', 'PENDING', NULL, 'UNPAID', 'COD', '2025-08-01 18:23:11', '2025-08-01 18:23:11.000000'),
('588', '5', '18401859', 'Khu tập thể Thành Công', '3', 'CANCELLED', 'VNPAY_0805_195', 'UNPAID', 'BANKING', '2025-08-05 10:35:11', '2025-08-05 10:35:11.000000'),
('589', '2', '5242104', 'Ngõ 175 Xuân Thủy', '2', 'COMPLETED', 'VNPAY_0805_232', 'PAID', 'BANKING', '2025-08-05 17:11:53', '2025-08-05 17:11:53.000000'),
('590', '3', '63843000', 'Ngõ Gốc Đề, Minh Khai', '5', 'COMPLETED', 'VNPAY_0806_405', 'PAID', 'BANKING', '2025-08-06 18:34:51', '2025-08-06 18:34:51.000000'),
('591', '2', '6996822', 'Ngõ 105 Láng Hạ', '2', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-08-07 14:18:22', '2025-08-07 14:18:22.000000'),
('592', '4', '4576793', 'Số 12 Chùa Bộc, Đống Đa, HN', '1', 'PENDING', 'VNPAY_0807_743', 'UNPAID', 'BANKING', '2025-08-07 20:12:42', '2025-08-07 20:12:42.000000'),
('593', '3', '64427280', 'P.405, KTX Bách Khoa, HN', '5', 'COMPLETED', 'VNPAY_0807_901', 'PAID', 'BANKING', '2025-08-07 12:28:59', '2025-08-07 12:28:59.000000'),
('594', '4', '8346865', 'Số 12 Chùa Bộc, Đống Đa, HN', '1', 'PENDING', NULL, 'UNPAID', 'COD', '2025-08-08 16:29:24', '2025-08-08 16:29:24.000000'),
('595', '3', '7547996', '88 Láng Hạ, HN', '4', 'SHIPPING', 'VNPAY_0808_315', 'UNPAID', 'BANKING', '2025-08-08 11:58:39', '2025-08-08 11:58:39.000000'),
('596', '5', '28107681', 'Ngõ 20 Hồ Tùng Mậu, HN', '3', 'COMPLETED', 'VNPAY_0808_243', 'PAID', 'BANKING', '2025-08-08 18:51:38', '2025-08-08 18:51:38.000000'),
('597', '5', '15486204', 'Số 9 Lê Thanh Nghị', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-09 18:50:03', '2025-08-09 18:50:03.000000'),
('598', '3', '32064740', 'Ngõ Gốc Đề, Minh Khai', '5', 'CANCELLED', 'VNPAY_0809_885', 'UNPAID', 'BANKING', '2025-08-09 20:57:57', '2025-08-09 20:57:57.000000'),
('599', '1', '14437341', '88 Láng Hạ, HN', '1', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-08-11 12:17:21', '2025-08-11 12:17:21.000000'),
('600', '3', '7558944', 'Số 12 Chùa Bộc, Đống Đa, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-11 14:46:56', '2025-08-11 14:46:56.000000'),
('601', '2', '38060376', 'Số 2 Bà Triệu', '4', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-12 16:27:34', '2025-08-12 16:27:34.000000'),
('602', '4', '14245609', 'Khu tập thể Thành Công', '1', 'COMPLETED', 'VNPAY_0813_913', 'PAID', 'BANKING', '2025-08-13 15:43:52', '2025-08-13 15:43:52.000000'),
('603', '4', '65605170', 'Số 5 Trần Phú, Hà Đông', '5', 'CANCELLED', 'VNPAY_0813_360', 'UNPAID', 'BANKING', '2025-08-13 18:02:20', '2025-08-13 18:02:20.000000'),
('604', '1', '14069543', 'Số 5 Trần Phú, Hà Đông', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-13 16:05:43', '2025-08-13 16:05:43.000000'),
('605', '1', '42105258', 'Ngõ 68 Cầu Giấy', '3', 'SHIPPING', 'VNPAY_0815_300', 'UNPAID', 'BANKING', '2025-08-15 20:03:33', '2025-08-15 20:03:33.000000'),
('606', '2', '9894089', 'Gamuda Gardens, Hoàng Mai', '1', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-08-15 18:42:04', '2025-08-15 18:42:04.000000'),
('607', '1', '38163135', 'P.405, KTX Bách Khoa, HN', '5', 'COMPLETED', 'VNPAY_0816_463', 'PAID', 'BANKING', '2025-08-16 19:14:06', '2025-08-16 19:14:06.000000'),
('608', '2', '61818330', 'Số 12 Chùa Bộc, Đống Đa, HN', '5', 'PENDING', NULL, 'UNPAID', 'COD', '2025-08-18 08:14:38', '2025-08-18 08:14:38.000000'),
('609', '2', '43838751', 'Gamuda Gardens, Hoàng Mai', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-18 09:35:36', '2025-08-18 09:35:36.000000'),
('610', '2', '23822712', 'Tòa IPH Xuân Thủy', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-19 17:07:10', '2025-08-19 17:07:10.000000'),
('611', '2', '34681636', 'Khu tập thể Thành Công', '4', 'CANCELLED', 'VNPAY_0819_477', 'UNPAID', 'BANKING', '2025-08-19 09:14:02', '2025-08-19 09:14:02.000000'),
('612', '2', '49079580', '102 Thái Thịnh, HN', '4', 'PENDING', 'VNPAY_0821_687', 'UNPAID', 'BANKING', '2025-08-21 19:47:30', '2025-08-21 19:47:30.000000'),
('613', '3', '26123252', 'Số 45 Nguyễn Chí Thanh', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-21 17:15:19', '2025-08-21 17:15:19.000000'),
('614', '1', '43563730', 'Ngõ 105 Láng Hạ', '5', 'COMPLETED', 'VNPAY_0821_100', 'PAID', 'BANKING', '2025-08-21 17:02:25', '2025-08-21 17:02:25.000000'),
('615', '1', '37234401', 'Số 10 Trần Duy Hưng', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-23 16:30:44', '2025-08-23 16:30:44.000000'),
('616', '3', '7667941', 'Tòa nhà Keangnam, HN', '1', 'SHIPPING', 'VNPAY_0823_172', 'UNPAID', 'BANKING', '2025-08-23 19:47:08', '2025-08-23 19:47:08.000000'),
('617', '5', '6106970', 'Số 45 Nguyễn Chí Thanh', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-24 13:39:29', '2025-08-24 13:39:29.000000'),
('618', '4', '6296271', 'Khu tập thể Thành Công', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-28 16:48:13', '2025-08-28 16:48:13.000000'),
('619', '3', '1375264', '88 Láng Hạ, HN', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-28 20:30:15', '2025-08-28 20:30:15.000000'),
('620', '5', '22416148', 'Ngõ 105 Láng Hạ', '2', 'COMPLETED', 'VNPAY_0830_212', 'PAID', 'BANKING', '2025-08-30 18:21:48', '2025-08-30 18:21:48.000000'),
('621', '4', '60094410', 'Ngõ 20 Hồ Tùng Mậu, HN', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-08-30 08:52:23', '2025-08-30 08:52:23.000000'),
('622', '2', '28574862', 'Số 10 Trần Duy Hưng', '3', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-08-31 12:00:55', '2025-08-31 12:00:55.000000'),
('623', '3', '55668340', 'Số 33 Tràng Thi', '4', 'CANCELLED', 'VNPAY_0901_856', 'UNPAID', 'BANKING', '2025-09-01 17:27:40', '2025-09-01 17:27:40.000000'),
('624', '3', '37226788', 'Khu đô thị Ecopark', '4', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-09-02 11:13:45', '2025-09-02 11:13:45.000000'),
('625', '1', '19409985', 'P.405, KTX Bách Khoa, HN', '5', 'SHIPPING', 'VNPAY_0903_411', 'UNPAID', 'BANKING', '2025-09-03 14:56:24', '2025-09-03 14:56:24.000000'),
('626', '2', '30971975', 'P.405, KTX Bách Khoa, HN', '5', 'PENDING', 'VNPAY_0903_922', 'UNPAID', 'BANKING', '2025-09-03 10:05:07', '2025-09-03 10:05:07.000000'),
('627', '1', '43526589', 'Ngõ 20 Hồ Tùng Mậu, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-04 19:57:27', '2025-09-04 19:57:27.000000'),
('628', '2', '2541273', 'Ngõ Gốc Đề, Minh Khai', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-04 11:37:49', '2025-09-04 11:37:49.000000'),
('629', '5', '3969792', '102 Thái Thịnh, HN', '3', 'SHIPPING', 'VNPAY_0905_556', 'UNPAID', 'BANKING', '2025-09-05 17:33:50', '2025-09-05 17:33:50.000000'),
('630', '1', '29571958', 'Số 33 Tràng Thi', '2', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-09-07 19:56:51', '2025-09-07 19:56:51.000000'),
('631', '1', '2589174', 'Số 33 Tràng Thi', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-07 15:05:58', '2025-09-07 15:05:58.000000'),
('632', '2', '25698116', 'Số 12 Chùa Bộc, Đống Đa, HN', '2', 'COMPLETED', 'VNPAY_0908_797', 'PAID', 'BANKING', '2025-09-08 18:06:19', '2025-09-08 18:06:19.000000'),
('633', '3', '9296151', 'Tòa IPH Xuân Thủy', '3', 'COMPLETED', 'VNPAY_0909_254', 'PAID', 'BANKING', '2025-09-09 13:46:15', '2025-09-09 13:46:15.000000'),
('634', '5', '1175999', 'Khu tập thể Thành Công', '1', 'COMPLETED', 'VNPAY_0909_395', 'PAID', 'BANKING', '2025-09-09 16:39:53', '2025-09-09 16:39:53.000000'),
('635', '4', '74411110', 'Vinhomes Ocean Park', '5', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-09-10 09:13:05', '2025-09-10 09:13:05.000000'),
('636', '1', '3221844', '102 Thái Thịnh, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-11 12:17:57', '2025-09-11 12:17:57.000000'),
('637', '5', '10944035', 'Tòa nhà Keangnam, HN', '5', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-09-13 20:54:00', '2025-09-13 20:54:00.000000'),
('638', '1', '2567043', 'Ngõ Gốc Đề, Minh Khai', '3', 'CANCELLED', 'VNPAY_0916_231', 'UNPAID', 'BANKING', '2025-09-16 11:29:07', '2025-09-16 11:29:07.000000'),
('639', '5', '2977204', 'Ngõ Gốc Đề, Minh Khai', '4', 'PENDING', NULL, 'UNPAID', 'COD', '2025-09-17 08:51:55', '2025-09-17 08:51:55.000000'),
('640', '4', '36144663', 'P.405, KTX Bách Khoa, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-17 14:03:41', '2025-09-17 14:03:41.000000'),
('641', '5', '28723464', 'Gamuda Gardens, Hoàng Mai', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-20 15:52:36', '2025-09-20 15:52:36.000000'),
('642', '4', '15013284', 'Ngõ 105 Láng Hạ', '2', 'CANCELLED', 'VNPAY_0920_755', 'UNPAID', 'BANKING', '2025-09-20 14:28:13', '2025-09-20 14:28:13.000000'),
('643', '5', '13157176', 'Ngõ 105 Láng Hạ', '1', 'COMPLETED', 'VNPAY_0923_730', 'PAID', 'BANKING', '2025-09-23 13:14:24', '2025-09-23 13:14:24.000000'),
('644', '1', '25898214', 'Số 9 Lê Thanh Nghị', '3', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-09-23 11:10:35', '2025-09-23 11:10:35.000000'),
('645', '1', '39530448', 'Số 10 Trần Duy Hưng', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-24 17:08:14', '2025-09-24 17:08:14.000000'),
('646', '1', '9409195', 'Vinhomes Ocean Park', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-25 18:04:47', '2025-09-25 18:04:47.000000'),
('647', '3', '17603988', 'P.405, KTX Bách Khoa, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-09-25 13:06:05', '2025-09-25 13:06:05.000000'),
('648', '2', '57967580', 'Số 45 Nguyễn Chí Thanh', '4', 'COMPLETED', 'VNPAY_0925_996', 'PAID', 'BANKING', '2025-09-25 18:39:11', '2025-09-25 18:39:11.000000'),
('649', '3', '49093224', 'P.405, KTX Bách Khoa, HN', '4', 'SHIPPING', 'VNPAY_0927_527', 'UNPAID', 'BANKING', '2025-09-27 10:50:05', '2025-09-27 10:50:05.000000'),
('650', '3', '23476850', 'Tòa IPH Xuân Thủy', '2', 'COMPLETED', 'VNPAY_0928_827', 'PAID', 'BANKING', '2025-09-28 17:15:12', '2025-09-28 17:15:12.000000'),
('651', '1', '5310830', 'Khu đô thị Ecopark', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-02 12:26:35', '2025-10-02 12:26:35.000000'),
('652', '4', '7610591', 'Ngõ 68 Cầu Giấy', '1', 'PENDING', 'VNPAY_1002_416', 'UNPAID', 'BANKING', '2025-10-02 18:52:31', '2025-10-02 18:52:31.000000'),
('653', '5', '11613168', 'Ngõ 20 Hồ Tùng Mậu, HN', '4', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-10-02 19:02:31', '2025-10-02 19:02:31.000000'),
('654', '3', '31014888', 'Ngõ 175 Xuân Thủy', '4', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-04 15:00:07', '2025-10-04 15:00:07.000000'),
('655', '4', '29076120', 'Ngõ 20 Hồ Tùng Mậu, HN', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-05 19:04:47', '2025-10-05 19:04:47.000000'),
('656', '4', '4498071', 'Số 12 Chùa Bộc, Đống Đa, HN', '1', 'COMPLETED', 'VNPAY_1007_725', 'PAID', 'BANKING', '2025-10-07 13:48:28', '2025-10-07 13:48:28.000000'),
('657', '5', '5765836', 'Ngõ 175 Xuân Thủy', '2', 'COMPLETED', 'VNPAY_1007_862', 'PAID', 'BANKING', '2025-10-07 13:26:34', '2025-10-07 13:26:34.000000'),
('658', '3', '34058487', 'Số 45 Nguyễn Chí Thanh', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-08 14:06:14', '2025-10-08 14:06:14.000000'),
('659', '1', '22356126', 'Ngõ 175 Xuân Thủy', '2', 'PENDING', NULL, 'UNPAID', 'COD', '2025-10-09 09:28:36', '2025-10-09 09:28:36.000000'),
('660', '5', '13533288', 'Số 5 Trần Phú, Hà Đông', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-10 12:35:55', '2025-10-10 12:35:55.000000'),
('661', '2', '55885036', 'Ngõ 68 Cầu Giấy', '4', 'COMPLETED', 'VNPAY_1010_872', 'PAID', 'BANKING', '2025-10-10 12:32:21', '2025-10-10 12:32:21.000000'),
('662', '4', '14398912', 'Số 10 Trần Duy Hưng', '1', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-10-10 10:06:29', '2025-10-10 10:06:29.000000'),
('663', '4', '41651120', 'Ngõ 20 Hồ Tùng Mậu, HN', '5', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-10-11 13:35:07', '2025-10-11 13:35:07.000000'),
('664', '3', '12950290', 'P.405, KTX Bách Khoa, HN', '2', 'PENDING', NULL, 'UNPAID', 'COD', '2025-10-11 21:20:56', '2025-10-11 21:20:56.000000'),
('665', '2', '41132247', 'Số 10 Trần Duy Hưng', '3', 'SHIPPING', 'VNPAY_1011_194', 'UNPAID', 'BANKING', '2025-10-11 18:54:54', '2025-10-11 18:54:54.000000'),
('666', '3', '26729132', 'Khu đô thị Ecopark', '4', 'COMPLETED', 'VNPAY_1012_240', 'PAID', 'BANKING', '2025-10-12 19:50:33', '2025-10-12 19:50:33.000000'),
('667', '5', '13956667', 'Số 9 Lê Thanh Nghị', '1', 'SHIPPING', 'VNPAY_1012_450', 'UNPAID', 'BANKING', '2025-10-12 09:03:43', '2025-10-12 09:03:43.000000'),
('668', '2', '2952834', 'Số 2 Bà Triệu', '1', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-10-13 17:39:03', '2025-10-13 17:39:03.000000'),
('669', '4', '42539725', 'Số 33 Tràng Thi', '5', 'PENDING', NULL, 'UNPAID', 'COD', '2025-10-15 21:10:54', '2025-10-15 21:10:54.000000'),
('670', '3', '4937613', 'Khu đô thị Ecopark', '1', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-10-17 21:37:11', '2025-10-17 21:37:11.000000'),
('671', '2', '65818935', 'Ngõ 68 Cầu Giấy', '5', 'COMPLETED', 'VNPAY_1018_911', 'PAID', 'BANKING', '2025-10-18 09:22:53', '2025-10-18 09:22:53.000000'),
('672', '5', '11034280', 'Số 5 Trần Phú, Hà Đông', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-18 08:08:33', '2025-10-18 08:08:33.000000'),
('673', '5', '4398181', 'Ngõ 105 Láng Hạ', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-20 19:49:00', '2025-10-20 19:49:00.000000'),
('674', '3', '10133018', 'Số 2 Bà Triệu', '1', 'PENDING', 'VNPAY_1021_721', 'UNPAID', 'BANKING', '2025-10-21 18:01:54', '2025-10-21 18:01:54.000000'),
('675', '3', '14222873', 'Ngõ 68 Cầu Giấy', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-22 18:46:57', '2025-10-22 18:46:57.000000'),
('676', '1', '4959774', 'Số 5 Trần Phú, Hà Đông', '3', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-22 14:31:12', '2025-10-22 14:31:12.000000'),
('677', '3', '16490920', 'Số 5 Trần Phú, Hà Đông', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-25 11:56:28', '2025-10-25 11:56:28.000000'),
('678', '5', '4766059', 'Tòa nhà Keangnam, HN', '1', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-10-26 08:58:37', '2025-10-26 08:58:37.000000'),
('679', '2', '37095205', 'Số 12 Chùa Bộc, Đống Đa, HN', '5', 'CANCELLED', 'VNPAY_1026_471', 'UNPAID', 'BANKING', '2025-10-26 10:06:34', '2025-10-26 10:06:34.000000'),
('680', '4', '30846579', 'Khu đô thị Ecopark', '3', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-10-26 11:57:08', '2025-10-26 11:57:08.000000'),
('681', '4', '38320912', 'P.405, KTX Bách Khoa, HN', '4', 'CANCELLED', 'VNPAY_1030_200', 'UNPAID', 'BANKING', '2025-10-30 09:11:09', '2025-10-30 09:11:09.000000'),
('682', '3', '3615408', 'Số 10 Trần Duy Hưng', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-10-31 10:59:39', '2025-10-31 10:59:39.000000'),
('683', '5', '8525816', 'Tòa IPH Xuân Thủy', '1', 'CANCELLED', 'VNPAY_1031_956', 'UNPAID', 'BANKING', '2025-10-31 10:24:38', '2025-10-31 10:24:38.000000'),
('684', '2', '21063268', 'Số 5 Trần Phú, Hà Đông', '4', 'SHIPPING', 'VNPAY_1101_625', 'UNPAID', 'BANKING', '2025-11-01 14:40:09', '2025-11-01 14:40:09.000000'),
('685', '1', '4071958', 'Số 9 Lê Thanh Nghị', '2', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-11-01 21:22:24', '2025-11-01 21:22:24.000000'),
('686', '1', '13332860', 'Số 10 Trần Duy Hưng', '4', 'CANCELLED', NULL, 'UNPAID', 'COD', '2025-11-02 14:18:55', '2025-11-02 14:18:55.000000'),
('687', '3', '10960480', 'Số 9 Lê Thanh Nghị', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-11-02 21:48:44', '2025-11-02 21:48:44.000000'),
('688', '4', '5677824', 'Ngõ 20 Hồ Tùng Mậu, HN', '2', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-11-03 09:12:35', '2025-11-03 09:12:35.000000'),
('689', '3', '24926192', 'Số 33 Tràng Thi', '4', 'COMPLETED', NULL, 'PAID', 'COD', '2025-11-06 21:49:40', '2025-11-06 21:49:40.000000'),
('690', '1', '65426485', 'Tòa IPH Xuân Thủy', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-11-09 20:36:18', '2025-11-09 20:36:18.000000'),
('691', '5', '28331670', 'Khu đô thị Ecopark', '5', 'SHIPPING', NULL, 'UNPAID', 'COD', '2025-11-09 21:04:53', '2025-11-09 21:04:53.000000'),
('692', '5', '7163574', 'Số 5 Trần Phú, Hà Đông', '2', 'SHIPPING', 'VNPAY_1111_223', 'UNPAID', 'BANKING', '2025-11-11 16:35:24', '2025-11-11 16:35:24.000000'),
('693', '1', '31823160', 'Ngõ 68 Cầu Giấy', '5', 'COMPLETED', NULL, 'PAID', 'COD', '2025-11-15 15:39:06', '2025-11-15 15:39:06.000000'),
('694', '3', '49025812', 'Số 10 Trần Duy Hưng', '4', 'COMPLETED', 'VNPAY_1116_665', 'PAID', 'BANKING', '2025-11-16 16:37:46', '2025-11-16 16:37:46.000000'),
('695', '3', '46187804', 'Vinhomes Ocean Park', '4', 'COMPLETED', 'VNPAY_1116_525', 'PAID', 'BANKING', '2025-11-16 12:20:06', '2025-11-16 12:20:06.000000'),
('696', '4', '28889144', 'Ngõ 105 Láng Hạ', '4', 'COMPLETED', 'VNPAY_1116_648', 'PAID', 'BANKING', '2025-11-16 10:51:35', '2025-11-16 10:51:35.000000'),
('697', '2', '7562200', 'Ngõ Gốc Đề, Minh Khai', '4', 'CANCELLED', 'VNPAY_1120_491', 'UNPAID', 'BANKING', '2025-11-20 21:39:17', '2025-11-20 21:39:17.000000'),
('698', '5', '3983654', 'Khu tập thể Thành Công', '2', 'COMPLETED', NULL, 'PAID', 'COD', '2025-11-21 08:32:46', '2025-11-21 08:32:46.000000'),
('699', '2', '1097472', 'Ngõ Gốc Đề, Minh Khai', '1', 'COMPLETED', NULL, 'PAID', 'COD', '2025-11-23 17:41:03', '2025-11-23 17:41:03.000000'),
('700', '4', '37919787', '102 Thái Thịnh, HN', '3', 'CANCELLED', 'VNPAY_1124_884', 'UNPAID', 'BANKING', '2025-11-24 13:12:46', '2025-11-24 13:12:46.000000'),
('701', '3', '25308270', '102 Thái Thịnh, HN', '3', 'COMPLETED', 'VNPAY_1125_428', 'PAID', 'BANKING', '2025-11-25 13:22:39', '2025-11-25 13:22:39.000000'),
('713', '1', '45011000', 'hanoi', '1', 'PENDING', 'COD_1764159284608', 'UNKNOWN', 'COD', '2025-11-26 19:14:44', '2025-11-26 19:14:44.583000'),
('714', '1', '45011000', 'hanoi', '1', 'PENDING', 'COD_1764299169464', 'UNKNOWN', 'COD', '2025-11-28 10:06:09', '2025-11-28 10:06:09.429000'),
('715', '1', '45011000', 'hanoi', '1', 'SUCCESS', 'VN_1764299195755', 'PAID', 'VNPAY', '2025-11-28 10:06:35', '2025-11-28 10:06:35.735000');

INSERT INTO `pro_configuration` (`id`, `color`, `ram`, `storage`, `variant_price`, `quantity`, `product_id`) VALUES
(1, 'Titanium Black', 8, 256, 34990000, 50, 1),
(2, 'Titanium White', 8, 512, 39990000, 30, 1),
(3, 'Titanium Natural', 8, 1024, 45990000, 15, 1),
(4, 'Platinum', 16, 512, 45000000, 20, 2),
(5, 'Graphite', 32, 1024, 52000000, 10, 2),
(6, 'Black', 32, 2048, 59000000, 5, 2),
(7, 'Phantom Black', 12, 256, 21990000, 40, 3),
(8, 'Storm White', 16, 512, 24990000, 25, 3),
(9, 'Cyber Grey', 18, 512, 28990000, 10, 3),
(10, 'Midnight', 1, 64, 10500000, 100, 4),
(11, 'Starlight', 1, 64, 10500000, 80, 4),
(12, 'Silver', 1, 64, 11500000, 60, 4),
(13, 'Nightfall Black', 16, 512, 38000000, 15, 5),
(14, 'Nocturne Blue', 16, 1024, 42000000, 10, 5),
(15, 'Natural Silver', 32, 2048, 48000000, 5, 5),
(16, 'Black Carbon', 16, 512, 42000000, 30, 6),
(17, 'Deep Black', 32, 1024, 48000000, 20, 6),
(18, 'Woven Carbon', 32, 2048, 55000000, 10, 6),
(19, 'Midnight', 8, 256, 27000000, 50, 7),
(20, 'Starlight', 16, 512, 35000000, 30, 7),
(21, 'Space Grey', 24, 512, 39000000, 20, 7),
(22, 'Phantom Black', 8, 128, 18000000, 60, 8),
(23, 'Cream', 8, 256, 20000000, 40, 8),
(24, 'Green', 8, 512, 23000000, 20, 8),
(25, 'Quiet Blue', 8, 256, 16000000, 100, 9),
(26, 'Icelight Silver', 8, 512, 17500000, 80, 9),
(27, 'Terra Cotta', 16, 512, 19000000, 40, 9),
(28, 'Carbon Black', 8, 256, 15500000, 80, 10),
(29, 'Platinum Silver', 16, 512, 18500000, 50, 10),
(30, 'Mist Blue', 16, 1024, 20500000, 20, 10),
(31, 'Midnight', 4, 128, 14000000, 70, 11),
(32, 'Starlight', 4, 256, 16000000, 50, 11),
(33, 'Pink', 4, 512, 20000000, 30, 11),
(34, 'Storm Grey', 8, 512, 29000000, 40, 12),
(35, 'Phantom Blue', 16, 512, 32000000, 30, 12),
(36, 'Stingray White', 16, 1024, 36000000, 15, 12),
(37, 'Silver', 1, 4, 5000000, 50, 13),
(38, 'Gunmetal', 1, 4, 5200000, 40, 13),
(39, 'Rose Gold', 1, 4, 5500000, 30, 13),
(40, 'Fog Blue', 8, 256, 17000000, 60, 14),
(41, 'Natural Silver', 8, 512, 18500000, 40, 14),
(42, 'Warm Gold', 16, 512, 21000000, 20, 14),
(43, 'Space Black', 8, 512, 45000000, 30, 15),
(44, 'Silver', 16, 1024, 55000000, 20, 15),
(45, 'Space Grey', 24, 1024, 65000000, 10, 15),
(46, 'Black', 4, 64, 9000000, 90, 16),
(47, 'White', 4, 128, 10500000, 60, 16),
(48, 'Purple', 4, 256, 12000000, 30, 16),
(49, 'Mecha Gray', 8, 512, 22000000, 50, 17),
(50, 'Jaeger Gray', 16, 512, 24500000, 40, 17),
(51, 'Fortress Gray', 16, 1024, 27000000, 20, 17),
(52, 'Graphite', 2, 16, 6500000, 70, 18),
(53, 'Silver', 2, 16, 6500000, 50, 18),
(54, 'Gold', 2, 16, 7000000, 30, 18),
(55, 'Titan Grey', 8, 256, 20000000, 40, 19),
(56, 'Modern Gray', 16, 512, 24000000, 30, 19),
(57, 'Aluminum', 32, 1024, 29000000, 10, 19),
(58, 'Pale Gold', 8, 256, 24000000, 45, 20),
(59, 'Natural Silver', 8, 512, 26000000, 30, 20),
(60, 'Wood Edition', 16, 1024, 31000000, 10, 20),
(61, '123', 123, 123, 1000, 123, 21);
INSERT INTO `wishlist` (`id`, `created_date`, `product_id`, `user_id`) VALUES
(1, '2025-11-26 15:54:05.572756', 5, 1),
(2, '2025-11-28 10:05:03.792021', 6, 1);
INSERT INTO `order_product` (`order_id`, `product_id`, `quantity`, `price`, `pro_configuration_id`) VALUES
(713, 2, 1, 45000000, NULL),
(714, 2, 1, 45000000, NULL),
(715, 2, 1, 45000000, NULL);
