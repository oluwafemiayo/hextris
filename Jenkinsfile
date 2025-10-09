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
    image: rgf25/helm-kubectl:v1.0
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
        container('helm') {
          sh '''
          echo "Deploying Hextris via Helm..."

          # Lint and verify chart before deploying
          helm lint ./hextris-1.0.0.tgz

          # Install or upgrade the Helm release
          helm upgrade --install hextris ./hextris-1.0.0.tgz \
            --namespace hextris \
            --create-namespace

          # Wait for deployment rollout to complete
          echo "Waiting 30 seconds for deployment rollout..."
          sleep 30
          
          #Check status of deployment
          kubectl rollout status deployment/hextris-hextris -n hextris --timeout=180s

          echo "Deployment completed successfully!"
        '''
        }
      }
    }
  }
}

