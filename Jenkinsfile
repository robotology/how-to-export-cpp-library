pipeline {
  agent {
    docker {
      label 'test-pipelines'
      image 'ubuntu'
    }

  }
  stages {
    stage('configure') {
      steps {
        echo 'Configuring'
        sh 'uname -a'
      }
    }
  }
}
