pipeline {
    agent any
    environment{
        DOCKERHUB_CREDENCIALS = credentials ('dockerhub')
        RepoDockerHub = 'ivanramadeo'
        NameContainer = 'node-press'
    }

    stages {
        stage('Build'){
            steps{
                dir ('app-devops'){
                    sh "docker build -t ${env.RepoDockerHub}/${env.NameContainer}:${env.BUILD_NUMBER} ."
                }
                
            }
        }
        stage('Lint Dockerfile') {
            steps {
                script {
                    def hadolintExitCode = sh(script: "docker run --rm -i hadolint/hadolint < app-devops/Dockerfile", returnStatus: true)
                    if (hadolintExitCode != 0) {
                        currentBuild.result = 'FAILURE'
                        error("Hadolint found issues in the Dockerfile")
                    }
                }
            }
        }        

        stage('Login to Dockerhub'){
            steps{
                sh "echo $DOCKERHUB_CREDENCIALS_PSW | docker login -u $DOCKERHUB_CREDENCIALS_USR --password-stdin "
            }
        }

        stage('Push image to Dockerhub'){
            steps{
                sh "docker push ${env.RepoDockerHub}/${env.NameContainer}:${env.BUILD_NUMBER} "
            }
        }

        stage('Deploy container'){
            steps{
                sh "if [ 'docker stop ${env.NameContainer}' ] ; then docker rm -f ${env.NameContainer} && docker run -d --name ${env.NameContainer} -p 3000:3000 ${env.RepoDockerHub}/${env.NameContainer}:${env.BUILD_NUMBER} ; else docker run -d --name node-press -p 3000:3000 ${env.RepoDockerHub}/${env.NameContainer}:${env.BUILD_NUMBER} ; fi"
            }
        }
        
        stage('Docker logout'){
            steps{
                sh "docker logout"
            }
        }
    }
}

