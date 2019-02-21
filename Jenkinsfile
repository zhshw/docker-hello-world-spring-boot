pipeline {
    environment {
        registry = "inf/"
        imageName = "hello-world-java"
    }
    agent any
    stages {
        stage('Back-end') {
            agent {
                docker { image 'maven:3-alpine' 
		        args '-v /root/.m2:/root/.m2 -v '
		}
            }
            steps {
                sh 'mvn --version'
		sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Front-end') {
            agent {
                docker { image 'node:7-alpine' }
            }
            steps {
                sh 'node --version'
            }
        }
   
  
       stage('Building image') {
          steps{

	  script {
	    def dockerfile = 'Dockerfile'
   	    def customImage = docker.build("${dockerImageName}:${env.BUILD_ID}", "-f ${dockerfile} ./") 
	   }
         }
       }

  }
  post {
    always {
      archive 'target/**/*.jar'
      junit 'target/**/*.xml'
      cucumber '**/*.json'
    }
    success {
      withCredentials([usernamePassword(credentialsId: 'Harbor', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh "docker login -u ${USERNAME} -p ${PASSWORD}"
        sh "docker push ${registry}/${imageName}:${env.BUILD_ID}"
        sh "docker push ${registry}/${imageName}:latest"
      }
    }
  }
}


