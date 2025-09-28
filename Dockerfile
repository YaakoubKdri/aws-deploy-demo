#stage 1: build the application
From maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

#stage 2: run the application
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar ./demo-aws.jar
EXPOSE 8080
CMD ["java", "-jar", "demo-aws.jar"]