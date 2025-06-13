@echo off
echo -----------------------------------
echo 🚀 Lancement du setup Shortee
echo -----------------------------------

echo 🛠️  1. Construction des conteneurs...
docker compose up --build -d

echo 🕒 Attente 10s pour MySQL...
timeout /t 10 /nobreak > nul

echo 🧩  2. Migration de la base de données...
docker exec -it shortee node build/ace migration:run

echo 🌱  3. (Optionnel) Seed de données...
docker exec -it shortee node build/ace db:seed

echo ✅ Accède à l'application sur http://localhost:3333
