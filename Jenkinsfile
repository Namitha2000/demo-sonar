pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    parameters {
        string(name: 'SONAR_URL', defaultValue: '13.50.246.94', description: 'SonarQube server IP')
    }

    environment {
        SONARQUBE_URL = "http://${params.SONAR_URL}:9000"
        SONARQUBE_TOKEN = 'squ_093817fe64b396b3ca8ad1642543582ec70b6b87'  // Ideally use Jenkins credentials
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
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=demo-sonar \
                        -Dsonar.host.url=$SONARQUBE_URL \
                        -Dsonar.login=$SONARQUBE_TOKEN
                    """
                }
            }
        }
    }
}
