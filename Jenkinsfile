pipeline {
    environment {
        registry = "inf/"
        registryCredential = '192.168.122.75'
        dockerImageName = "hello-world-java"
    }
    agent { 
	    dockerfile true 
    }
    stages { 
       
        stage('Front-end') {
            agent {
                docker { image 'node:7-alpine' }
            }
            steps {
                sh 'node --version'
            }
        }
	    
   	stage('Build') {
	    agent {
                docker { image 'maven:3-alpine' }
            }
            steps {
	        sh 'mvn --version'
                sh 'mvn -B -DskipTests clean package'
            }
        }
	   
       stage('Building image') {
          steps{
	  sh "mv ./target/hello*.jar ./data" 
	  script {
	    def dockerfile = 'Dockerfile'
   	    def customImage = docker.build("${dockerImageName}:${env.BUILD_ID}", "-f ${dockerfile} ./") 
	   }
         }
       }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }

}
