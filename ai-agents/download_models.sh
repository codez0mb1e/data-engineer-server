#!/bin/bash
set -e

#
# Download and setup Ollama models for AI agents development
#

echo "🤖 Starting Ollama models download..."

# Wait for Ollama HTTP API to be ready
echo "⏳ Waiting for Ollama service to be ready..."
until curl -sf "${OLLAMA_HOST:-http://localhost:11434}/api/tags" >/dev/null; do
    echo "   Waiting for Ollama..."
    sleep 3
done

echo "✅ Ollama service is ready!"

# Download models
echo "📥 Downloading models..."

# Core models for development
ollama pull llama3.2:3b
echo "✅ Downloaded llama3.2"

ollama pull deepseek-r1:14b
echo "✅ Downloaded deepseek-r1:14b"

ollama pull deepseek-coder:6.7b
echo "✅ Downloaded deepseek-coder"


echo "🎉 All models downloaded successfully!"

# List downloaded models
echo "📋 Available models:"
ollama list
