pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "anikettevare/hello-world-devops"   // change to your DockerHub username/repo
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/anikett-byte/hello-world-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                docker run -d -p 5000:5000 --name flask_app $DOCKER_IMAGE:$DOCKER_TAG
                sleep 5
                '''
            }
        }

        stage('Test Flask App') {
            steps {
                sh '''
                curl -f http://localhost:5000 | grep "Hello, DevOps World!"
                '''
            }
        }

        stage('Stop and Clean Up') {
            steps {
                sh '''
                docker stop flask_app || true
                docker rm flask_app || true
                '''
            }
        }

        stage('Push to DockerHub') {
            when {
                expression { return env.BRANCH_NAME == 'main' }  // only push on main branch
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
