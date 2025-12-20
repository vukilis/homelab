## Project Structure

Below is the detailed directory layout:

```text
├── backup.sh                # Script to fetch compose/config files from remote servers
├── compose/                 # Backup of all server-side configurations
```

## Backup & Configuration Management

This project tracks the "tools" configurations running inside the servers.

### The `compose/` Directory

The `/compose` folder serves as a **Central Configuration Repository**. It contains:
* `docker-compose.yml` files for all services.
* Application-specific configuration files (e.g., `.conf`, `.yaml`).

### Backup Script `backup.sh`

To ensure the local `compose/` directory matches the state of your production servers, run the backup script:

```bash
chmod +x backup.sh
./backup.sh
```