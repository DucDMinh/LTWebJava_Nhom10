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
    `password`		VARCHAR(50),
    full_name		NVARCHAR(100)  NOT NULL,
    address			NVARCHAR(100),
    phone			CHAR(15) UNIQUE,
    avatar			VARCHAR(1000) ,
    role_id			INT NOT NULL,
    created_date	DATETIME DEFAULT NOW(),
    FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
);
