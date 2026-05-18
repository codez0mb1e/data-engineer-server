#!/bin/bash

#
# Install `uv`, `ruff` and `pyrefly` for Python development
#


# 0. Install uv ----
# install
curl -LsSf https://astral.sh/uv/install.sh | sh
# check
uv -V


# 1. Install Python tools for uv ----
# Install Python 3.13
uv python install 3.13
uv python list 3.13
echo 'import platform; print(platform.python_version())' | uv run -

uv python upgrade 3.13


# Install ruff (globally)
uv tool install ruff@latest
ruff --version


# Install pyrefly
uv tool install pyrefly@latest
pyrefly --version

# add extension to VS Code
# https://marketplace.visualstudio.com/items?itemName=meta.pyrefly

pyrefly init


# 2. Create a new project ----
cd projects/
uv init -n ai-agents
cd ai-agents

uv venv
uv add ruff # if not installed globally yet
uv lock


# 3. Run ruff ----
# Check for linting issues in the current directory
uv run ruff check --fix . # to auto-fix issues where possible
uv run ruff format . # to reformat code according to ruff's rules


# X. Update uv and ruff ----
uv self update
uv tool upgrade ruff


# References ----
# 1. https://docs.astral.sh/uv/getting-started/features/
# 2. https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff
# 3. https://pyrefly.org/en/docs/installation/
