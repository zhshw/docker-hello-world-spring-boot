#pull base image
FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER dstar55@yahoo.com

#expose port 8080
EXPOSE 8080


WORKDIR /home/work

#default command
CMD java -jar /home/work/hello-world-0.1.0.jar

#copy hello world to docker image
#ADD ./data/hello-world-0.1.0.jar /home/work/hello-world-0.1.0.jar
