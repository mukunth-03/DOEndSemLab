pipeline {
    agent any

    tools {
        maven 'Maven 3.x' // Specify the Maven version configured in Jenkins global tools
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mukunth-03/DOEndSemLab'
            }
        }

        stage('Maven Build - Test') {
            steps {
                script {
                    // Run Maven 'test' phase to execute unit tests
                    sh 'mvn clean test'
                }
            }
        }

        stage('Maven Build - Package') {
            steps {
                script {
                    // Run Maven 'package' phase to build the application JAR
                    sh 'mvn package'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-app:latest")
                }
            }
        }
        
        stage('Deploy Docker Container') {
            steps {
                script {
                    container = dockerImage.run("-p 8081:8080") // Map host port 8081 to container port 8080
                }
            }
        }
    }

    post {
        always {
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
