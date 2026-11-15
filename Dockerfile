FROM eclipse-temurin:21-jre
WORKDIR /app
COPY target/kafka-consumer-1.0.jar app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
