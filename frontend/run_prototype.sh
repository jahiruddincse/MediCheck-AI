#!/usr/bin/env bash
# Quick runner for MediCheck AI Prototype
PORT="${1:-8080}"
# If port is in use, fallback to 8081
if lsof -i :"$PORT" >/dev/null 2>&1; then
  PORT=8081
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROTOTYPE_DIR="$SCRIPT_DIR/prototype"

echo "======================================================="
echo "   🩺 MediCheck AI - Mobile Prototype Server"
echo "======================================================="
echo "Serving interactive prototype at: http://localhost:$PORT"
echo "URL: http://127.0.0.1:$PORT"
echo "Press Ctrl+C to stop."
echo "======================================================="

python3 -m http.server "$PORT" --directory "$PROTOTYPE_DIR"
