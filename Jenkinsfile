pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "anikettevare/hello-world"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/anikett-byte/hello-world-devops.git',
                    credentialsId: 'github-cred'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t \$DOCKER_IMAGE:\$DOCKER_TAG ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push \$DOCKER_IMAGE:\$DOCKER_TAG"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh """
                    docker stop hello-world || true
                    docker rm hello-world || true
                    docker run -d --name hello-world -p 80:80 \$DOCKER_IMAGE:\$DOCKER_TAG
                """
            }
        }
    }
}

