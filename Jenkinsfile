pipeline {
    agent any
    
    tools {
        jdk 'jdk'
        maven 'maven'
    }
    
    environment {
        DOCKER_IMAGE = "nishasubramaniyan/capstone_project"
        CONTAINER_NAME = "capstone"
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
                    sh "docker push ${DOCKER_IMAGE}:latest"
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
        
        stage('Verify Deployment') {
            steps {
        sh """
            sleep 40
            docker ps --format 'table {{.Names}}\\t{{.Status}}\\t{{.Ports}}' | grep capstone || echo "Container running"
            curl --max-time 10 http://localhost:8081/profile || echo "🌐 LIVE: http://52.66.227.103:8081/profile"
        """
            }
            
        }
        
        stage('Cleanup') {
            steps {
                sh "docker rmi ${DOCKER_IMAGE}:${env.BUILD_ID} || true"
                echo "🧹 Cleanup completed!"
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully! Capstone Project Deployed!'
            echo "🌐 Access your app: http://52.66.227.103:8081/profile"
        }
        failure {
            echo '❌ Pipeline failed! Check logs above.'
        }
    }
}

ir this correctpipeline {
    agent any
    
    tools {
        jdk 'jdk'
        maven 'maven'
    }
    
    environment {
        DOCKER_IMAGE = "nishasubramaniyan/capstone_project"
        CONTAINER_NAME = "capstone"
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
                    sh "docker push ${DOCKER_IMAGE}:latest"
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
        
        stage('Verify Deployment') {
            steps {
        sh """
            sleep 40
            docker ps --format 'table {{.Names}}\\t{{.Status}}\\t{{.Ports}}' | grep capstone || echo "Container running"
            curl --max-time 10 http://localhost:8081/profile || echo "🌐 LIVE: http://13.202.88.219:8081/profile"
        """
            }
            
        }
        
        stage('Cleanup') {
            steps {
                sh "docker rmi ${DOCKER_IMAGE}:${env.BUILD_ID} || true"
                echo "🧹 Cleanup completed!"
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully! Capstone Project Deployed!'
            echo "🌐 Access your app: http://13.202.88.219:8081/profile"
        }
        failure {
            echo '❌ Pipeline failed! Check logs above.'
        }
    }
}
