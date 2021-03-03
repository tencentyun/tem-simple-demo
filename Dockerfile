FROM openjdk:8-jdk-alpine

ARG NAME
ARG JAR_FILE=${NAME}/target/*.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
