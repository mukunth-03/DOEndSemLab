pipeline {
    agent any

    tools {
        maven 'Maven' // Update this to match the Maven tool name in Global Tool Configuration
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the Git repository
                git branch: 'main', url: 'https://github.com/mukunth-03/DOEndSemLab'
            }
        }

        stage('Build with Maven') {
            steps {
                // Run the Maven build (clean and package)
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Run Tests') {
            steps {
                // Run the Maven test phase
                sh 'mvn test'
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
                def container = docker.image("my-app:latest")
                container.stop()
                container.remove()
            }
        }
    }
}
