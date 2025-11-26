INSERT INTO products (id, name, category, factory, operating_system, image, price, detail_desc, short_desc, pin, screen_size, screen_type, sold, view) VALUES
(1, 'iPhone 15 Pro Max', 'Điện Thoại', 'Apple', 'iOS', '1.png', 34990000, 'Mô tả chi tiết sản phẩm iPhone 15...', 'Flagship mới nhất từ Apple', 4422, 6.7, 'OLED', 0, 150),
(2, 'Dell XPS 13 Plus', 'Máy Tính', 'Dell', 'Windows', '2.png', 45000000, 'Mô tả chi tiết laptop Dell XPS...', 'Laptop doanh nhân cao cấp', 5000, 13.4, 'IPS', 0, 230),
(3, 'Asus ROG Phone 7', 'Điện Thoại', 'Asus', 'Android', '3.png', 21990000, 'Mô tả chi tiết Asus ROG...', 'Điện thoại gaming đỉnh cao', 6000, 6.78, 'AMOLED', 0, 120),
(4, 'Apple Watch Series 9', 'Đồng Hồ', 'Apple', 'iOS', '4.png', 10500000, 'Mô tả chi tiết Apple Watch...', 'Đồng hồ thông minh thế hệ mới', 308, 1.9, 'Retina', 0, 500),
(5, 'HP Spectre x360', 'Máy Tính', 'HP', 'Windows', '5.png', 38000000, 'Mô tả chi tiết HP Spectre...', 'Laptop xoay gập sang trọng', 4800, 14.0, 'OLED', 0, 89),
(6, 'Lenovo ThinkPad X1', 'Máy Tính', 'Lenovo', 'Windows', '6.png', 42000000, 'Mô tả chi tiết ThinkPad...', 'Bền bỉ, hiệu năng mạnh mẽ', 5200, 14.0, 'IPS', 0, 310),
(7, 'Macbook Air M2', 'Máy Tính', 'Apple', 'iOS', '7.png', 27000000, 'Mô tả chi tiết Macbook Air...', 'Mỏng nhẹ, pin trâu', 5000, 13.6, 'Liquid Retina', 0, 600),
(8, 'Samsung Galaxy S23', 'Điện Thoại', 'Android', 'Android', '8.png', 18000000, 'Mô tả chi tiết Galaxy S23...', 'Điện thoại Android tốt nhất', 3900, 6.1, 'Dynamic AMOLED', 0, 450),
(9, 'Asus Vivobook 15', 'Máy Tính', 'Asus', 'Windows', '9.png', 16000000, 'Mô tả chi tiết Vivobook...', 'Laptop văn phòng giá rẻ', 4200, 15.6, 'IPS', 0, 100),
(10, 'Dell Inspiron 15', 'Máy Tính', 'Dell', 'Windows', '10.png', 15500000, 'Mô tả chi tiết Inspiron...', 'Laptop sinh viên bền bỉ', 4100, 15.6, 'LCD', 0, 200),
(11, 'iPhone 13', 'Điện Thoại', 'Apple', 'iOS', '11.png', 14000000, 'Mô tả chi tiết iPhone 13...', 'Giá tốt, hiệu năng cao', 3240, 6.1, 'OLED', 0, 800),
(12, 'Lenovo Legion 5', 'Máy Tính', 'Lenovo', 'Windows', '12.png', 29000000, 'Mô tả chi tiết Legion 5...', 'Laptop gaming quốc dân', 5500, 15.6, 'IPS 165Hz', 0, 340),
(13, 'Asus ZenWatch', 'Đồng Hồ', 'Asus', 'Android', '13.png', 5000000, 'Mô tả chi tiết ZenWatch...', 'Đồng hồ thời trang', 300, 1.4, 'AMOLED', 0, 50),
(14, 'HP Pavilion 15', 'Máy Tính', 'HP', 'Windows', '14.png', 17000000, 'Mô tả chi tiết HP Pavilion...', 'Thiết kế đẹp, mỏng nhẹ', 4000, 15.6, 'IPS', 0, 150),
(15, 'Macbook Pro M3', 'Máy Tính', 'Apple', 'iOS', '15.png', 45000000, 'Mô tả chi tiết Macbook Pro...', 'Dành cho dân đồ họa', 6000, 14.2, 'XDR', 0, 400),
(16, 'iPhone 11', 'Điện Thoại', 'Apple', 'iOS', '16.png', 9000000, 'Mô tả chi tiết iPhone 11...', 'Huyền thoại giá rẻ', 3110, 6.1, 'LCD', 0, 999),
(17, 'Asus TUF Gaming', 'Máy Tính', 'Asus', 'Windows', '17.png', 22000000, 'Mô tả chi tiết Asus TUF...', 'Chuẩn quân đội, giá tốt', 4800, 15.6, 'IPS 144Hz', 0, 220),
(18, 'Galaxy Watch 6', 'Đồng Hồ', 'Android', 'Android', '18.png', 6500000, 'Mô tả chi tiết Galaxy Watch...', 'Theo dõi sức khỏe toàn diện', 425, 1.5, 'Super AMOLED', 0, 130),
(19, 'Dell Latitude', 'Máy Tính', 'Dell', 'Windows', '19.png', 20000000, 'Mô tả chi tiết Latitude...', 'Bảo mật cao cho doanh nghiệp', 4500, 14.0, 'IPS', 0, 70),
(20, 'HP Envy 13', 'Máy Tính', 'HP', 'Windows', '20.png', 24000000, 'Mô tả chi tiết HP Envy...', 'Nhỏ gọn, màn hình đẹp', 4300, 13.3, 'OLED', 0, 180);

