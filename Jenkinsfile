pipeline {
    environment {
        registry = "192.168.122.75/inf"
        imageName = "hello-world-java"
    }
    agent any
    stages {
        stage('Back-end') {
            agent {
                docker { image 'maven:3-alpine' 
		        args '-v /root/.m2:/root/.m2'
		}
            }
            steps {
                sh 'mvn --version'
		sh 'mvn -B -DskipTests clean package'
		sh 'mv target/*.jar data/'
            }
        }
     
  
       stage('Building image') {
          steps{

	  script {
	    def dockerfile = 'Dockerfile'
   	    sh "docker build -t ${registry}/${imageName}:${env.BUILD_ID} -f ./Dockerfile" 
	    sh "docker tag ${registry}/${imageName}:${env.BUILD_ID}  ${registry}/${imageName}:latest"
	   }
         }
       }
	   
       stage('Deploy Docker Image') {
	    steps {
	      script {
	    	withCredentials([usernamePassword(credentialsId: 'Harbor', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
		  sh "docker login -u ${USERNAME} -p ${PASSWORD} 192.168.122.75"
		  sh "docker push ${registry}/${imageName}:${env.BUILD_ID}"
		  sh "docker push ${registry}/${imageName}:latest"
	        }
	      }
	    }
	}
     }
}
