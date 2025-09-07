#!/bin/bash

#
# Download and setup Ollama models for AI agents development
#

echo "🤖 Starting Ollama models download..."

# Wait for Ollama service to be ready
echo "⏳ Waiting for Ollama service to be ready..."
until curl -f http://localhost:11434/api/health >/dev/null 2>&1; do
    echo "   Waiting for Ollama..."
    sleep 5
done

echo "✅ Ollama service is ready!"

# Download models
echo "📥 Downloading models..."

# Core models for development
ollama pull llama3.2:latest
echo "✅ Downloaded llama3.2"

ollama pull deepseek-coder:latest
echo "✅ Downloaded deepseek-coder"

ollama pull codellama:7b
echo "✅ Downloaded codellama:7b"


echo "🎉 All models downloaded successfully!"

# List downloaded models
echo "📋 Available models:"
ollama list
