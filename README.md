# Data Engineer Server

![Docker](https://img.shields.io/badge/Docker-Compose-blue?logo=docker)
![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-E95420?logo=ubuntu&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11%2B-3776AB?logo=python&logoColor=white)
![Status](https://img.shields.io/badge/status-active-success)

- [Repository structure](#repository-structure)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
  - [Servers](#servers)
  - [Clients](#clients)
- [Configuration](#configuration)
  - [Environment variables](#environment-variables)
- [Ports](#ports)
- [Troubleshooting](#troubleshooting)
- [Development helpers (Ubuntu 24.04)](#development-helpers-ubuntu-2404)
- [Notes on reverse proxy (Traefik)](#notes-on-reverse-proxy-traefik)
- [Contributing](#contributing)


Local-first Data engineering and AI workspace with dockerized services, helper scripts, and Python clients.

- AI agents (Ollama + Open WebUI)
- Object storage (MinIO) with event bus (RabbitMQ)
- Centralized structured logging (Seq)
- RStudio Server for R analytics
- Ubuntu provisioning notes and developer setup scripts.


## Repository structure

```
|--.
|  |-- ai-agents/        # Local AI stack (Ollama + Open WebUI) and model bootstrap
|  |-- development/      # One-off scripts to set up dev tools on Ubuntu
|  |-- minio/            # MinIO object storage: server compose + Python client
|  |-- pipelines/        # AutoML pipeline docs and diagrams (conceptual)
|  |-- rstudio-server/   # RStudio Server via Docker Compose (+ R frameworks notes)
|  |-- seq/              # Seq logging: server compose + Python client
|  |-- ubuntu-os/        # Ubuntu 24.04 tips, packages, disks/network, users
|  `-- README.md
```
 

## Features

- Local AI stack with Ollama and Open WebUI for chat and coding assistance
- RStudio Server for R analytics and data science
- MinIO S3-compatible object storage with optional RabbitMQ notifications
- Seq centralized logging with structured logs
- Minimal Python clients for MinIO and Seq
- Clear, scriptable startup via Docker Compose and small helper scripts


## Prerequisites

- Linux (tested on Ubuntu Server 24.04)
- Docker Engine and Docker Compose plugin
- Optional: Python 3.11+ for the MinIO/Seq client examples


## Quick start

### Servers

#### 1. AI agents: Ollama + Open WebUI

Folder: `ai-agents/` — see more in that folder's README.

```bash
cd ai-agents

# Start services (Ollama + Open WebUI; model-downloader will fetch baseline models)
docker compose up -d

# Watch model downloads
docker compose logs model-downloader -f

# Open the chat UI
# http://localhost:3000
```

Services:
- Ollama: http://localhost:11434
- Open WebUI: http://localhost:3000


#### 2. RStudio Server

Folder: `rstudio-server/server/`

```bash
cd rstudio-server/server

# Set a password for the rstudio user
echo "RSTUDIO_PASSWORD=<your-password>" > .env

# Start RStudio Server
docker compose up -d

# Open the IDE
# http://localhost:8787 (username: rstudio, password: from .env)
```

Notes:
- Port is bound to 127.0.0.1:8787 by default.
- The compose file mounts the relative directories `./projects`, `./data`, and `./apps` into the container at `/home/rstudio/`.
- Extra tips and R package guidance live in `rstudio-server/ds-frameworks/README.md`.


#### 3. MinIO object storage (+ RabbitMQ for notifications)

Folder: `minio/server/`

```bash
cd minio/server

# Required secrets
cat > .env << 'EOF'
MINIO_ROOT_PASSWORD=<strong-password>
RABBITMQ_ROOT_PASSWORD=<strong-password>
# Optional, only used if you run behind Traefik
# PRIMARY_DOMAIN=example.com
EOF

# Create network/volumes and start services
bash ./run.sh

# MinIO S3 API:  http://localhost:9000
# RabbitMQ UI:   http://localhost:15672  (user: admin, pass: from .env)
```

Notes:
- The MinIO Console runs on port 9001 inside the container. It's exposed via Traefik labels if you have a proxy configured; no direct host port is published here.


#### 4. Seq centralized logging

Folder: `seq/server/`

```bash
cd seq/server

# Start (creates network/volume and launches the container)
bash ./run.sh

# Access
# This compose is set up for reverse proxy via Traefik (labels only).
# Publish ports or configure Traefik+PRIMARY_DOMAIN to access the UI.
```


### Clients

#### MinIO client

Folder: `minio/client/`

```bash
cd minio/client
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
```

See `minio/client/clients.py` for Pandas/Polars put/get helpers.


#### Seq logger client

Folder: `seq/client/`

```bash
cd seq/client
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
```

Configure `seq/client/config.yml` with your Seq endpoint and API key, then wire a logger using `LoggerFactory` in `seq_logger.py`.


## Configuration

Most services read configuration from simple `.env` files or inline compose env. Keep secrets out of VCS.

### Environment variables

- AI Agents (`ai-agents/.env`)
  - `WEBUI_SECRET_KEY` — optional secret for Open WebUI (set if enabling auth)
- RStudio (`rstudio-server/server/.env`)
  - `RSTUDIO_PASSWORD` — password for the `rstudio` user
- MinIO/RabbitMQ (`minio/server/.env`)
  - `MINIO_ROOT_PASSWORD` — MinIO root password
  - `RABBITMQ_ROOT_PASSWORD` — RabbitMQ admin password
  - `PRIMARY_DOMAIN` — optional, used by Traefik labels
- Seq client (`seq/client/config.yml`)
  - `logger_settings.seq.server_url`, `api_key` — endpoint and API key


## Ports

- Open WebUI: 3000 (host)
- Ollama: 11434 (host)
- RStudio Server: 8787 (bound to 127.0.0.1)
- MinIO S3 API: 9000 (host)
- RabbitMQ: 5672 (AMQP), 15672 (management UI)
- Seq: not exposed by default (Traefik labels included; add ports or a proxy)


## Troubleshooting

- Port already in use
  - Check with `lsof -i :PORT` and stop conflicting process or change the mapping in compose.
- Docker permission denied
  - Add your user to the `docker` group: `sudo usermod -aG docker $USER && newgrp docker`.
- Models downloading slowly (AI Agents)
  - Watch `model-downloader` logs; ensure adequate bandwidth and disk space.
- RStudio login issues
  - Ensure `.env` has `RSTUDIO_PASSWORD` and the service is reachable on 127.0.0.1:8787.
- MinIO/RabbitMQ not starting
  - Verify `.env` secrets and that the `backend` Docker network exists (created by the run script).

## Development helpers (Ubuntu 24.04)

Folder: `development/` — curated scripts for setting up a workstation/server.

- `docker.sh` — Docker Engine + Compose
- `conda.sh` — Miniconda
- `uv_and_ruff.sh` — Python packaging (uv) and linting (ruff)
- `dotnet_tools.sh` — .NET SDK
- `azure_tools.sh` — Azure CLI/tools
- `git_configure.sh` — Git username/email and quality-of-life settings
- plus others for CI/CD, system design, and optional tools

General OS tips live in `ubuntu-os/README.md` (packages, disks, network, users, and more).


## Notes on reverse proxy (Traefik)

Some compose files include labels for Traefik and refer to `PRIMARY_DOMAIN` in a `.env`. If you're not running a reverse proxy, you can still use the services via the published ports shown above or optionally add explicit `ports:` mappings to the compose files.


## Contributing

Contributions are welcome! If you spot an issue or have an improvement:
- Open an issue describing the problem or proposal
- For changes, fork the repo and open a PR with a concise description and testing notes
- Keep changes focused and documented; prefer small, reviewable PRs
