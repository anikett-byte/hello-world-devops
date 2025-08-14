pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "anikettevare/hello-world"
        DOCKER_TAG = "latest"
        SONAR_HOST_URL = "http://10.80.80.20:9000"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/anikett-byte/hello-world-devops.git',
                    credentialsId: 'github-cred'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_AUTH_TOKEN')]) {
                    sh """
                        sonar-scanner \
                        -Dsonar.projectKey=hello-world \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=\$SONAR_HOST_URL \
                        -Dsonar.login=\$SONAR_AUTH_TOKEN
                    """
                }
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
                withCredentials([sshUserPrivateKey(credentialsId: 'deploy-server-key', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
                    sh """
                        ssh -i \$SSH_KEY \$SSH_USER@your-server-ip '
                            docker pull \$DOCKER_IMAGE:\$DOCKER_TAG &&
                            docker stop hello-world || true &&
                            docker rm hello-world || true &&
                            docker run -d --name hello-world -p 80:80 \$DOCKER_IMAGE:\$DOCKER_TAG
                        '
                    """
                }
            }
        }
    }
}

