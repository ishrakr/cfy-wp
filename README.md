# cfy-wp

## Start the stack

1. Copy `.env.example` to `.env` and replace every placeholder password.
2. Start the services with `docker compose up -d --build`.
3. Open `http://localhost` and complete the WordPress installer.

Nginx is the public entry point on the internal Compose network. Configure the deployment platform's application proxy or ingress to route to the `nginx` service on port 80. Apache/WordPress, MariaDB, and Redis remain internal. WordPress files, database state, and Redis state are persisted in the ignored `html/`, `mysql_data/`, and `redis_data/` directories.
