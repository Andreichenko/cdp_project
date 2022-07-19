pipeline {
    agent any

    tools {
        maven "maven"
        jdk "jdk17"
    }

    stages {
        stage('Initialize'){
            steps{
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
    post {
       always {
          junit(
        allowEmptyResults: true,
        testResults: '*/test-reports/.xml'
      )
      }
   }
}