#pull base image
FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER xxxx@xxx.com

EXPOSE 8180

#COPY files/index.html.template /usr/share/nginx/html/index.html.template
VOLUME /tmp

#ENTRYPOINT ["java","-jar","/opt/app.jar"]

CMD java -jar /opt/hello-world-0.1.0.jar

#copy hello world to docker image
ADD ./hello-world-0.1.0.jar /opt/hello-world-0.1.0.jar
ADD ./a.txt  /opt/a.txt
