# Enclave AI

This repository contains Docker Compose files for a small self-hosted stack with:

- BookStack
- Gitea
- Redmine
- Nginx Proxy Manager

## Structure

- compose/ - Docker Compose files
  - bookstack.yml
  - gateway.yml
  - gitea.yml
  - redmine.yml
- data/ - persistent host-mounted data directories
  - bookstack/
  - gitea/
  - redmine/
  - proxy/
- environments/ - environment files used by the services

## Important notes

- All application data is stored on the host filesystem under the data/ directory.
- This makes recovery easier if containers fail or need to be recreated.
- The Compose files also include resource limits, restart policies, health checks, and log size limits for better stability.

## Start services

From the repository root, run:

```bash
docker compose -f compose/gateway.yml up -d
docker compose -f compose/bookstack.yml up -d
docker compose -f compose/gitea.yml up -d
docker compose -f compose/redmine.yml up -d
```

## Stop services

```bash
docker compose -f compose/gateway.yml down
docker compose -f compose/bookstack.yml down
docker compose -f compose/gitea.yml down
docker compose -f compose/redmine.yml down
```

## Data locations

- BookStack
  - database: data/bookstack/db
  - uploads: data/bookstack/uploads

- Gitea
  - data: data/gitea/data

- Redmine
  - database: data/redmine/db
  - files: data/redmine/data

- Proxy Manager
  - data: data/proxy/data
  - certificates: data/proxy/certs

## Recovery if an app is not reachable

1. Check container status:

```bash
docker ps -a
```

2. Check logs:

```bash
docker logs <container_name>
```

3. Keep the host data folders intact.

4. Recreate containers using the same Compose files and the same host-mounted paths.

5. If needed, copy the relevant data folder to a backup location first.

## Backup suggestion

You can back up all persistent data with:

```bash
mkdir -p backup
cp -r data backup/
```

## Access URLs

- BookStack: http://localhost:6875
- Gitea: http://localhost:3031
- Redmine: http://localhost:3030
- Proxy Manager admin UI: http://localhost:8181
