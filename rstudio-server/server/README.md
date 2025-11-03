# RStudio Server Setup

- [Docker Compose Configuration](#docker-compose-configuration)
  - [Quick Start](#quick-start)
  - [Configuration](#configuration)
  - [Commands](#commands)
  - [Troubleshooting](#troubleshooting)
- [Integration with AI Agents](#integration-with-ai-agents)
  - [Remote LLMs](#remote-llms)
- [References](#references)

## Docker Compose Configuration

This Docker Compose configuration sets up RStudio Server using the `rocker/tidyverse` image.

### Quick Start

1. **Set your password**:
   ```bash
   # Edit .env file and set RSTUDIO_PASSWORD
   nano .env
   ```

2. **Start RStudio Server**:
   ```bash
   docker compose up -d
   ```

3. **Access RStudio**:
   - URL: http://localhost:8787
   - Username: `rstudio`
   - Password: (as set in .env file)

### Configuration

Environment variables:
- `RSTUDIO_PASSWORD`: Password for the rstudio user
- `USER`: Your system username for volume mounting

Volumes:
- `./data`: Persistent data storage
- `./projects`: R projects directory
- `./apps`: Read-only mount of your apps directory


### Commands

```bash
# Start the service
docker compose up -d

# View logs
docker compose logs -f

# Stop the service
docker compose down

# Restart the service
docker compose restart

# Access container shell
docker compose exec rstudio-server bash
```

### Troubleshooting

**Common Issues**:
1. **Port 8787 already in use**:
   ```bash
   sudo lsof -i :8787
   # Kill any processes using the port
   ```

2. **Can't access from remote**:
   - Ensure firewall allows port 8787
   - Use SSH tunnel for secure remote access:
   ```bash
   ssh -L 8787:localhost:8787 username@hostname
   ```

## Integration with AI Agents

### Remote LLMs

To enable Copilot integration in RStudio Server, add the following line to the R session configuration file:

```
# Edit rsession config file
nano /etc/rstudio/rsession.conf
```

Add the line:
> copilot-enabled=1

And then restart RStudio Server and follow the [instructions to setup Copilot in RStudio](https://docs.posit.co/ide/user/ide/guide/tools/copilot.html).

*Note:* Use `chattr` package for dialog with OpenAI, Anthropic, or other remote LLMs, but not supported Copilot at November, 2025.

## References

1. [Rocker Project](https://rocker-project.org/images/versioned/rstudio.html)
2. [Docker Hub: rocker/tidyverse](https://hub.docker.com/r/rocker/tidyverse)
