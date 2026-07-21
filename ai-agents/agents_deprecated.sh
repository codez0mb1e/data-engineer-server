#!/bin/bash

#
# AI agents development environment setup
#


# 0. Install Ollama [1]
# See compose.yml to run Ollama server in Docker
# or install
curl -fsSL https://ollama.com/install.sh | sh

# checks
ollama -v

# load LLMs
ollama pull qwen3:14b
ollama create qwen3-coder -f Modelfile

# uninstall Ollama
# https://medium.com/@heartonbit/uninstalling-ollama-db78dd9545fa


# Connect Ollama to Open-WebUI [2]
# Use compose.yml (preferred):
#   docker compose up -d
# Open http://localhost:3000 in browser for web UI


# 1. Install AutoGen ----

uv add "autogen-core" "autogen-agentchat"
uv add "autogen-ext[web-surfer,openai,ollama,azure]"
uv sync --all-extras


# 2. Install Playwright ----

playwright install


# References:
# 1. https://github.com/ollama/ollama/blob/main/docs/linux.md
# 2. https://github.com/open-webui/open-webui?tab=readme-ov-file#how-to-install-
