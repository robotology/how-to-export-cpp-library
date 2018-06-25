pipeline {
  agent {
    docker {
      image 'ubuntu'
      label 'docker-site'
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
