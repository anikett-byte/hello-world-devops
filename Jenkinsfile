pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/anikett-byte/hello-world-devops.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                cd app
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Flask App') {
            steps {
                sh '''
                cd app
                nohup python main.py > app.log 2>&1 &
                echo $! > flask.pid
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

        stage('Stop Flask App') {
            steps {
                sh '''
                kill $(cat flask.pid) || true
                rm -f flask.pid
                '''
            }
        }
    }
}
