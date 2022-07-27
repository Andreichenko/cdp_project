FROM centos

RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat

RUN curl -O 'https://mirrors.estointernet.in/apache/tomcat/tomcat-10/v10.0.20/bin/apache-tomcat-10.0.20.tar.gz'
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-10.0.20/* /opt/tomcat
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y install java

CMD /bin/bash

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
