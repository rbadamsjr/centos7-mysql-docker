#!/bin/bash
/usr/bin/mysqld_safe &
sleep 3

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation

expect \"Enter password for user root:\"
send \"n\r\"
expect \"New password:\"
send \"password\r\"
expect \"Re-enter new password:\"
send \"password\r\"
expect \"Press y|Y for Yes, any other key for No: \"
send \"n\r\"
expect \"Change the password for root ? ((Press y|Y for Yes, any other key for No) : \"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"
