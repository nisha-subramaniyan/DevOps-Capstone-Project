pipeline {
    agent any
    
    tools {
        jdk 'jdk'
        maven 'maven'
    }
    
    environment {
        DOCKER_IMAGE = "nishasubramaniyan/capstone_project"
        CONTAINER_NAME = "capstone_project"
        CONTAINER_PORT = "8081:8080"
        DOCKER_CREDENTIALS = 'docker'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/nisha-subramaniyan/DevOps-Capstone-Project.git'
            }
        }
        
        stage('Code Compile') {
            steps {
                sh "mvn clean compile"
            }
        }
        
        stage('Code Build') {
            steps {
                sh "mvn clean install"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${DOCKER_IMAGE}:${env.BUILD_ID}"
                    sh """
                        docker build -t ${imageTag} .
                        docker tag ${imageTag} ${DOCKER_IMAGE}:latest
                    """
                    echo "✅ Image ${imageTag} built successfully!"
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS}", url: '']) {
                    sh "docker push ${DOCKER_IMAGE}:${env.BUILD_ID}"
                }
            }
        }
        
        stage('Docker Container') {
            steps {
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d -p ${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}:latest
                """
                echo "🚀 Container ${CONTAINER_NAME} started!"
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully! Capstone Project Deployed!'
        }
        failure {
            echo '❌ Pipeline failed! Check logs above.'
        }
    }
}
