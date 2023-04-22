pipeline {
  agent {
    kubernetes {
      label 'wiremock-image'  // all your pods will be named with this prefix, followed by a unique id
      idleMinutes 5  // how long the pod will live after no jobs have run on it
      yamlFile 'build-pod.yml'  // path to the pod definition relative to the root of our project 
    }
  }
  stages {
    stage('Build and Push Wiremock Training Image') {
      environment {
        DOCKER_CREDS = credentials('dockerio')  // A jenkins credentials (username/password) is expected in jenkins (craete it before running)
      }
      steps {
        container('docker') {  
          sh "docker build -t vmartinvega/bootcamp-wiremock:latest -f Dockerfile-Wiremock ."  // when we run in this step, we're running it via a shell on the docker build-pod container, 
          sh "docker build -t vmartinvega/bootcamp-ansible:latest -f Dockerfile-Ansible ."
          sh "docker login --username=$DOCKER_CREDS_USR --password=$DOCKER_CREDS_PSW"        // which is just connecting to the host docker deaemon
          sh "docker push vmartinvega/bootcamp-wiremock:latest"        // which is just connecting to the host docker deaemon
          sh "docker push vmartinvega/bootcamp-ansible:latest"
        }
      }
    }
  }
}