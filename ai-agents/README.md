# AI Agents Development

Scripts for local AI development.

- [Quick Start](#quick-start)
- [Services](#services)
- [Models](#models)
  - [Monitoring download](#monitoring-download)
- [Configuration](#configuration)
- [VS Code Integration](#vs-code-integration)
  - [Prerequisites](#prerequisites)
  - [Add Ollama as a Copilot Chat model provider](#add-ollama-as-a-copilot-chat-model-provider)
  - [MCP servers (file access + persistent memory)](#mcp-servers-file-access--persistent-memory)
  - [Copilot Skills Reset](#copilot-skills-reset)
- [Debug LLM agents](#debug-llm-agents)
  - [Check the logs of Ollama container](#check-the-logs-of-ollama-container)
  - [Check the logs of Copilot](#check-the-logs-of-copilot)
  - [Check the logs of Open WebUI container](#check-the-logs-of-open-webui-container)


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

## Configuration

Edit `.env` file:

```bash
WEBUI_SECRET_KEY=your-secure-key-here
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
4. Click **Save**, then **Unhide** `qwen3-datascientist` and add it

`qwen3-datascientist` will now appear in the model picker for all chat sessions.

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

### Copilot Skills Reset

VS Code Server bundles built-in Copilot skills loaded from two locations. To disable them (e.g. to start with a clean slate or use only custom skills):

```bash
PROMPTS_CLI=~/.vscode-server/cli/servers/Stable-$(ls ~/.vscode-server/cli/servers/ | grep Stable | tail -1 | sed 's/Stable-//')/server/extensions/copilot/assets/prompts
PROMPTS_BIN=~/.vscode-server/bin/$(ls ~/.vscode-server/bin/ | tail -1)/extensions/copilot/assets/prompts

# Disable built-in skills (rename to preserve originals)
mv "$PROMPTS_CLI/skills" "$PROMPTS_CLI/skills_old" && mkdir "$PROMPTS_CLI/skills"
mv "$PROMPTS_BIN/skills" "$PROMPTS_BIN/skills_old" && mkdir "$PROMPTS_BIN/skills"
```

To restore:

```bash
rm -rf "$PROMPTS_CLI/skills" && mv "$PROMPTS_CLI/skills_old" "$PROMPTS_CLI/skills"
rm -rf "$PROMPTS_BIN/skills" && mv "$PROMPTS_BIN/skills_old" "$PROMPTS_BIN/skills"
```

Then restart the VS Code Server: `Ctrl+Shift+P` → `Remote: Restart Remote Server`.

Custom skills can be placed in `.github/skills/` at the repo root — each skill is a subfolder containing a `SKILL.md` file.


## Debug LLM agents

### Check the logs of Ollama container

```bash
docker logs -f ollama
```

### Check the logs of Copilot

1. Activate Agent Debug Logs in VS Code settings.
2. Open 'Chat Debug View' in VS Code.

### Check the logs of Open WebUI container

```bash
docker logs -f open-webui
```
