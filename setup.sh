#!/bin/bash

set -e

echo "--- Plongo Setup Script ---"
echo "[1/x] Benodigde mappen aanmaken..."
mkdir -p ./n8n/n8n_config
mkdir -p ./n8n/postgres_data
mkdir -p ./web/html

echo "[2/x] Correcte permissies instellen voor n8n..."
sudo chown -R 1000:1000 ./n8n

echo "[3/x] Controleren op .env bestand..."
if [ ! -f ./.env ]; then
    echo "-> .env bestand niet gevonden. Aanmaken vanuit .env.example..."
    cp .env.example .env
    echo "BELANGRIJK: Open het '.env' bestand en vul je eigen tokens en domeinen in!"
else
    echo "-> .env bestand al aanwezig."
fi

echo ""
echo "--- ✅ Setup voltooid! ---"
echo "Je kunt de services nu starten met: docker compose up -d"
echo ""
