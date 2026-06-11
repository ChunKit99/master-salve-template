CREATE USER IF NOT EXISTS 'replication_user'@'%' IDENTIFIED BY 'replication-password-change-me';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replication_user'@'%';
FLUSH PRIVILEGES;
