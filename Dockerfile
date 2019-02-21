#pull base image
FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER xxxx@xxx.com

EXPOSE 8081


#COPY files/index.html.template /usr/share/nginx/html/index.html.template
ADD target/*.jar  /home/work/app.jar
#VOLUME /tmp

WORKDIR /home/work
ENTRYPOINT ["java","-jar"," /home/work/app.jar"]

