# Stage 1: Build Stage
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /usr/local/app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

# Stage 2: Run Stage
FROM openjdk:latest
WORKDIR /opt/
# Copy the WAR file from the build stage to Tomcat's webapps directory
COPY --from=build /usr/local/app/target/discovery-server-0.0.1-SNAPSHOT.jar .


# Start Tomcat
CMD ["java","-jar","/opt/discovery-server-0.0.1-SNAPSHOT.jar"]
