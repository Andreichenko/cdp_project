pipeline {
  agent any
  tools {
    maven 'maven-3.8.6'
    jdk 'JDK'
  }
  stages {
    stage('Checkout external proj') {
      steps {
        git branch: 'master',
            url: 'https://github.com/Andreichenko/cdp_project.git'
            sh "ls -lat"
            }
        }
    stage ('Initialize') {
      steps {
        echo "PATH = ${M2_HOME}/bin:${PATH}"
        echo "M2_HOME = /opt/maven/apache-maven-3.8.6/"
      }
    }
    stage('Build') {
       steps {
        dir("/var/lib/jenkins/workspace/Maven\ Build/") {
        sh 'mvn -B -DskipTests clean package'
      }
     }
   }
  }
}