INSERT INTO pro_configuration (id, product_id, color, ram, storage, quantity, variant_price) VALUES
-- 1. iPhone 15 Pro Max
(1, 1, 'Titanium Black', 8, 256, 50, 34990000),
(2, 1, 'Titanium White', 8, 512, 30, 39990000),
(3, 1, 'Titanium Natural', 8, 1024, 15, 45990000),

-- 2. Dell XPS 13 Plus
(4, 2, 'Platinum', 16, 512, 20, 45000000),
(5, 2, 'Graphite', 32, 1024, 10, 52000000),
(6, 2, 'Black', 32, 2048, 5, 59000000),

-- 3. Asus ROG Phone 7
(7, 3, 'Phantom Black', 12, 256, 40, 21990000),
(8, 3, 'Storm White', 16, 512, 25, 24990000),
(9, 3, 'Cyber Grey', 18, 512, 10, 28990000),

-- 4. Apple Watch Series 9 (Watch specs: RAM 1GB, Storage 64GB, vary colors)
(10, 4, 'Midnight', 1, 64, 100, 10500000),
(11, 4, 'Starlight', 1, 64, 80, 10500000),
(12, 4, 'Silver', 1, 64, 60, 11500000),

-- 5. HP Spectre x360
(13, 5, 'Nightfall Black', 16, 512, 15, 38000000),
(14, 5, 'Nocturne Blue', 16, 1024, 10, 42000000),
(15, 5, 'Natural Silver', 32, 2048, 5, 48000000),

-- 6. Lenovo ThinkPad X1
(16, 6, 'Black Carbon', 16, 512, 30, 42000000),
(17, 6, 'Deep Black', 32, 1024, 20, 48000000),
(18, 6, 'Woven Carbon', 32, 2048, 10, 55000000),

-- 7. Macbook Air M2
(19, 7, 'Midnight', 8, 256, 50, 27000000),
(20, 7, 'Starlight', 16, 512, 30, 35000000),
(21, 7, 'Space Grey', 24, 512, 20, 39000000),

-- 8. Samsung Galaxy S23
(22, 8, 'Phantom Black', 8, 128, 60, 18000000),
(23, 8, 'Cream', 8, 256, 40, 20000000),
(24, 8, 'Green', 8, 512, 20, 23000000),

-- 9. Asus Vivobook 15
(25, 9, 'Quiet Blue', 8, 256, 100, 16000000),
(26, 9, 'Icelight Silver', 8, 512, 80, 17500000),
(27, 9, 'Terra Cotta', 16, 512, 40, 19000000),

-- 10. Dell Inspiron 15
(28, 10, 'Carbon Black', 8, 256, 80, 15500000),
(29, 10, 'Platinum Silver', 16, 512, 50, 18500000),
(30, 10, 'Mist Blue', 16, 1024, 20, 20500000),

-- 11. iPhone 13
(31, 11, 'Midnight', 4, 128, 70, 14000000),
(32, 11, 'Starlight', 4, 256, 50, 16000000),
(33, 11, 'Pink', 4, 512, 30, 20000000),

-- 12. Lenovo Legion 5
(34, 12, 'Storm Grey', 8, 512, 40, 29000000),
(35, 12, 'Phantom Blue', 16, 512, 30, 32000000),
(36, 12, 'Stingray White', 16, 1024, 15, 36000000),

-- 13. Asus ZenWatch
(37, 13, 'Silver', 1, 4, 50, 5000000),
(38, 13, 'Gunmetal', 1, 4, 40, 5200000),
(39, 13, 'Rose Gold', 1, 4, 30, 5500000),

-- 14. HP Pavilion 15
(40, 14, 'Fog Blue', 8, 256, 60, 17000000),
(41, 14, 'Natural Silver', 8, 512, 40, 18500000),
(42, 14, 'Warm Gold', 16, 512, 20, 21000000),

-- 15. Macbook Pro M3
(43, 15, 'Space Black', 8, 512, 30, 45000000),
(44, 15, 'Silver', 16, 1024, 20, 55000000),
(45, 15, 'Space Grey', 24, 1024, 10, 65000000),

-- 16. iPhone 11
(46, 16, 'Black', 4, 64, 90, 9000000),
(47, 16, 'White', 4, 128, 60, 10500000),
(48, 16, 'Purple', 4, 256, 30, 12000000),

-- 17. Asus TUF Gaming
(49, 17, 'Mecha Gray', 8, 512, 50, 22000000),
(50, 17, 'Jaeger Gray', 16, 512, 40, 24500000),
(51, 17, 'Fortress Gray', 16, 1024, 20, 27000000),

-- 18. Galaxy Watch 6
(52, 18, 'Graphite', 2, 16, 70, 6500000),
(53, 18, 'Silver', 2, 16, 50, 6500000),
(54, 18, 'Gold', 2, 16, 30, 7000000),

-- 19. Dell Latitude
(55, 19, 'Titan Grey', 8, 256, 40, 20000000),
(56, 19, 'Modern Gray', 16, 512, 30, 24000000),
(57, 19, 'Aluminum', 32, 1024, 10, 29000000),

-- 20. HP Envy 13
(58, 20, 'Pale Gold', 8, 256, 45, 24000000),
(59, 20, 'Natural Silver', 8, 512, 30, 26000000),
(60, 20, 'Wood Edition', 16, 1024, 10, 31000000);
