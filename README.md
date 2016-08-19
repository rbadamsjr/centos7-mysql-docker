# centos7-mysql-docker
DockerFile for setting up mysql in centos7:latest
- OPENJDK 8
- PYTHON 3.4
- 
# DOCKER RUN Command
docker run --name mysql -p 3306:3306 -it <image name> bash

# SQL ROOT Setup
It has mysql 5.7 installed and briefly configured, Openjdk 8, and Python 3.4
the temp mysql root password is 'password'
and you will have to run the following command in mysql

update user set password=PASSWORD("NEWPASSWORD") where User='root';
flush privileges;
