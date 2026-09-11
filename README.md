# cfy-wp

## Deploy with Coolify

1. Configure the variables from `.env.example` in Coolify with unique passwords.
2. Assign the domain to the `php` service on port `80`.
3. Deploy the Compose application and complete the WordPress installer.

Coolify terminates TLS and routes directly to WordPress/Apache. No service publishes a host port. WordPress and MariaDB state remain in the existing `html/` and `mysql_data/` application storage paths so upgrades preserve data created by earlier revisions.

Redis is available as the internal `cache` service for optional use by WordPress plugins.

## Local validation

Create `.env` from `.env.example`, then run `docker compose up -d --build`. The production Compose file intentionally has no host port binding; use a local override if browser access is required.

Database environment variables initialize only a new database volume. Changing credentials later requires updating the MariaDB user and WordPress configuration together.

If upgrading an existing deployment created with the original defaults, keep its established database values (`wp_user`, `wp_password`, `wordpress`, and `root_password`) for the first successful deployment. Rotate them afterward with explicit MariaDB user/password changes; changing Coolify variables alone does not update an existing database volume.
