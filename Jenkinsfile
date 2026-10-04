pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean test package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=DVP-Week-12-App'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t arisivam/dvp-week12-app:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withDockerRegistry(
                    credentialsId: 'dockerhub-credentials',
                    url: 'https://index.docker.io/v1/'
                ) {
                    sh 'docker push arisivam/dvp-week12-app:latest'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker rm -f dvp-week12-app || true'
                sh 'docker run -d --name dvp-week12-app -p 8081:8080 arisivam/dvp-week12-app:latest'
            }
        }
    }

    post {
        success {
            echo 'Week 12 CI/CD Pipeline completed successfully!'
        }
        failure {
            echo 'Week 12 CI/CD Pipeline failed!'
        }
    }
}
