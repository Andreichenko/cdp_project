properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '10', artifactNumToKeepStr: '30', daysToKeepStr: '365', numToKeepStr: '']]]);

timestamps {
    node('master'){

        workspace = pwd()
        // Mark the code checkout 'stage'....
        stage('Checkout'){
            // Get some code from a GitHub repository
            checkout scm
        }
        stage('Clone and check tasks'){
            sh '''
            BRANCH_CLEAN=$(echo $BRANCH_NAME | sed \'s#feature/##g\' | perl -pe \'s/[^\\w]+//g\' | perl -pe \'s/$//g\')
            VERSION=$(date +%Y.%m.%d)
            export BRANCH_CLEAN
            ls -la
            java -version
            '''
        }
         stage('Maven build'){
               sh '''
               echo "PATH = ${M2_HOME}/bin:${PATH}"
               echo "M2_HOME = /opt/maven/apache-maven-3.8.6/"
               mvn --version
               find $PWD -mindepth 1 -maxdepth 1 -exec du -hs {} + 2>/dev/null | sort -hr | head -20
               '''
           }

    }
  }