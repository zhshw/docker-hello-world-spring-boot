pipeline {
    environment {
        registry = "inf"
        registryCredential = '192.168.122.75'
        dockerImageName = "hello-world-java"
        dockerImage =  "${registryCredential}/${registry}/${dockerImageName}:${env.BUILD_NUMBER}"
    }
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    
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
	       script {
	           dockerImage = docker.build("hello-world-java")
	       }
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
