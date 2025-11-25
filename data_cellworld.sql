DROP DATABASE IF EXISTS cellworld;
CREATE DATABASE cellworld;
USE cellworld;

CREATE TABLE roles(
	id				INT PRIMARY KEY AUTO_INCREMENT,
    `name`			NVARCHAR(20) NOT NULL DEFAULT "USER",
    `description`	NVARCHAR(200)
);

CREATE TABLE users(
	id 				INT AUTO_INCREMENT PRIMARY KEY,
    username 		VARCHAR(100) UNIQUE,
	email			VARCHAR(100) NOT NULL UNIQUE,
    `password`		VARCHAR(100),
    full_name		NVARCHAR(100)  NOT NULL,
    address			NVARCHAR(100),
    phone			CHAR(15) UNIQUE,
    avatar			VARCHAR(1000) ,
    role_id			INT NOT NULL,
    created_date	DATETIME DEFAULT NOW(),
    FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    image VARCHAR(255),
    detail_desc MEDIUMTEXT NOT NULL, -- @Column(columnDefinition = "MEDIUMTEXT")
    short_desc VARCHAR(255) NOT NULL,
    sold BIGINT NOT NULL DEFAULT 0,
    factory VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    pin INT,
    screen_type VARCHAR(255),
    screen_size DOUBLE,
    operating_system VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS pro_configuration (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    color VARCHAR(255),
    ram INT NOT NULL,
    storage INT NOT NULL,
    variant_price DOUBLE, -- @Column(name = "variant_price")
    quantity BIGINT,
    product_id BIGINT,
    CONSTRAINT fk_pro_config_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS carts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sum INT DEFAULT 0,
    user_id INT,
    CONSTRAINT fk_carts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS cart_detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    quantity BIGINT NOT NULL,
    price DOUBLE NOT NULL,
    cart_id BIGINT,
    pro_configuration_id BIGINT,
    CONSTRAINT fk_cart_detail_cart FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    CONSTRAINT fk_cart_detail_pro_config FOREIGN KEY (pro_configuration_id) REFERENCES pro_configuration(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
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