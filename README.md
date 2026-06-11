# ProxySQL Master/Slave Split Template

Minimal template for a MySQL read/write split setup using ProxySQL.

## What this template includes

- `docker-compose.yml` for ProxySQL + MySQL master + MySQL slave
- `proxysql.cnf` for basic read/write routing
- `sql/` scripts for replication setup, ProxySQL bootstrap, and a smoke test
- `.env.example` for local values you should replace before use

## Suggested repository layout

```text
master-salve/
├── .env.example
├── .gitignore
├── README.md
├── docker-compose.yml
├── proxysql.cnf
└── sql/
    ├── 01-create-replication-user.sql
    ├── 02-bootstrap-proxysql.sql
    └── 03-smoke-test.sql
```

## Ports

- `6032` ProxySQL admin port
- `6033` ProxySQL application port
- `6080` ProxySQL stats/web port
- `33306` MySQL master exposed port
- `23306` MySQL slave exposed port

## Manual setup flow

1. Clone this repo.
2. Create a real `.env` from `.env.example` and adjust passwords.
3. Start the stack with `docker compose up -d`.
4. Run `sql/01-create-replication-user.sql` on the master.
5. Configure slave replication using the MySQL source log position from the master.
6. Connect to ProxySQL admin and run `sql/02-bootstrap-proxysql.sql`.
7. Run `sql/03-smoke-test.sql` through ProxySQL to verify writes and reads.

## Notes

- The MySQL container names are used as ProxySQL hostnames inside the Docker network.
- The ProxySQL config uses a simple rule set: `SELECT` goes to the reader hostgroup, while write statements stay on the writer hostgroup.
- If you need strict routing for more query patterns, extend `mysql_query_rules` in `proxysql.cnf`.