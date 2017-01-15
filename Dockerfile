 
FROM centos:centos7

MAINTAINER Roland Adams <roland.adams@smartideasllc.net>

ENV MYSQL_USER=root \
    MYSQL_PASS=password \
    MYSQL_CLIENT=172.17.%.% \
    CREATEDB=false \
    MYSQL_DB=mydatabase \
    APP_USER=admin \
    APP_PASS=password \
    IS_DB_SLAVE=false \
    REP_USER=repUser \
    REP_PASS=repPassword \
    MYSQL_SERVER_ID=1 \
    MYSQL_PORT=3306 \
    IS_NEW_INSTANCE=true

# needed to install mysql community
RUN yum install -y wget && \
    wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

ADD MySQL-5.7/mysql-community-libs-5.7.17-1.el7.i686.rpm .


ADD mysql57-community-release-el6-8.noarch.rpm .

RUN rpm --import http://dev.mysql.com/doc/refman/5.7/en/checking-gpg-signature.html

RUN yum localinstall mysql57-community-release-el6-8.noarch.rpm -y && \
    yum install mysql-community-server -y && \
    yum install epel-release -y && \
    yum install expect -y && \
    yum update -y && \
    yum clean all && \
    rm -fr /var/cache/*

VOLUME ["/var/lib/mysql"]

COPY secure-answers.sh /tmp
RUN chmod 755 /tmp/secure-answers.sh
RUN /usr/sbin/mysqld --initialize --datadir="/var/lib/mysql" --user=mysql
#RUN /usr/bin/mysqld --inintialize --datadir="/var/lib/mysql" --socket="/var/lib/mysql/mysql.sock" --user=mysql  >/dev/null 2>&1 &

RUN passwd="`grep 'temporary.*root@localhost' /var/log/mysqld.log | sed 's/.*root@localhost: //'`"
RUN /tmp/secure-answers.sh

EXPOSE 3306
