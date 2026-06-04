#!/bin/bash
set -e

#
# Download and setup Ollama models for AI agents development
#

echo "🤖 Starting Ollama models download..."

# Wait for Ollama HTTP API to be ready
echo "⏳ Waiting for Ollama service to be ready..."
until OLLAMA_HOST="${OLLAMA_HOST:-http://localhost:11434}" ollama list >/dev/null 2>&1; do
    echo "   Waiting for Ollama..."
    sleep 3
done

echo "✅ Ollama service is ready!"

# Download models
echo "📥 Downloading models..."

ollama pull qwen3-coder:30b
echo "✅ Downloaded qwen3-coder:30b"

# Create custom coding-optimised model variant
ollama create qwen3-datascientist -f /Modelfile
echo "✅ Created qwen3-datascientist"


echo "🎉 All models downloaded successfully!"

# List downloaded models
echo "📋 Available models:"
ollama list
