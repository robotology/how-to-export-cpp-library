pipeline {
  agent {
    label 'docker-site'
  }
  stages {
    stage('configure') {
      steps {
        echo 'Configuring'
        sh 'mkdir build && cd build && cmake ..'
      }
    }
  }
}
