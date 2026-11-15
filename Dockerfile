FROM eclipse-temurin:21-jre
WORKDIR /app
COPY target/kafka-consumer-1.0.jar app.jar
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=65.0"
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
