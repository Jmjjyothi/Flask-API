pipeline {
    agent any

    environment {
        PYTHON_VERSION = '3.8'
        VENV_NAME = 'vir-env'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git 'YOUR_REPO_URL'
                }
            }
        }

        stage('Setup Environment') {
            steps {
                script {
                    sh "python${PYTHON_VERSION} -m venv ${VENV_NAME}"
                    sh "source ${VENV_NAME}/bin/activate"
                    sh "pip install -r requirements.txt"
                }
            }
        }

        stage('Lint and Test') {
            steps {
                script {
                    sh "flake8 ."
                    sh "python -m unittest discover -v"
                }
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    sh "python setup.py sdist bdist_wheel"
                    //deployment steps
                }
            }
        }
    }

    post {
        always {
            script {
                sh "deactivate"
            }
        }
    }
}
