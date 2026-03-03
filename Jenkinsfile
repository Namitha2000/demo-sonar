pipeline {
    agent any

    parameters {
        string(name: 'SONAR_IP', defaultValue: '13.50.246.94', description: 'SonarQube Server IP')
    }

    environment {
        SONARQUBE_URL = "http://${params.SONAR_IP}:9000"
        SONARQUBE_TOKEN = 'squ_093817fe64b396b3ca8ad1642543582ec70b6b87'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Namitha2000/demo-sonar.git'
            }
        }

        stage('Build') {
            steps {
                sh 'make clean && make'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // Use the Jenkins-installed SonarQube Scanner
                tool name: 'SonarQubeScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                withSonarQubeEnv('SonarQube') {
                    sh """${tool 'SonarQubeScanner'}/bin/sonar-scanner \
                        -Dsonar.projectKey=demo-sonar \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=$SONARQUBE_URL \
                        -Dsonar.login=$SONARQUBE_TOKEN
                    """
                }
            }
        }
    }
}
