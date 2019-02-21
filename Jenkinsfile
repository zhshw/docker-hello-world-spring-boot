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
       docker { image 'node:7-alpine' }

    }
    stages { 
        stage('Back-end') {
            steps {
                sh 'mvn --version'
            }
        }
        stage('Front-end') {
            steps {
                sh 'node --version'
            }
        }
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
	   
       stage('Building image') {
          steps{
	  sh "mv ./target/hello*.jar ./data" 
	  script {
	      dockerImage = docker.build registry + ":$BUILD_NUMBER"
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
