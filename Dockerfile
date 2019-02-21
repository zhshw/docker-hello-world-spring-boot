#pull base image
FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER xxxx@xxx.com

EXPOSE 8080

COPY target/*.jar /opt/app.jar

#COPY files/index.html.template /usr/share/nginx/html/index.html.template
#VOLUME /tmp

ENTRYPOINT ["java","-jar","/opt/app.jar"]

