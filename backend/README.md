# Introdução Microserviço

texto

# Como executar (passo a passo)

docker-compose  -f "backend\docker-compose.yml" up -d --build web mongo

docker build --pull --rm -f "backend\Dockerfile" -t desafiomicroservices:latest "backend"

endpoints

http://localhost:5000/api/clientes

# Documentação Open API

bootprint openapi openapi.yml static/api

# Arquitetura

![alt text](https://raw.githubusercontent.com/fase-5-grupo-h/desafio-microservices/main/backend/static/architecture.jpg?raw=true)

