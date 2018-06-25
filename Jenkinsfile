pipeline {
  agent {
    docker {
      image 'ubuntu'
    }

  }
  stages {
    stage('configure') {
      steps {
        echo 'Configuring
        sh 'mkdir build && cd build && cmake ..'
      }
    }
  }
}
