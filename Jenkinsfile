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
                    // Build the Docker image using the multi-stage Dockerfile
                    docker.build("my-app:latest")
                }
            }
        }
        
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Run the Docker container with port mapping
                    docker.image("my-app:latest").run("-p 8080:8080")
                }
            }
        }
    }
    
    post {
        always {
            // Cleanup Docker containers and images after pipeline completion
            script {
                //def container = docker.image("my-app:latest")
                //container.stop()
                //container.remove()
                dockerImage?.stop()
                dockerImage?.remove()
               // docker.image("my-app:latest").remove()
            }
        }
    }
}
