# AI Agents Development

Scripts for local AI development.

- [Quick Start](#quick-start)
- [Services](#services)
- [Models Included](#models-included)
  - [Monitor Download Progress](#monitor-download-progress)
- [Configuration](#configuration)


## Quick Start

```bash
# 1. Start services (automatically downloads models)
docker compose up -d

# 2. Monitor model downloading progress
docker compose logs model-downloader -f

# 3. Access Open WebUI (after models are downloaded)
open http://localhost:3000
```

## Services

- **Ollama**: http://localhost:11434 (LLM inference)
- **Open WebUI**: http://localhost:3000 (Chat interface)

## Models Included

The `download_models.sh` script automatically downloads:

- `llama3.2`: light-weighted general purpose chat model
- `deepseek-coder`: code generation and assistance
- `gpt-oss`: SotA reasoning model

See all available models at [ollama.com/models](https://ollama.com/models).

### Monitor Download Progress

```bash
# Watch model download progress
docker compose logs model-downloader -f

# Check Ollama service status
docker compose logs ollama -f

# List downloaded models
docker exec -it ollama ollama list

# Check if models are ready
curl http://localhost:11434/api/tags
```

## Configuration

Edit `.env` file:

```bash
WEBUI_SECRET_KEY=your-secure-key-here
```
