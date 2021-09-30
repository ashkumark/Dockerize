pipeline {
    agent any
    
    stages {
        stage('Build Jar') {
            agent {
                docker {
                	image 'maven:3.8.2-openjdk-8'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build Image') {
            steps {
                script {
                        dockerImage = docker.build("ashkumarkdocker/docker-e2e-automation")
                }
            }
        }
        stage('API Automation') {
        	agent {
                docker {
                    image 'maven:3.8.2-openjdk-8'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
            	sh 'mvn test -Dcucumber.filter.tags="@API"'
            }
        }
        stage('UI Automation') {
        	agent {
                docker {
                    image 'maven:3.8.2-openjdk-8'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
            	sh 'mvn test -Dcucumber.filter.tags="@UI"'
            }       
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                           // app.push("${BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
    
	post {
        success {
          // publish html
          publishHTML target: [
              allowMissing: false,
              alwaysLinkToLastBuild: false,
              keepAll: true,
              reportDir: 'reports',
              reportFiles: 'index.html',
              reportName: 'E2E Tests Report'
            ]
        }
      }
}