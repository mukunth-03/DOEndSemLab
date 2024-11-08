pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the Git repository
                git branch: 'main', url: 'https://github.com/mukunth-03/DOEndSemLab'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the multi-stage Dockerfile and store it in a variable
                    dockerImage = docker.build("my-app:latest")
                }
            }
        }
        
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Run the Docker container with port mapping and store container ID
                    container = dockerImage.run("-p 8081:8080") // Change 8081 to 8080 if port 8080 is free on host
                }
            }
        }
    }
    
    post {
        always {
            // Cleanup Docker containers and images after pipeline completion
            script {
                try {
                    container.stop()
                    container.remove()
                } catch (Exception e) {
                    echo "Container cleanup failed: ${e}"
                }
                
                try {
                    dockerImage.remove()
                } catch (Exception e) {
                    echo "Image cleanup failed: ${e}"
                }
            }
        }
    }
}
