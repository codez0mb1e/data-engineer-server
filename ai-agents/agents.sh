#!/bin/bash

#
# AI agents development environment setup
#


# 0. Install Ollama [1]
cd ~
curl -fsSL https://ollama.com/install.sh | sh

# checks
ollama -v

# load LLMs
ollama run llama3.2
ollama run deepseek-coder



# 1. Install AutoGen ----
uv sync --all-extras

uv add "autogen-core" "autogen-agentchat"
uv add "autogen-ext[web-surfer,openai,ollama,azure]"


# 2. Install Playwright ----
playwright install 


# References:
# 1. https://github.com/ollama/ollama/blob/main/docs/linux.md
