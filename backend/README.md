# Introdução Microserviço

Microserviço criado utilizando Python e configurado para suportar Docker. 

Nesse ambiente também há um banco de dados utilizando NoSQL (MongoDB) e a documentação completa com  exemplos de requisição e dados necessários para chamar a API. 

O microserviço criado nesse projeto faz parte do Desafio Microservice da Fase 5 do MBA em Engenharia de Software da FIAP criado para suportar um conceito de uma nova funcionalidade que permite o usuário criar um cartão de crédito temporário com um valor pré-estabelecido e emprestar a qualquer pessoa através do aplicativo oficial da Nubank que é uma Fintech pioneira no segmento financeiro no Brasil, que inovou com seu cartão de crédito sem anuidade e outros serviços financeiros.

# Como executar (passo a passo)

Este projeto possui Docker configurado, para executá-lo você vai precisar do [Docker](https://www.docker.com/) instalado.

Após clonar o projeto em seu ambiente de desenvolvimento execute o comando abaixo para entrar no diretório do projeto:

``` cd backend ```

Agora que está no diretório correto, você deve executar o comando abaixo para montar o ambiente docker em seu computador:

``` docker build --pull --rm -f "backend\Dockerfile" -t desafiomicroservices:latest "backend" ```

Quando a etapa anterior for finalizada, execute o comando a seguir para iniciar o ambiente de desenvolvimento local:

``` docker-compose  -f "backend\docker-compose.yml" up -d --build web mongo  ```

Se tudo ocorreu bem você pode navegar para o endereço abaixo no seu navegador, onde será possível acessar a documentação e os exemplos da API:

[http://localhost:5000/](http://localhost:5000/)

# Documentação Open API

A documentação da API pode ser acessada localmente de forma direta quando o ambiente Docker estiver online através do endereço: 

[http://localhost:5000/static/api/index.html](http://localhost:5000/static/api/index.html)

Para atualizar a documentação, edite o arquivo:

```openapi.yml```

Em seguida execute o comando abaixo no terminal (é necessário ter o [NodeJS](https://nodejs.org/en/) instalado):

```bootprint openapi openapi.yml static/api```

# Arquitetura

![Microservice Architecture](https://github.com/fase-5-grupo-h/desafio-microservices/blob/main/backend/static/architecture.jpg?raw=true)
