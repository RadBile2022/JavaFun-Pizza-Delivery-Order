pipeline {
    agent any
    tools {
        maven 'mvn 3.9'
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
         stage('Manual Approval') {
            steps {
                script {
                    def userInput = input(
                        message: 'Lanjutkan ke tahap Deploy?',
                        parameters: [choice(choices: ['Yes'], description: 'Choose an option', name: 'CONTINUE')]
                    )
                    if (userInput == 'Yes') {
                        echo 'Continuing with deployment...'
                        // sh './jenkins/scripts/deliver.sh'
                        // sh 'sleep 60'
                        // sh './jenkins/scripts/kill.sh'
                    } else {
                        echo 'Deployment aborted.'
                        sh './jenkins/scripts/kill.sh'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'The Deploy is started, please wait'
                sh 'chmod +x ./jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/deliver.sh'


                echo 'Before sleep'
                sleep time: 60, unit: 'SECONDS'
                echo 'After sleep'
                
                echo 'After 60 seconds will be end'
                 sh 'chmod +x ./jenkins/scripts/kill.sh'
                sh './jenkins/scripts/kill.sh'
            }
        }
        // stage('Deploy') { 
        //     steps {
        //         chmod './jenkins/script/deliver.sh'
        //        sh './jenkins/script/deliver.sh'
        //         input message: 'Finished using the website? (Click "Proceed" to continue)'
        //         chmod './jenkins/script/kill.sh'
        //         sh './jenkins/script/kill.sh'
        //     }
        // }
           
    }
}
