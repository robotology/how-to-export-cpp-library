pipeline {
  agent {
    label 'docker-site'
    docker {
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
