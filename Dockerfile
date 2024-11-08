# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set working directory in container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src/ ./src

# Compile and package the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim

# Set working directory in container
WORKDIR /app

# Copy the packaged .jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
