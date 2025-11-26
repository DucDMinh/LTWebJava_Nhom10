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
CREATE TABLE  wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    created_date DATETIME DEFAULT NOW(),
    UNIQUE KEY unique_user_product (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);



INSERT INTO roles (`name`, `description`) VALUES
('USER', 'Người dùng bình thường'),
('ADMIN', 'Quản trị hệ thống'),
('STAFF', 'Nhân viên');

-- User bình thường
INSERT INTO users (username, email, `password`, full_name, role_id) VALUES
('user', 'user@gmail.com', '$2a$10$yWabUhcc84uStXPyJa.4j.4vq.uH53IwL5ybQc2VJNhuHx9tk9faG', 'User Example', 1);

-- Admin
INSERT INTO users (username, email, `password`, full_name, role_id) VALUES
('admin', 'admin@gmail.com', '$2a$10$yWabUhcc84uStXPyJa.4j.4vq.uH53IwL5ybQc2VJNhuHx9tk9faG', 'Admin Example', 2);

-- Staff
INSERT INTO users (username, email, `password`, full_name, role_id) VALUES
('staff', 'staff@gmail.com', '$2a$10$yWabUhcc84uStXPyJa.4j.4vq.uH53IwL5ybQc2VJNhuHx9tk9faG', 'Staff Example', 3);

