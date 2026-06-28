FROM tomcat:9.0-jre8-alpine
COPY webapp/target/*.war /usr/local/tomcat/webapps/