#pull base image
FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER xxxx@xxx.com

EXPOSE 8081


#COPY files/index.html.template /usr/share/nginx/html/index.html.template
ADD ./target/*.jar  /app.jar
#VOLUME /tmp

ENTRYPOINT ["java","-jar","/app.jar"]

