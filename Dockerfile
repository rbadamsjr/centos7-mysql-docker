FROM centos:centos7

MAINTAINER Roland Adams <roland.adams@smartideasllc.net>

ENV MYSQL_USER=root \
    MYSQL_PASS=password \
    MYSQL_CLIENT=172.17.%.% \
    CREATEDB=false \
    MYSQL_DB=breakoutfinance \
    APP_USER=admin \
    APP_PASS=password \
    IS_DB_SLAVE=false \
    REP_USER=repUser \
    REP_PASS=repPassword \
    MYSQL_SERVER_ID=1 \
    MYSQL_PORT=3306 \
    IS_NEW_INSTANCE=true

# needed to install mysql community
ADD mysql57-community-release-el6-8.noarch.rpm .

RUN yum localinstall mysql57-community-release-el6-8.noarch.rpm -y && \
    yum install mysql-community-server -y && \
    yum install epel-release -y && \
    yum install python34 -y && \
    yum install java-1.8.0-openjdk-devel.x86_64 -y && \
    yum install expect -y && \
    yum update -y && \
    yum clean all && \
    rm -fr /var/cache/*


COPY secure-answers.sh /tmp
RUN chmod 755 /tmp/secure-answers.sh
RUN /usr/bin/mysql_install_db --datadir="/var/lib/mysql" --user=mysql
RUN /usr/bin/mysqld_safe --datadir="/var/lib/mysql" --socket="/var/lib/mysql/mysql.sock" --user=mysql  >/dev/null 2>&1 &
RUN /tmp/secure-answers.sh

EXPOSE 3306
