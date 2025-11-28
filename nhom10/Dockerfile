# --- Giai đoạn 1: Build (Dùng Maven để đóng gói file JAR) ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Lệnh build bỏ qua test cho nhanh
RUN mvn clean package -DskipTests

# --- Giai đoạn 2: Run (Dùng Java để chạy file JAR) ---
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
# Copy file JAR từ giai đoạn build sang giai đoạn run
# Lưu ý: Dòng này sẽ tự tìm file .jar trong thư mục target
COPY --from=build /app/target/*.jar app.jar

# Mở cổng 8080
EXPOSE 8080

# Lệnh chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]