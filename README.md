Install docker và docker compose
docker-compose build
docker-compose up -d
docker-compose  run web rails db:create
docker-compose  run web rails db:migrate
