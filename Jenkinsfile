pipeline {
   environment {
          DEPLOY = "${env.BRANCH_NAME == "master" || env.BRANCH_NAME == "develop" ? "true" : "false"}"
          NAME = "${env.BRANCH_NAME == "master" ? "example" : "example-staging"}"
          VERSION = readMavenPom().getVersion()
          DOMAIN = 'localhost'
          REGISTRY = 'andreichenko/cdp-project'
          REGISTRY_CREDENTIAL = 'dockerhub-andreichenko'
      }

}