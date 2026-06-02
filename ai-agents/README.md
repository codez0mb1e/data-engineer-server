# AI Agents Development

Scripts for local AI development.

- [Quick Start](#quick-start)
- [Services](#services)
- [Models](#models)
  - [Monitoring download](#monitoring-download)
- [VS Code Integration](#vs-code-integration)
  - [Prerequisites](#prerequisites)
  - [Add Ollama as a Copilot Chat model provider](#add-ollama-as-a-copilot-chat-model-provider)
  - [MCP servers (file access + persistent memory)](#mcp-servers-file-access--persistent-memory)
  - [Thinking mode](#thinking-mode)
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

## Models

The `download_models.sh` script automatically downloads.

See all available models at [ollama.com/models](https://ollama.com/models).

### Monitoring download

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

## VS Code Integration

### Prerequisites

- VS Code ≥ 1.113
- GitHub Copilot Chat extension installed and signed in
- Node.js 22+ installed (`npx` is required for MCP servers) — see [`development/nodejs.sh`](../development/nodejs.sh)

### Add Ollama as a Copilot Chat model provider

1. Open the Copilot Chat panel (`Ctrl+Alt+I`)
2. Click the model picker → **Manage Models...**
3. Select provider **Ollama**, set base URL `http://localhost:11434`
4. Click **Save**, then **Unhide** `qwen3-coder` and add it

`qwen3-coder` will now appear in the model picker for all chat sessions.

### MCP servers (file access + persistent memory)

MCP config is at `.vscode/mcp.json` (see [example](mcp.json)). Two servers are configured:

| Server | Purpose |
|---|---|
| `filesystem` | Read/list files under `/home/dp/apps` |
| `memory` | Persistent key-value memory across sessions |

Memory is stored at `~/.local/share/mcp-memory/memory.json`. Create the directory before first use:

```bash
mkdir -p ~/.local/share/mcp-memory
```

Start servers: **Ctrl+Shift+P → MCP: List Servers → Start**, or reload the window.

Verify: **Ctrl+Shift+P → MCP: List Servers** — both should show as **Running**.

### Thinking mode

By default `qwen3-coder` may use extended reasoning. Toggle per message:

- Prefix with `/no_think` for fast responses (coding, completions)
- Prefix with `/think` for deep reasoning (architecture, debugging)

In Open WebUI the thinking toggle is available in the chat controls.

## Configuration

Edit `.env` file:

```bash
WEBUI_SECRET_KEY=your-secure-key-here
```
