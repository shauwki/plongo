# Plongo - Home Automation & Personal Cloud

## Context
Welkom bij Plongo, jouw persoonlijke en self-hosted controlecentrum voor domotica en digitale diensten! Dit project is een geavanceerde Docker Compose-configuratie die een robuust ecosysteem van open-source applicaties orkestreert. Van huisautomatisering tot persoonlijke cloudopslag en mediastreaming, Plongo brengt al jouw favoriete diensten samen op één veilige en controleerbare plek.<br/>
In tegenstelling tot commerciële diensten biedt Plongo je volledige controle over je data en workflows, met een focus op privacy en flexibiliteit.

## Installatie

Om Plongo op te zetten na het clonen van de repository, volg je deze stappen:<br/>
1.  **Clone de repository:**
    ```bash
    git clone https://github.com/shauwki/plongo.git
    cd plongo
    ```
2.  **Maak de benodigde directories aan:**<br/>
    Deze mappen zullen dienen als persistente opslag voor de configuratie en data van je diensten.
    ```bash
    mkdir -p nextcloud/db nextcloud/html n8n/postgres_data n8n/n8n_config obsidian homeassistant mqtt/config mqtt/data mqtt/log jellyfin/config jellyfin/cache web/piksel/html web/plongo/html
    ```
3.  **Configureer je `.env` bestand:**<br/>
    Maak een nieuw bestand genaamd `.env` in de root van je project. Dit bestand bevat alle geheime en omgevingsvariabelen voor je diensten. Vul de waarden in met jouw gewenste gebruikersnamen, wachtwoorden en tokens. Een voorbeeld van de benodigde variabelen vind je hieronder:
    ```
    # Voor Nextcloud
    NEXTCLOUD_DB_NAME=nextcloud_db
    NEXTCLOUD_DB_USER=nextcloud_user
    NEXTCLOUD_DB_PASSWORD=jouw_nextcloud_db_wachtwoord

    # Voor n8n
    N8N_DB_NAME=n8n_db
    N8N_DB_USER=n8n_user
    N8N_DB_PASSWORD=jouw_n8n_db_wachtwoord
    N8N_BASIC_AUTH_USER=n8n_admin
    N8N_BASIC_AUTH_PASSWORD=jouw_n8n_wachtwoord
    N8N_URL=n8n.jouwdomein.nl # Of het IP-adres van je host als je geen domein gebruikt

    # Voor Jellyfin (optioneel, afhankelijk van je systeemgebruiker)
    PUID=1000 # Jouw user ID (vind met: id -u jouwgebruikersnaam)
    PGID=1000 # Jouw group ID (vind met: id -g jouwgebruikersnaam)
    TZ=Europe/Amsterdam # Jouw tijdzone

    # Voor Cloudflare Tunnel
    CLOUDFLARE_TUNNEL_TOKEN=jouw_cloudflare_tunnel_token

    # Voor MQTT (optioneel, als je PUID/PGID via environment variabelen wilt instellen)
    # PUID=${PUID}
    # PGID=${PGID}
    # TZ=${TZ}
    ```
4.  **Start alle services:**<br/>
    Met je `.env` bestand geconfigureerd, kun je Docker Compose de rest laten doen. De `-d` vlag zorgt ervoor dat de containers op de achtergrond draaien.
    ```bash
    docker compose up -d
    ```
    Na succesvolle installatie en start zijn al je services actief.

## Configuratie
De configuratie van je Plongo-setup is grotendeels gedefinieerd in het `docker-compose.yml` bestand en het `.env` bestand.<br/>
* **`.env` Bestand:** Dit is de centrale plek voor al je gevoelige informatie en omgevingsspecifieke instellingen. Zorg ervoor dat dit bestand **niet** wordt gecommit naar je Git-repository (het is al toegevoegd aan de `.gitignore`).<br/>
* **Volumemaps:** De meeste diensten gebruiken lokale mappen voor persistente opslag van data en configuratie (bijv. `./nextcloud/db`, `./n8n/postgres_data`, `./jellyfin/config`). Controleer en pas deze paden indien nodig aan, vooral voor grote mediabibliotheken zoals Jellyfin (`/mnt/4tb/services/jelly/shows` en `/mnt/4tb/services/jelly/movies`) of Nextcloud data (`/home/devki/Nextcloud/data`).<br/>
* **Cloudflare Tunnel:** Configureer je Cloudflare Tunnel via het Cloudflare dashboard om externe toegang tot je diensten te routeren. De `CLOUDFLARE_TUNNEL_TOKEN` in je `.env` is essentieel hiervoor.

