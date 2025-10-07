-- Maak een aparte gebruiker en database voor n8n
CREATE USER n8n_user WITH PASSWORD 'dE3bK432mQsas7tT9K2vF';
CREATE DATABASE n8n_db;
GRANT ALL PRIVILEGES ON DATABASE n8n_db TO n8n_user;
ALTER DATABASE n8n_db OWNER TO n8n_user;

-- Maak een aparte gebruiker en database voor Nextcloud
CREATE USER nextcloud_user WITH PASSWORD 'dE3bK2mQ7tT9K2vF';
CREATE DATABASE nextcloud_db;
GRANT ALL PRIVILEGES ON DATABASE nextcloud_db TO nextcloud_user;
ALTER DATABASE nextcloud_db OWNER TO nextcloud_user;

-- Maak een aparte gebruiker en database voor AI Agents
CREATE USER ai_agents_user WITH PASSWORD '2mdET9K2vFQ7tT9KbKdE32mQ';
CREATE DATABASE ai_agents_db;
GRANT ALL PRIVILEGES ON DATABASE ai_agents_db TO ai_agents_user;
ALTER DATABASE ai_agents_db OWNER TO ai_agents_user;

-- Maak de database voor je custom familie-geheugen aan
CREATE DATABASE fam_memory_db;
GRANT ALL PRIVILEGES ON DATABASE fam_memory_db TO plongo_user;