#!/bin/bash

#
# AI agents development environment setup
#

uv add ikernel
uv add "autogen-core" "autogen-agentchat" "autogen-ext[openai,ollama,azure]"
uv add "autogen-ext[web-surfer]"

playwright install 

# Download ollama https://ollama.com/download/mac
# install on ubuntu: https://github.com/ollama/ollama/blob/main/docs/linux.md
ollama run llama3.2
