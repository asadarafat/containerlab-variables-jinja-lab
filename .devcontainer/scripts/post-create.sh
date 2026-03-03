#!/usr/bin/env bash
set -euo pipefail

mkdir -p /workspaces/.clab
bash .devcontainer/scripts/start-docker.sh || true

echo "[devcontainer] tool check"
containerlab version | head -n 1
jinja2 --version
python3 --version
docker --version
docker compose version || true

if ! docker info >/dev/null 2>&1; then
  echo "[devcontainer] warning: docker daemon is not ready yet; run: bash .devcontainer/scripts/start-docker.sh" >&2
else
  echo "[devcontainer] docker storage driver: $(docker info --format '{{.Driver}}')"
fi
