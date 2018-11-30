# Dog Walking API

API para marcar e acompanhar passeios com pets :)

# O que foi utilizado
- Docker e docker-compose para criação do ambiente
- Simplecov para cobertura de testes
- Rubocop para auxilio à boas praticas
- PGSQL como banco de dados

## Subindo o ambiente
Para subir o ambiente de dev, basta construir-lo com o docker-compose. Para isso, entre na pasta do projeto e rode o seguinte comando
```sh
$ docker-compose build
```

Após rodar o comando e esperar o build, para acessar o container para rodar os testes, rode o seguinde comando
```sh
$ docker-compose run --rm web bash
```

Finalmente dentro do container, é possivel rodar o comando rspec para iniciar os testes

# Principais URLs

  - GET /api/v1/pets - Busca todos os pets cadastrados(sem params)
  - POST /api/v1/pets - Cadastra um pet (params: 'name' e 'age')
  - GET /api/v1/dog_walkings - Busca todos os passeios cadastrados (sem parametro)
  - GET /api/v1/dog_walkings?filter=future - Busca todos os passeios futuros (param filter)
  - POST /api/v1/dog_walkings Cadastra um novo passeio (params: schedule_date: datetime, price: float, duration: string ('thirty_minutes', 'sixty_minutes'), pet_ids: [])
  - PUT /api/v1/dog_walkings/:dog_walking_id/start_walk Inicia um passeio (params: dog_walking_id - id do passeio)
  - PUT /api/v1/dog_walkings/:dog_walking_id/finish_walk Termina um passeio (params: dog_walking_id - id do passeio)
  - GET /api/v1/dog_walkings/:dog_walking_id/dog_walking_positions Retorna todas as posições de um passeio ( params: dog_walking_id - id do passeio)
  - POST /api/v1/dog_walkings/:dog_walking_id/dog_walking_positions Cria uma posição para o passeio ( params: dog_walking_id: integer, latitude: float, longitude float)

# TODO
- Paginação dos resultados da API
- Implementação de algum esquema de segurança para consulta a API (TOken ou Autenticação)
