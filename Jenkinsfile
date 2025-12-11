pipeline {
    agent any
    
    tools {
        jdk 'jdk'
        maven 'maven'
    }
    
    environment {
        // User variables
        DOCKER_IMAGE = "nishasubramaniyan/capstone_project"
        CONTAINER_NAME = "capstone"
        CONTAINER_PORT = "8081:8080"
        DOCKER_CREDENTIALS = 'docker'
        
        // Internal variables
        // Use a more descriptive tag for cleanup
        IMAGE_TAG = "${DOCKER_IMAGE}:${env.BUILD_ID}" 
    }

    stages {
        stage('Git Checkout') {
            steps {
                echo 'Checking out source code...'
                // Ensure to clone recursively if submodules are involved, though not strictly needed here
                git branch: 'main', url: 'https://github.com/nisha-subramaniyan/DevOps-Capstone-Project.git'
            }
        }
        
        stage('Code Compile') {
            steps {
                sh "mvn clean compile"
            }
        }
        
        stage('Code Test') {
            // New stage for running unit tests
            steps {
                sh "mvn test"
            }
        }
        
        stage('Code Package') {
            // Separate stage to package the artifact
            steps {
                sh "mvn package -DskipTests" // Only package the artifact, tests already ran
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Use the IMAGE_TAG environment variable
                    sh """
                        docker build -t ${IMAGE_TAG} .
                        docker tag ${IMAGE_TAG} ${DOCKER_IMAGE}:latest
                    """
                    echo "✅ Image ${IMAGE_TAG} built successfully!"
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                // Using withDockerRegistry for authenticated push
                withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS}", url: '']) {
                    sh "docker push ${IMAGE_TAG}" // Push the specific build tag
                    sh "docker push ${DOCKER_IMAGE}:latest" // Push the latest tag
                }
            }
        }
        
        stage('Deploy Docker Container') {
            steps {
                // Stop and remove existing container
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """
                // Run new container
                sh """
                    docker run -d -p ${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}:latest
                """
                echo "🚀 Container ${CONTAINER_NAME} started and exposed on port 8081!"
            }
        }
        
        stage('Verify Deployment') {
            steps {
                // Wait for the application to start up
                sh 'sleep 40' 

                // Check container status and application availability
                sh """
                    echo "Checking Docker container status..."
                    docker ps --filter "name=${CONTAINER_NAME}"
                    
                    echo "Attempting to access application health endpoint (localhost:8081/profile)..."
                    # Exit status of 0 is successful, non-zero is failure
                    curl -s -f http://localhost:8081/profile || true
                """
                echo "🌐 Application endpoint is LIVE: http://52.66.227.103:8081/profile"
            }
        }
        
        stage('Cleanup') {
            steps {
                // Remove the build-specific image tag to free space
                sh "docker rmi ${IMAGE_TAG} || true"
                echo "🧹 Cleanup completed: Build image ${IMAGE_TAG} removed."
            }
        }
    }
    
    post {
        always {
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
        }
        success {
            echo '🎉 Pipeline completed successfully! Capstone Project Deployed!'
            echo "🌐 Access your app: http://52.66.227.103:8081/profile"
        }
        failure {
            echo '❌ Pipeline failed! Check logs above.'
            // Optional: You could add a step here to clean up the newly built container on failure
        }
    }
}
