# API v1 - Contrato Inicial

## Base URL
- Local: http://localhost:3000
- Homolog/Prod: definir por ambiente

## Convencoes Gerais
- Content-Type: application/json
- Autenticacao: Bearer token JWT no header Authorization
- Erro padrao: { "error": "mensagem" }
- Sucesso: codigo HTTP + payload JSON
- Protecao de auth: rate limit de login por IP + bloqueio progressivo por IP/e-mail

Exemplo de header:
Authorization: Bearer <access_token>

## Health

### GET /health
- Auth: nao
- 200: { "status": "ok", "service": "madu-gate-backend" }

## Auth

### POST /auth/login
- Auth: nao
- Body:
{
  "email": "admin@madugate.com",
  "password": "123456"
}
- 200: sessao com access token e refresh token
- 401: credenciais invalidas
- 429: limite excedido ou login temporariamente bloqueado
- 422: validacao de entrada

### POST /auth/refresh
- Auth: nao
- Body:
{
  "refreshToken": "<refresh_token>"
}
- 200: novo access token e refresh token
- 401: refresh token invalido/expirado
- 422: validacao de entrada

## Users

### GET /users
- Auth: sim (admin)
- 200: lista de usuarios
- 403: sem permissao

### POST /users
- Auth: sim (admin)
- Body:
{
  "name": "Maria Silva",
  "email": "maria@madugate.com",
  "password": "123456",
  "role": "resident"
}
- role permitido: admin | resident | employee | visitor
- 201: usuario criado
- 409: e-mail ja cadastrado
- 422: validacao de entrada

## Access

### POST /access/open
- Auth: sim
- Body:
{
  "gateId": 1,
  "source": "mobile"
}
- source permitido: mobile | web | esp32
- 200: evento de acesso registrado
- 422: validacao de entrada

### GET /access/history?limit=50&offset=0
- Auth: sim (admin, employee)
- 200: lista paginada de eventos de acesso
- 403: sem permissao
- 422: validacao de query

## Visitors

### GET /visitors
- Auth: sim (admin, employee)
- 200: lista de visitantes

### POST /visitors
- Auth: sim (admin, employee)
- Body:
{
  "name": "Visitante Teste",
  "document": "12345678901",
  "phone": "71999999999"
}
- 201: visitante criado
- 422: validacao de entrada

## Vehicles

### GET /vehicles
- Auth: sim (admin, employee)
- 200: lista de veiculos

### POST /vehicles
- Auth: sim (admin, employee)
- Body:
{
  "plate": "ABC1D23",
  "model": "Corolla",
  "color": "Prata",
  "ownerName": "Joao Silva"
}
- Regra da placa: padrao Mercosul (ex.: ABC1D23)
- 201: veiculo criado
- 409: placa ja cadastrada
- 422: validacao de entrada

## Codigos HTTP de Referencia
- 200: sucesso
- 201: criado
- 401: nao autenticado
- 403: nao autorizado
- 404: rota nao encontrada
- 409: conflito de unicidade
- 429: muitas requisicoes / bloqueio temporario
- 422: erro de validacao
- 500: erro interno

## Escopo v1 (Atual)
- Endpoints implementados: health, auth, users, access, visitors, vehicles
- Endpoints de devices/esp32: planejados para proxima fase
