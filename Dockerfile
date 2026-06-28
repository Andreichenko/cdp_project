FROM andreichenko/mytomcat:v1.0
#RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
COPY webapp/target/*.war /opt/tomcat/webapps/