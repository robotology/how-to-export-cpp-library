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
        echo 'Configuring..'
        sh 'mkdir build && cd build && cmake -DBUILD_TESTING=on .. '
      }
    }
    stage('build') {
      steps {
        echo 'Building..'
        sh 'cd build && cmake --build .'
      }
    }
    stage('test') {
      steps {
        echo 'Testing..'
        sh 'cd build && ctest -R check_sum_and_diff_test'
      }
    }
    post {
        failure {
            mail bcc: '', body: "<b>Example</b><br>\n\<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "matteo.brunettini@iit.it"
        }
    }
  }
}
