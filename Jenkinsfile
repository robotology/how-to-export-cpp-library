pipeline {
  agent {
    docker {
      image 'ubuntu'
    }

  }
  stages {
    stage('configure') {
      steps {
        sh '''mkdir build 
cd build
cmake ..'''
      }
    }
  }
}