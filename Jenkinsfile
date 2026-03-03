pipeline {
    agent any

    parameters {
        string(name: 'SONAR_IP', defaultValue: '13.50.246.94', description: 'SonarQube Server IP')
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
                // This uses the SonarQube Scanner plugin
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner -Dsonar.projectKey=demo-sonar -Dsonar.sources=.'
                }
            }
        }
    }
}
