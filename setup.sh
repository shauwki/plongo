#!/bin/bash
# Dit script bereidt de host-omgeving voor op het draaien van de Plongo Docker stack.

# Stop on first error
set -e

echo "--- Plongo Setup Script ---"

echo "[1/x] Benodigde mappen aanmaken..."
mkdir -p ./n8n/n8n_config
mkdir -p ./n8n/postgres_data
mkdir -p ./web/html
# Voeg hier later andere mappen toe, zoals ./jellyfin/config etc.

echo "[2/x] Correcte permissies instellen voor n8n..."
# De n8n container draait als user 1000. We maken de host-map eigenaar van user 1000.
sudo chown -R 1000:1000 ./n8n

# --- Stap 2: .env bestand aanmaken ---
echo "[3/x] Controleren op .env bestand..."
if [ ! -f ./.env ]; then
    echo "-> .env bestand niet gevonden. Aanmaken vanuit .env.example..."
    cp .env.example .env
    echo "BELANGRIJK: Open het '.env' bestand en vul je eigen tokens en domeinen in!"
else
    echo "-> .env bestand al aanwezig."
fi

# echo "[4/x] web omgeving"
# WEB_FILES="./web/Dockerfile"
# if [ ! -f "$WEB_FILES" ]; then
#     echo "-> web files instellen..."
#     cat > "$WEB_FILES" << EOL
# FROM php:8.2-apache
# RUN apt-get update && apt-get install -y libpq-dev libmariadb-dev && docker-php-ext-install pdo pdo_mysql pdo_pgsql
# RUN apt-get install -y vim
# EOL
# else
#     echo "-> Dockerfile al gevonden."
# fi

# echo "-> [5/x] Controleren op standaard index.php..."
# WEB_INDEX_FILE="./web/html/index.php"
# if [ ! -f "$WEB_INDEX_FILE" ]; then
#     echo "-> index.php niet gevonden. Standaard welkomstpagina wordt aangemaakt..."
#     # Gebruik 'EOL' met aanhalingstekens om te voorkomen dat de shell '$' interpreteert
#     cat > "$WEB_INDEX_FILE" << 'EOL'
# <!DOCTYPE html>
# <html lang="nl">
# <head>
#     <meta charset="UTF-8">
#     <meta name="viewport" content="width=device-width, initial-scale=1.0">
#     <title>Plongo is Live!</title>
#     <script src="https://cdn.tailwindcss.com"></script>
#     <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
#     <style>
#         body { font-family: 'Inter', sans-serif; }
#     </style>
# </head>
# <body class="bg-gray-900 text-white flex items-center justify-center min-h-screen">
#     <div class="text-center p-8 bg-gray-800 rounded-xl shadow-2xl max-w-lg mx-auto border border-gray-700">
#         <svg class="mx-auto h-16 w-16 text-blue-400 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
#             <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h14M5 12a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v4a2 2 0 01-2 2M5 12a2 2 0 00-2 2v4a2 2 0 002 2h14a2 2 0 002-2v-4a2 2 0 00-2-2m-2-4h.01M17 16h.01" />
#         </svg>
#         <h1 class="text-4xl font-bold text-white mb-2">Plongo Webserver is Actief</h1>
#         <p class="text-gray-400 mb-6">Je PHP-Apache container is succesvol geconfigureerd en draait naar behoren.</p>
#         <div class="bg-gray-700 rounded-lg p-4 text-left">
#             <p class="text-sm text-gray-300">De bestanden voor deze site bevinden zich op je computer in de <code class="bg-gray-600 text-blue-300 px-2 py-1 rounded-md text-xs">./web/html</code> map.</p>
#             <p class="text-sm text-gray-300 mt-2">PHP Versie: <span class="font-mono text-green-400"><?php echo phpversion(); ?></span></p>
#         </div>
#     </div>
# </body>
# </html>
# EOL
# else
#     echo "-> index.php al aanwezig, wordt niet overschreven."
# fi

echo ""
echo "--- ✅ Setup voltooid! ---"
echo "Je kunt de services nu starten met: docker compose up -d"
echo ""
