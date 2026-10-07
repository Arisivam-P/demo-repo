FROM eclipse-temurin:21-jre

WORKDIR /app

COPY target/demo-app-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
