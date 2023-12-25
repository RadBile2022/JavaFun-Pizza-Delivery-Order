pipeline {
    agent any
    tools {
        maven 'mvn 3.9.6'
    }
    stages {
        stage ('Build Maven'){
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/RadBile2022/JavaFun-Pizza-Delivery-Order.git']])
                sh 'mvn clean install'
            }
        }
        stage ('Test'){
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }
        stage('Deploy') { 
            steps {
               sh './jenkins/script/deliver.sh'
                input message: 'Finished using the website? (Click "Proceed" to continue)'
                sh './jenkins/script/kill.sh'
            }
        }
           
    }
}
