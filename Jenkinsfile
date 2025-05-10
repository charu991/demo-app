pipeline{
    agent any
  tools{
    nodejs 'node18'
    jdk 'jdk17'
  }
  stages{
    stage("Clean Workspace"){
        steps{
            cleanWs()
        }
    }
    stage("Git checkout"){
      steps{
        git branch:'main', url:'https://github.com/charu991/demo-app'
      }
    }
    stage("DOCKER BUILD & PUSH"){
        steps{
            script{
                withDockerRegistry(credentialsId: 'docker-hub', toolName: 'docker'){
                    sh 'docker build -t demo-app .'
                    sh 'docker tag demo-app raj2899/demo-app:latest'
                    sh 'docker push raj2899/demo-app:latest'             
            }
        }
    }
    }
    stage("Deployment on Docker"){
        steps{
            sh 'docker stop node-app && docker rm node-app || true'
            sh 'docker run -itd --name node-app -p 3000:3000 raj2899/demo-app:latest'
        }
    }
    post {
        success {
            mail to: 'yatingambhir85@gmail.com',
                 subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The build succeeded. See: ${env.BUILD_URL}"
        }
        failure {
            mail to: 'yatingambhir85@gmail.com',
                 subject: "FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The build failed. See: ${env.BUILD_URL}"
        }
    }
    }
}
      
  
    
