DROP DATABASE IF EXISTS cellworld;
CREATE DATABASE cellworld CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cellworld;

-- ==========================
-- 1. ROLE
-- ==========================
CREATE TABLE roles(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    `name`          VARCHAR(20) NOT NULL DEFAULT 'USER',
    `description`   VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 2. USERS
-- ==========================
CREATE TABLE users(
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(100) UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    `password`      VARCHAR(255) NOT NULL,
    full_name       VARCHAR(100) NOT NULL,
    address         VARCHAR(255),
    phone           VARCHAR(15) UNIQUE,
    avatar          VARCHAR(1000),
    role_id         INT NOT NULL,
    created_date    DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_role FOREIGN KEY(role_id) 
        REFERENCES roles(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 3. PRODUCTS
-- ==========================
CREATE TABLE products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    image VARCHAR(255),
    detail_desc MEDIUMTEXT NOT NULL,
    short_desc VARCHAR(255) NOT NULL,
    sold BIGINT NOT NULL DEFAULT 0,
    factory VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    pin INT,
    screen_type VARCHAR(255),
    screen_size DOUBLE,
    operating_system VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 4. PRODUCT CONFIGURATION
-- ==========================
CREATE TABLE pro_configuration (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    color VARCHAR(255),
    ram INT NOT NULL,
    storage INT NOT NULL,
    variant_price DOUBLE,
    quantity BIGINT,
    product_id BIGINT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 5. CARTS
-- ==========================
CREATE TABLE carts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sum DOUBLE DEFAULT 0,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 6. CART DETAIL
-- ==========================
CREATE TABLE cart_detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    quantity BIGINT NOT NULL,
    price DOUBLE NOT NULL,
    cart_id BIGINT NOT NULL,
    pro_configuration_id BIGINT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (pro_configuration_id) REFERENCES pro_configuration(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 7. ORDERS
-- ==========================
CREATE TABLE orders(
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT DEFAULT NULL,
    total_price     DOUBLE,
    address         VARCHAR(500),
    total_product   INT,
    `status`        VARCHAR(50),
    payment_ref     VARCHAR(50),
    payment_status  VARCHAR(50),
    payment_method  VARCHAR(50),
    created_date    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ==========================
-- 8. ORDER_PRODUCT (Order Items)
-- ==========================
CREATE TABLE order_product(
    order_id        BIGINT,
    product_id      BIGINT,
    quantity        INT NOT NULL,
    price           DOUBLE NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_date DATETIME DEFAULT NOW(),
    UNIQUE KEY unique_user_product (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

USE cellworld;
-- fake data dashboard
INSERT INTO orders 
(address, created_date, order_date, payment_method, payment_ref, payment_status, status, total_price, total_product, user_id) 
VALUES 
-- THÁNG 6/2025
('Số 12 Chùa Bộc, Đống Đa, HN', '2025-06-02 08:30:00', '2025-06-02 08:30:00', 'COD', NULL, 'PAID', 'COMPLETED', 12500000, 1, 1),
('P.405, KTX Bách Khoa, HN', '2025-06-05 14:20:00', '2025-06-05 14:20:00', 'BANKING', 'VNPAY_0601', 'PAID', 'COMPLETED', 450000, 2, 1),
('88 Láng Hạ, HN', '2025-06-12 09:15:00', '2025-06-12 09:15:00', 'COD', NULL, 'UNPAID', 'CANCELLED', 32000000, 1, 1),
('Ngõ 20 Hồ Tùng Mậu, HN', '2025-06-18 19:45:00', '2025-06-18 19:45:00', 'BANKING', 'VNPAY_0602', 'PAID', 'COMPLETED', 2890000, 1, 1),
('Tòa nhà Keangnam, HN', '2025-06-25 11:00:00', '2025-06-25 11:00:00', 'COD', NULL, 'PAID', 'COMPLETED', 15600000, 1, 1),
('Số 5 Trần Phú, Hà Đông', '2025-06-29 16:30:00', '2025-06-29 16:30:00', 'BANKING', 'VNPAY_0603', 'PAID', 'COMPLETED', 5500000, 3, 1),

-- THÁNG 7/2025
('102 Thái Thịnh, HN', '2025-07-03 10:10:00', '2025-07-03 10:10:00', 'COD', NULL, 'PAID', 'COMPLETED', 8900000, 1, 1),
('Khu đô thị Ecopark', '2025-07-08 13:40:00', '2025-07-08 13:40:00', 'BANKING', 'VNPAY_0701', 'PAID', 'COMPLETED', 42000000, 2, 1),
('Ngõ 175 Xuân Thủy', '2025-07-14 08:50:00', '2025-07-14 08:50:00', 'COD', NULL, 'PAID', 'COMPLETED', 1200000, 1, 1),
('Số 9 Lê Thanh Nghị', '2025-07-19 20:15:00', '2025-07-19 20:15:00', 'BANKING', 'VNPAY_0702', 'PAID', 'COMPLETED', 33500000, 1, 1),
('Vinhomes Ocean Park', '2025-07-22 15:00:00', '2025-07-22 15:00:00', 'COD', NULL, 'UNPAID', 'CANCELLED', 1500000, 1, 1),
('Ngõ Gốc Đề, Minh Khai', '2025-07-27 09:30:00', '2025-07-27 09:30:00', 'BANKING', 'VNPAY_0703', 'PAID', 'COMPLETED', 18900000, 2, 1),
('Số 45 Nguyễn Chí Thanh', '2025-07-30 18:20:00', '2025-07-30 18:20:00', 'COD', NULL, 'PAID', 'COMPLETED', 6700000, 1, 1),

-- THÁNG 8/2025
('Tòa IPH Xuân Thủy', '2025-08-02 11:15:00', '2025-08-02 11:15:00', 'BANKING', 'VNPAY_0801', 'PAID', 'COMPLETED', 24500000, 1, 1),
('Ngõ 68 Cầu Giấy', '2025-08-06 14:45:00', '2025-08-06 14:45:00', 'COD', NULL, 'PAID', 'COMPLETED', 3200000, 1, 1),
('Số 10 Trần Duy Hưng', '2025-08-11 08:40:00', '2025-08-11 08:40:00', 'BANKING', 'VNPAY_0802', 'PAID', 'COMPLETED', 56000000, 3, 1),
('Khu tập thể Thành Công', '2025-08-15 17:10:00', '2025-08-15 17:10:00', 'COD', NULL, 'PAID', 'COMPLETED', 990000, 2, 1),
('Ngõ 105 Láng Hạ', '2025-08-20 12:30:00', '2025-08-20 12:30:00', 'BANKING', 'VNPAY_0803', 'PAID', 'COMPLETED', 14200000, 1, 1),
('Số 33 Tràng Thi', '2025-08-24 09:00:00', '2025-08-24 09:00:00', 'COD', NULL, 'UNPAID', 'CANCELLED', 28000000, 1, 1),
('Gamuda Gardens, Hoàng Mai', '2025-08-28 19:50:00', '2025-08-28 19:50:00', 'BANKING', 'VNPAY_0804', 'PAID', 'COMPLETED', 7800000, 1, 1),
('Số 2 Bà Triệu', '2025-08-31 10:20:00', '2025-08-31 10:20:00', 'COD', NULL, 'PAID', 'COMPLETED', 2100000, 1, 1),

-- THÁNG 9/2025
('Ngõ 1 Ao Sen', '2025-09-03 13:15:00', '2025-09-03 13:15:00', 'BANKING', 'VNPAY_0901', 'PAID', 'COMPLETED', 4500000, 1, 1),
('Chung cư Linh Đàm', '2025-09-07 08:10:00', '2025-09-07 08:10:00', 'COD', NULL, 'PAID', 'COMPLETED', 31500000, 2, 1),
('Số 88 Phố Huế', '2025-09-12 16:40:00', '2025-09-12 16:40:00', 'BANKING', 'VNPAY_0902', 'PAID', 'COMPLETED', 12500000, 1, 1),
('Ngõ 250 Kim Giang', '2025-09-16 11:30:00', '2025-09-16 11:30:00', 'COD', NULL, 'PAID', 'COMPLETED', 800000, 4, 1),
('Tòa nhà Lotte Đào Tấn', '2025-09-21 14:55:00', '2025-09-21 14:55:00', 'BANKING', 'VNPAY_0903', 'PAID', 'COMPLETED', 62000000, 2, 1),
('Số 55 Giải Phóng', '2025-09-25 09:25:00', '2025-09-25 09:25:00', 'COD', NULL, 'PAID', 'COMPLETED', 15500000, 1, 1),
('Khu Ngoại Giao Đoàn', '2025-09-29 19:00:00', '2025-09-29 19:00:00', 'BANKING', 'VNPAY_0904', 'PAID', 'COMPLETED', 4100000, 1, 1),

-- THÁNG 10/2025
('Royal City R2', '2025-10-02 10:05:00', '2025-10-02 10:05:00', 'COD', NULL, 'PAID', 'COMPLETED', 23000000, 1, 1),
('Số 99 Nguyễn Tuân', '2025-10-05 15:35:00', '2025-10-05 15:35:00', 'BANKING', 'VNPAY_1001', 'PAID', 'COMPLETED', 8800000, 1, 1),
('Ngõ 100 Hoàng Quốc Việt', '2025-10-09 08:45:00', '2025-10-09 08:45:00', 'COD', NULL, 'UNPAID', 'CANCELLED', 35000000, 2, 1),
('Goldmark City, Hồ Tùng Mậu', '2025-10-13 12:15:00', '2025-10-13 12:15:00', 'BANKING', 'VNPAY_1002', 'PAID', 'COMPLETED', 19500000, 1, 1),
('Số 20 Hàng Bài', '2025-10-17 18:30:00', '2025-10-17 18:30:00', 'COD', NULL, 'PAID', 'COMPLETED', 5600000, 1, 1),
('Times City T3', '2025-10-21 09:50:00', '2025-10-21 09:50:00', 'BANKING', 'VNPAY_1003', 'PAID', 'COMPLETED', 48900000, 3, 1),
('Số 5 Lý Thường Kiệt', '2025-10-25 14:10:00', '2025-10-25 14:10:00', 'COD', NULL, 'PAID', 'COMPLETED', 2700000, 1, 1),
('Aeon Mall Hà Đông', '2025-10-28 20:40:00', '2025-10-28 20:40:00', 'BANKING', 'VNPAY_1004', 'PAID', 'COMPLETED', 36500000, 1, 1),
('Số 15 Xã Đàn', '2025-10-31 11:20:00', '2025-10-31 11:20:00', 'COD', NULL, 'PAID', 'COMPLETED', 9200000, 1, 1),

-- THÁNG 11/2025
('Trần Duy Hưng, Cầu Giấy', '2025-11-02 09:00:00', '2025-11-02 09:00:00', 'BANKING', 'VNPAY_1101', 'PAID', 'COMPLETED', 18000000, 1, 1),
('Nguyễn Trãi, Thanh Xuân', '2025-11-05 13:00:00', '2025-11-05 13:00:00', 'COD', NULL, 'UNPAID', 'SHIPPING', 7500000, 1, 1),
('Tố Hữu, Hà Đông', '2025-11-08 16:30:00', '2025-11-08 16:30:00', 'BANKING', 'VNPAY_1102', 'PAID', 'COMPLETED', 31000000, 2, 1),
('Lê Văn Lương, Thanh Xuân', '2025-11-11 10:15:00', '2025-11-11 10:15:00', 'COD', NULL, 'PAID', 'COMPLETED', 1450000, 1, 1),
('Phạm Hùng, Nam Từ Liêm', '2025-11-14 19:45:00', '2025-11-14 19:45:00', 'BANKING', 'VNPAY_1103', 'PAID', 'COMPLETED', 55000000, 1, 1),
('Cầu Giấy, Hà Nội', '2025-11-17 08:20:00', '2025-11-17 08:20:00', 'COD', NULL, 'UNPAID', 'PENDING', 22000000, 1, 1),
('Xuân Thủy, Cầu Giấy', '2025-11-19 12:40:00', '2025-11-19 12:40:00', 'BANKING', 'VNPAY_1104', 'PAID', 'COMPLETED', 8900000, 1, 1),
('Hoàng Quốc Việt, Cầu Giấy', '2025-11-22 15:10:00', '2025-11-22 15:10:00', 'COD', NULL, 'PAID', 'COMPLETED', 3300000, 1, 1),
('Nguyễn Xiển, Thanh Xuân', '2025-11-24 09:05:00', '2025-11-24 09:05:00', 'BANKING', 'VNPAY_1105', 'PAID', 'COMPLETED', 42500000, 1, 1),
('Võ Chí Công, Tây Hồ', '2025-11-25 21:00:00', '2025-11-25 21:00:00', 'COD', NULL, 'UNPAID', 'PENDING', 12000000, 1, 1);
