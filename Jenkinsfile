pipeline {
    agent any

    environment {
        JAVA_HOME = tool 'jdk-17'
        MAVEN_HOME = tool 'maven-3.9.9'
	SONAR_HOST_URL = 'http://192.168.0.153:9000'
        SONAR_PROJECT_KEY = 'spring-boot-jwt'
        SONAR_LOGIN = credentials('sonar-token')
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
	stage('SonarQube Analysis') {
            steps {
                script {
                    // Running SonarQube analysis with Maven
                    sh """
                            ${MAVEN_HOME}/bin/mvn  sonar:sonar \
                            -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                            -Dsonar.host.url=${SONAR_HOST_URL} \
                            -Dsonar.login=${SONAR_LOGIN}
                    """
                }
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

