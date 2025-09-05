#!/bin/bash

#
# AI agents development environment setup
#
# This script sets up:
# - Infra
# - Frameworks
# - Tools
#
# Note: will be decomposed into separate scripts later
# Usage: ./agents.sh
#


# 0. Install Ollama [1]
# install
cd ~
curl -fsSL https://ollama.com/install.sh | sh

# checks
ollama -v

# load LLMs
ollama run llama3.2
ollama run deepseek-coder


# Connect Ollama to Open-WebUI [2]
docker network create ollama-net

docker run -d --network ollama-net -p 3000:8080 \
    -v ollama:/root/.ollama \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    ghcr.io/open-webui/open-webui:ollama

# open http://localhost:3000 in browser for web UI


# 1. Install AutoGen ----

uv add "autogen-core" "autogen-agentchat"
uv add "autogen-ext[web-surfer,openai,ollama,azure]"
uv sync --all-extras


# 2. Install Playwright ----
playwright install


# References:
# 1. https://github.com/ollama/ollama/blob/main/docs/linux.md
# 2. https://github.com/open-webui/open-webui?tab=readme-ov-file#how-to-install-
