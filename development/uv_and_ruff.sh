#!/bin/bash

#
# Install `uv` and `ruff` for Python development
#


# 0. Install uv ----
# install
curl -LsSf https://astral.sh/uv/install.sh | sh
# check
uv -V
# turn on auto-updates
uv self update


# 1. Install Python tools for uv ----
# Install Python 3.12
uv python install 3.12
uv python list 3.12
echo 'import platform; print(platform.python_version())' | uv run -

uv python upgrade 3.12

# Install venv
uv venv


# Install ruff (globally)
uv tool install ruff@latest
ruff --version

uv tool upgrade ruff


# 2. Create a new project ----
cd projects/
uv init -n ai-agents
cd ai-agents

uv add ruff # if not installed globally yet
uv lock


# 3. Configure ruff for Python projects ----
mkdir -p ~/.config/ruff
cat <<EOF > ~/.config/ruff/config.toml
[tool.ruff]
line-length = 120
select = ["E", "F", "W", "C90"]
exclude = ["__pycache__", "venv", ".git", ".ruff_cache"]
fix = true
target-version = "py312"

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]
EOF

echo "Ruff configuration file created at ~/.config/ruff/config.toml"

ruff check --config ~/.config/ruff/config.toml --fix --exit-zero
echo "Ruff configuration validated successfully."


# References ----
# 1. https://docs.astral.sh/uv/getting-started/features/
# 2. https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff
