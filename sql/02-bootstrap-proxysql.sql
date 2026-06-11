-- Connect to the ProxySQL admin interface first.
-- Example:
-- mysql -u admin -padmin -h 127.0.0.1 -P6032

DELETE FROM mysql_servers;
INSERT INTO mysql_servers(hostgroup_id, hostname, port, status, weight) VALUES
(10, 'mysql-master', 3306, 'ONLINE', 1),
(20, 'mysql-slave', 3306, 'ONLINE', 1);

DELETE FROM mysql_users;
INSERT INTO mysql_users(username, password, default_hostgroup, active) VALUES
('appuser', 'app-password-change-me', 10, 1);

DELETE FROM mysql_query_rules;
INSERT INTO mysql_query_rules(rule_id, active, match_pattern, destination_hostgroup, apply) VALUES
(1, 1, '^SELECT.*FOR UPDATE', 10, 1),
(2, 1, '^SELECT', 20, 1);

DELETE FROM mysql_replication_hostgroups;
INSERT INTO mysql_replication_hostgroups(writer_hostgroup, reader_hostgroup, comment)
VALUES (10, 20, 'master-slave read/write split');

LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;
LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;
