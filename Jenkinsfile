pipeline {
  agent {
    label 'docker-site'
  }
  stages {
    stage('configure') {
      steps {
        echo 'Configuring..'
        sh 'mkdir build && cd build && cmake ..'
      }
    }
    stage('build') {
      steps {
        echo 'Building..'
        sh 'cd build && cmake --build'
      }
    }
  }
}
