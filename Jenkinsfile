pipeline {
    environment {
        registry = "inf/"
        registryCredential = '192.168.122.75'
        dockerImageName = "hello-world-java"
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
