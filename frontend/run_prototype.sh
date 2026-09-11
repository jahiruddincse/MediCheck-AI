#!/usr/bin/env bash
# Quick runner for MediCheck AI Prototype
PORT=8080
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROTOTYPE_DIR="$SCRIPT_DIR/prototype"

echo "======================================================="
echo "   🩺 MediCheck AI - Mobile Prototype Server"
echo "======================================================="
echo "Serving interactive prototype at: http://localhost:$PORT"
echo "Press Ctrl+C to stop."
echo "======================================================="

python3 -m http.server "$PORT" --directory "$PROTOTYPE_DIR"