## Usage

De `Plongo` setup biedt de volgende services:<br/>

### Home Assistant
Jouw centrale hub voor domotica, toegankelijk via de Cloudflare Tunnel.
* **Toegang:** Via de door jou geconfigureerde Cloudflare Tunnel.<br/>
* **Configuratie:** Sla je Home Assistant configuratie op in de `./homeassistant` map.
* **Health Check:** De `cloudflared` service wacht tot Home Assistant volledig is opgestart en gezond is voordat het de tunnel initieert.

### n8n
Een krachtige workflow-automatiseringstool. Creëer complexe integraties en automatiseringen die verder gaan dan je domotica.
* **Toegang:** Via de door jou geconfigureerde Cloudflare Tunnel (gebruik de `N8N_URL` uit je `.env` bestand).<br/>
* **Authenticatie:** Beveiligd met Basic Auth (gebruik `N8N_BASIC_AUTH_USER` en `N8N_BASIC_AUTH_PASSWORD` uit je `.env`).

### Nextcloud
Jouw persoonlijke cloudopslag, alternatief voor Dropbox/Google Drive.
* **Toegang:** Standaard toegankelijk op poort `8080` van je host (`http://localhost:8080`), tenzij je dit routeert via Cloudflare Tunnel.<br/>
* **Data:** Je Nextcloud data wordt opgeslagen in `/home/devki/Nextcloud/data` op je host. Pas dit pad aan naar jouw voorkeur.

### Obsidian (Notes)
Host je persoonlijke Obsidian notities.
* **Toegang:** Standaard toegankelijk op poort `5412` van je host (`http://localhost:5412`), tenzij gerouteerd via Cloudflare Tunnel.<br/>
* **Configuratie:** Je Obsidian vault bevindt zich in de `./obsidian` map.

### Jellyfin (Media Server)
Jouw persoonlijke mediastreamingplatform. Stream je films en series naar al je apparaten.
* **Toegang:** Standaard toegankelijk op poort `8096` van je host (`http://localhost:8096`), tenzij gerouteerd via Cloudflare Tunnel.<br/>
* **Mediabibliotheek:** Configureer de paden naar je films (`/mnt/4tb/services/jelly/movies`) en series (`/mnt/4tb/services/jelly/shows`) op je host. Pas deze aan naar je eigen opslaglocaties.

### MQTT Broker (Mosquitto)
De communicatiehub voor al je IoT-apparaten en Home Assistant.
* **Toegang:** Standaard toegankelijk op poort `1883` (standaard MQTT) en `9001` (WebSockets) van je host.

### PHP Webservers (`piksel`, `plongo`)
Twee aparte webservers voor het hosten van je websites of lokale applicaties.
* **Configuratie:** Plaats je webbestanden in `./web/piksel/html` en `./web/plongo/html`. Routering via Cloudflare Tunnel is vereist voor externe toegang.

### Cloudflare Tunnel
Beveiligt en routeert extern verkeer naar je intern gehoste services zonder poorten open te stellen. Dit is de aanbevolen methode voor veilige externe toegang.
* **Configuratie:** Vereist een `CLOUDFLARE_TUNNEL_TOKEN` in je `.env` bestand en verdere configuratie in het Cloudflare dashboard.

## Contact
Voor vragen, suggesties of opmerkingen kun je een e-mail sturen naar [alshauwki@gmail.com](mailto:alshauwki@gmail.com?subject=Plongo%20Setup&body=Hoi,%20).

## Mijn Setup
-   **CPU:** AMD Ryzen 7 1800X
-   **RAM:** 16.0 GB 3.60 GHz
-   **GPU:** NVIDIA GeForce GTX 1660 Ti (6 GB)
-   **OS:** x64-based processor (Ubuntu 24.04 LTS)

**Let op:** Het draaien van meerdere services kan aanzienlijke systeembronnen verbruiken. Zorg voor voldoende RAM, CPU-kracht en opslag. Overweeg een SSD voor de data-volumes van databases voor optimale prestaties.