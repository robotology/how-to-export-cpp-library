pipeline {
  agent {
    docker {
      image 'ubuntu:bionic'
      label 'docker-site'
    }
  }
  stages {
    stage('dependecies') {
      steps {
        echo "Installing dependencies.."
        sh 'echo "deb http://www.icub.org/ubuntu bionic contrib/science" > /etc/apt/sources.list.d/icub.list'
        sh 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 57A5ACB6110576A6'
        sh 'sudo apt-get install icub-common'
      }
    }
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
}
