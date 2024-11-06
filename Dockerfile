# Stage 1: Build the application using Maven
FROM maven:3.8.1-jdk-11 AS build

WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the application using Maven
RUN mvn clean package

# Stage 2: Run the application using OpenJDK
FROM openjdk:11-jre-slim

WORKDIR /app

# Copy the JAR file from the build stage to this stage
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /app/my-app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]
