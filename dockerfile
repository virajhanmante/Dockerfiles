//Document service Dockerfile
FROM maven:3.6.3-jdk-8 AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean package

FROM openjdk:14-jdk-alpine
MAINTAINER viraj
COPY --from=build /usr/src/app/target/*jar /usr/src/app/document.jar
EXPOSE 8080
CMD ["java", "-jar", "/usr/src/app/document.jar"]

//Register service Dockerfile

FROM maven:3.6.3-jdk-8 AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean package

FROM openjdk:14-jdk-alpine
MAINTAINER viraj
COPY --from=build /usr/src/app/target/*jar /usr/src/app/register.jar
EXPOSE 8080
CMD ["java", "-jar", "/usr/src/app/register.jar"]

//Master service Dockerfile

FROM maven:3.6.3-jdk-8 AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean package

FROM openjdk:14-jdk-alpine
MAINTAINER viraj
COPY --from=build /usr/src/app/target/*jar /usr/src/app/register.jar
EXPOSE 8080
CMD ["java", "-jar", "/usr/src/app/master.jar"]
