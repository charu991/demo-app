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
            sh 'docker stop demo-app-con && docker rm demo-app-con || true'
            sh 'docker run -itd --name demo-app-con -p 3000:3000 demo-app:latest'
        }
    }
    }
}
      
  
    
