#!/bin/bash

#
# Install `uv` and `ruff` for Python development
#

# 0. Install uv ----
curl -LsSf https://astral.sh/uv/install.sh | sh
uv --version

uv self update

#
uv python install 3.12
uv python list 3.12
echo 'import platform; print(platform.python_version())' | uv run -

uv python upgrade 3.12

#
uv venv


# 1. Install ruff ----
uv tool install ruff
ruff --version

uv tool upgrade ruff

# 2. Configure ruff for Python projects ----
mkdir -p ~/.config/ruff
cat <<EOF > ~/.config/ruff/config.toml
[tool.ruff]
line-length = 88
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

# 3. Create uv virtual environment for Ruff ----
cd apps/
uv init ds-agents
cd ds-agents

uv add ruff
uv lock




# References ----
# 1. https://docs.astral.sh/uv/
# 2. https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff
