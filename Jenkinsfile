pipeline {
    agent any
    tools {
        nodejs 'node18'
        jdk 'jdk17'
    }
    stages {
        stage("Clean Workspace") {
            steps {
                cleanWs()
            }
        }
        stage("Git Checkout") {
            steps {
                git branch: 'master', url: 'https://github.com/charu991/demo-app'
            }
        }
        stage("DOCKER BUILD & PUSH") {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-hub', toolName: 'docker') {
                        sh 'docker build -t demo-app .'
                        sh 'docker tag demo-app raj2899/demo-app:latest'
                        sh 'docker push raj2899/demo-app:latest'
                    }
                }
            }
        }
        stage("Deployment with Docker Compose") {
            steps {
                script {
                 
                    sh 'docker rm -f $(docker ps -q --filter "name=demo-app_demo-app") || true'
                    sh 'docker stack deploy -c docker-compose.yml demo-app'
                }
            }
        }
    }
    post {
        success {
            mail(
                to: 'ananda.yashaswi@quokkalabs.com,prateek.roy@quokkalabs.com',
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "The build succeeded."
            )
        }
        failure {
            mail(
                to: 'ananda.yashaswi@quokkalabs.com,prateek.roy@quokkalabs.com',
                subject: "FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "The build failed."
            )
        }
    }
}

