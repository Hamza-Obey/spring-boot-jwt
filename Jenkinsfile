pipeline {
    agent any

    environment {
        JAVA_HOME = tool 'jdk-17'
        MAVEN_HOME = tool 'maven-3.9.9'
    }

    stages {
	stage('Check Java') {
            steps {
                sh '''
                echo "JAVA_HOME: $JAVA_HOME"
                java -version
                '''
            }
        }
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Install') {
            steps {
                sh "${MAVEN_HOME}/bin/mvn clean install"
            }
        }
    }

    post {
        success {
            echo "Build is successful!"
        }
        failure {
            echo "Build is failed!"
        }
    }
}

