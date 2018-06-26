pipeline {
  agent {
    dockerfile true 
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
  }
  post { 
        success { 
            echo 'pipeline success :) !'
        }
        failure { 
            echo 'pipeline failure :( !'
        }
    }
}
