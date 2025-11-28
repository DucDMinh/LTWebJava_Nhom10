# --- Giai đoạn 1: Build ---
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Build ra file WAR
RUN mvn clean package -DskipTests

# --- Giai đoạn 2: Run ---
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# --- SỬA Ở ĐÂY ---
# 1. Đổi *.jar thành *.war (vì pom.xml là war)
# 2. Đổi tên file đích thành app.war cho đúng bản chất
COPY --from=build /app/target/*.war app.war

EXPOSE 8080

# --- SỬA Ở ĐÂY ---
# Chạy file war bằng java -jar vẫn hoạt động bình thường với Spring Boot
ENTRYPOINT ["java", "-jar", "app.war"]
