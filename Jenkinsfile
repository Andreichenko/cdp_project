pipeline {
    agent any
    tools {
        maven 'maven-3.8.6'
        jdk 'java17'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                echo 'mvn -f pom.xml -B -DskipTests clean package'
            }
        }
    }
}