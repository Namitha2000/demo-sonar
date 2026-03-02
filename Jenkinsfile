pipeline {
    agent any
    tools {
        // Java is only needed if SonarScanner requires it
        jdk 'jdk17'
        git 'Default'
    }
    parameters {
        string(name: 'SONAR_URL', defaultValue: '13.50.246.94', description: 'SonarQube server IP')
    }
    environment {
        SONARQUBE_URL = "http://${params.SONAR_URL}:9000"
        SONARQUBE_TOKEN = credentials('sonar-token') // Use Jenkins credentials ID
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
                sh 'make clean'
                sh 'build-wrapper-linux-x86-64 --out-dir bw-output make'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                    sonar-scanner \
                        -Dsonar.projectKey=demo-sonar \
                        -Dsonar.sources=. \
                        -Dsonar.cfamily.build-wrapper-output=bw-output \
                        -Dsonar.host.url=$SONARQUBE_URL \
                        -Dsonar.login=$SONARQUBE_TOKEN
                    """
                }
            }
        }
    }
}
