# cfy-wp

## Start the stack

1. Copy `.env.example` to `.env` and replace every placeholder password.
2. Start the services with `docker compose up -d --build`.
3. Open `http://localhost` and complete the WordPress installer.

Nginx is the public entry point. Apache/WordPress, MariaDB, and Redis remain on the internal Compose network. WordPress files, database state, and Redis state are persisted in the ignored `html/`, `mysql_data/`, and `redis_data/` directories.
