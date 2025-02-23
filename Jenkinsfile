pipeline {
    agent any

    environment {
        JAVA_HOME = tool 'jdk-17'
        MAVEN_HOME = tool 'maven-3.9.9'
	    SONAR_HOST_URL = 'http://192.168.0.153:9000'
        SONAR_PROJECT_KEY = 'spring-boot-jwt'
        SONAR_LOGIN = credentials('sonar-token')
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE = 'hamzaobey/spring-boot-jwt:0.0.1-SNAPSHOT'
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

    stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
    
    stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push "$DOCKER_IMAGE"
                    '''
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

