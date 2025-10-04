pipeline {
  agent {
    kubernetes {
      cloud 'kubernetes'
      label 'deploy-agent'
      defaultContainer 'kubectl'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  namespace: hextris
spec:
  
  serviceAccountName: jenkins-sa
  containers:
  - name: kubectl
    image: registry.k8s.io/kubectl:v1.30.0
    command:
    - cat
    tty: true
    resources:
      requests:
        cpu: "100m"
        memory: "256Mi"
      limits: 
        cpu: "200m"
        memory: "512Mi"
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
