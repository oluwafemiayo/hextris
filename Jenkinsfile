pipeline {
  agent {
    kubernetes {
      cloud 'kubernetes'
      defaultContainer 'kubectl'
      yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins-sa
  containers:
  - name: kubectl
    image: rancher/kubectl:v1.32.9-amd64
    command:
    - cat
    tty: true
"""
    }
  }

  environment {
    KUBECONFIG = credentials('kubeconfig')
  }

  stages {

    stage('Deploy to Kubernetes') {
      steps {
        container('kubectl') {
          sh '''
          echo "Applying manifests..."
          kubectl apply -f deployment.yaml -n hextris
          kubectl rollout status deployment/hextris -n hextris
          '''
        }
      }
    }
  }
}
