FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY target/*.jar spring-boot-jwt.jar

EXPOSE 8111

ENTRYPOINT ["java", "-jar", "app.jar"]