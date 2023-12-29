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
        stage ('Build docker image'){
            steps {
                script {
                    sh 'docker build -t radar511/java-pdo .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u radar511 -p ${dockerhubpwd}'
                    
                    sh 'docker push radar511/java-pdo'
                }
                    
                }
            }
        }
           
    }
}

// MANUAL MODE
// pipeline {
//     agent any
//     tools {
//         maven 'mvn 3.9'
//     }
//     stages {
//         stage ('Build Maven'){
//             steps {
//                 checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/RadBile2022/JavaFun-Pizza-Delivery-Order.git']])
//                 sh 'mvn clean install'
//             }
//         }
//         stage ('Test'){
//             steps {
//                 script {
//                     sh 'mvn test'
//                 }
//             }
//         }
//          stage('Manual Approval') {
//             steps {
//                 script {
//                     def userInput = input(
//                         message: 'Lanjutkan ke tahap Deploy?',
//                         parameters: [choice(choices: ['Yes'], description: 'Choose an option', name: 'CONTINUE')]
//                     )
//                     if (userInput == 'Yes') {
//                         echo 'Continuing with deployment...'
//                         // sh './jenkins/scripts/deliver.sh'
//                         // sh 'sleep 60'
//                         // sh './jenkins/scripts/kill.sh'
//                     } else {
//                         echo 'Deployment aborted.'
//                         sh './jenkins/scripts/kill.sh'
//                     }
//                 }
//             }
//         }
//         stage('Deploy') {
//             steps {
//                 input message : 'Lanjutkah menggunakan javanya ?'
//                 echo 'The Deploy is started, please wait'
//                 echo 'Deploy is success'
//                 // sh 'chmod +x ./jenkins/scripts/deliver.sh'
//                 // sh './jenkins/scripts/deliver.sh'

                
//                 // input message : 'sudahkah menggunakan javanya ?'
//                 // sh 'sleep 1m'
               
                
//                 // echo 'After 60 seconds will be end'
//                 //  sh 'chmod +x ./jenkins/scripts/kill.sh'
//                 // sh './jenkins/scripts/kill.sh'
//             }
//         }           
//     }
// }
