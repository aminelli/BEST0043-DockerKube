# Stage 1 - Compilazione
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY ./demo/pom.xml ./pom.xml

COPY ./demo/src ./src

RUN mvn clean package -DskipTests
 
# Stage 2 - Runtime

FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

COPY --from=build /app/target/*.jar ./app.jar

EXPOSE 8080

ENV JAVA_OPT="-Xmx512m -Xms256m"

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPT -jar app.jar" ]
