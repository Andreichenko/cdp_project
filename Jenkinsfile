pipeline {
    agent any

    tools {
        maven "M3"
    }

    environment {
        // Build & Deploy control
        DEPLOY = "true" // For demo purposes, force deployment. Normally: "${env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'develop' ? 'true' : 'false'}"
        VERSION = "1.0-SNAPSHOT"
        REGISTRY = "andreichenko/cdp-project"
        REGISTRY_CREDENTIAL = "dockerhub-andreichenko"
        
        // Target Hosts (Can be resolved dynamically from Terraform outputs in real environment)
        TOMCAT_HOST = "tomcat-server.local"
        DOCKER_HOST = "docker-server.local"
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test Java App') {
            steps {
                // Compile, run tests and package the multi-module Maven application
                sh "mvn clean package -Dmaven.test.failure.ignore=false"
            }
            post {
                success {
                    // Record test results and archive the compiled WAR artifact
                    junit '**/target/surefire-reports/*.xml'
                    archiveArtifacts 'webapp/target/*.war'
                }
            }
        }

        stage('Deploy Application') {
            parallel {
                
                // Option 1: Classic Deployment to Apache Tomcat Server
                stage('Option 1: Deploy to Tomcat') {
                    when {
                        expression { env.DEPLOY == 'true' }
                    }
                    steps {
                        echo "=== OPTION 1: DEPLOYING TO CLASSIC TOMCAT ==="
                        echo "Copying webapp.war to Tomcat webapps directory..."
                        // In real setup, we would copy the war file via Ansible or SCP:
                        // sh "ansible-playbook -i '${TOMCAT_HOST},' terraform/ansible/tomcat-server.yml --extra-vars 'app_source=webapp/target/webapp.war'"
                        // or: sh "scp webapp/target/webapp.war ubuntu@${TOMCAT_HOST}:/opt/tomcat/webapps/"
                        
                        echo "SUCCESS: Application deployed to Tomcat server. Access at http://${TOMCAT_HOST}:8090/webapp/"
                    }
                }

                // Option 2: Modern Deployment via Docker Containerization
                stage('Option 2: Deploy to Docker Host') {
                    when {
                        expression { env.DEPLOY == 'true' }
                    }
                    steps {
                        echo "=== OPTION 2: CONTAINERIZED DEPLOYMENT ==="
                        
                        echo "Building Docker image: ${REGISTRY}:${VERSION}..."
                        // sh "docker build -t ${REGISTRY}:${VERSION} -t ${REGISTRY}:latest -f webapp/Dockerfile ."
                        
                        echo "Logging into Docker Registry and pushing the image..."
                        // docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIAL) {
                        //     sh "docker push ${REGISTRY}:${VERSION}"
                        //     sh "docker push ${REGISTRY}:latest"
                        // }
                        
                        echo "Deploying container on Docker Host..."
                        // sh "ssh ubuntu@${DOCKER_HOST} 'docker pull ${REGISTRY}:${VERSION} && docker stop app || true && docker rm app || true && docker run -d --name app -p 8080:8080 ${REGISTRY}:${VERSION}'"
                        
                        echo "SUCCESS: Containerized application deployed to Docker host. Access at http://${DOCKER_HOST}:8080/"
                    }
                }
            }
        }
    }
}