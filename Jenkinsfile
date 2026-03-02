pipeline {
    agent any


    parameters {
        string(name: 'SONAR_IP', defaultValue: '13.50.246.94', description: 'SonarQube Server IP')
    }

    environment {
        SONARQUBE_URL = "http://${params.SONAR_IP}:9000"
        SONARQUBE_TOKEN = 'squ_093817fe64b396b3ca8ad1642543582ec70b6b87' // Hardcoded token
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
                sh '''
                    #Clean previous build
                    make clean
                    #Run build wrapper and compile project
                    build-wrapper-linux-x86-64 --out-dir bw-output make
                '''
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh """
                    mvn sonar:sonar \
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
