pipeline {
    agent any
    environment {
    dockerimagename = "beltus325/hextris"
    dockerImage = ""
  }
    stages {
        stage('building image') {
            steps {
              script{
                dockerImage = docker.build dockerimagename
              }
            }
        }
        stage('pushing image') {
            environment {
                registryCredential = 'dockerhublogin'
            }
                steps {
                    script{
                        docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                        dockerImage.push("latest")}
                    }
                }
        }
        stage('deployment') {
                steps {
                    script{
                        kubernetesDeploy(configs: "Deployment.yaml", kubeconfigId: "kubernetes")
                    }
                }
        }

    }
}