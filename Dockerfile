FROM eclipse-temurin:11-jdk-alpine
WORKDIR /app
COPY target/demo-app-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
