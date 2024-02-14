## Requirements

This application use a docker then if you don't have a docker desktop installed, you need a install this. For install follow this link and download it: [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Running local server

Once you have docker installed you have to follow the next steps:

1. Clone repository -> `git clone https://github.com/Coria97/Ecommerce_api.git`
2. Into to repository -> `cd .\ecommerce_api\`
3. Open docker desktop application
4. Run this command to start local server -> `docker compose up -d --build`
5. Install gems -> `docker compose run web bundle install`
6. Create database and run migrations -> `docker compose run web bundle exec rails db:create db:migrate `

## Services/Endpoints

All of service are in this postman collection -> [link to collection](https://www.postman.com/planetary-shuttle-304837/workspace/e-commerce/collection/23307208-095e54ea-c24c-4fc4-8625-f096c2954e07?action=share&creator=23307208)
