pipeline {

    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
  
    
    def dockerRepoUrl = "192.168.122.75"
    def dockerImageName = "hello-world-java"
    def dockerImageTag = "${dockerRepoUrl}/${dockerImageName}:${env.BUILD_NUMBER}"
    
    stages {
   	stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }

	}
	
       stage('Build Docker Image') {
	    steps {
	       sh "mv ./target/hello*.jar ./data" 
	       dockerImage = docker.build("hello-world-java")
	    }
	}
	   
	stage('Deploy Docker Image') {
	    steps {
	      echo "Docker Image Tag Name: ${dockerImageTag}"
	      sh "docker login -u admin -p Harbor12345 ${dockerRepoUrl}"
	      sh "docker tag ${dockerImageName} ${dockerImageTag}"
	      sh "docker push ${dockerImageTag}"
	    }
       }
   }
}
