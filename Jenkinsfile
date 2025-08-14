pipeline {
    agent any

    environment {
<<<<<<< HEAD
        DOCKER_IMAGE = "anikettevare/hello-world"
        DOCKER_TAG = "latest"
        SONARQUBE_SERVER = "SonarQubeServer"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Use GitHub credentials for private repo
                git branch: 'main',
                    url: 'https://github.com/anikett-byte/hello-world-devops.git',
                    credentialsId: 'github-cred'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    // Use Jenkins stored secret for SonarQube token
                    withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_AUTH_TOKEN')]) {
                        sh "sonar-scanner -Dsonar.projectKey=hello-world -Dsonar.sources=. -Dsonar.host.url=\$SONAR_HOST_URL -Dsonar.login=\$SONAR_AUTH_TOKEN"
                    }
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
                // Use DockerHub credentials stored in Jenkins
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push \$DOCKER_IMAGE:\$DOCKER_TAG"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
=======
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/anikett-byte/hello-world-devops.git'
            }
        }
        stage('Unit Tests') {
            steps {
                sh 'pytest tests/ --maxfail=1 --disable-warnings -q'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh 'sonar-scanner'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t anikettevare/hello-world:latest .'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push anikettevare/hello-world:latest'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
>>>>>>> 88c57996e1dc6efb2f17977baac3901c270d1bb0
            }
        }
    }
}
<<<<<<< HEAD

=======
>>>>>>> 88c57996e1dc6efb2f17977baac3901c270d1bb0
