# API - Madu Gate

Base URL (local): http://localhost:3000

## Auth
- POST /auth/login
- POST /auth/refresh

## Usuarios
- GET /users
- POST /users

## Acesso
- POST /access/open
- GET /access/history

## Visitantes
- GET /visitors
- POST /visitors

## Veiculos
- GET /vehicles
- POST /vehicles

## Codigos esperados
- 200, 201, 400, 401, 403, 404, 409, 429, 500

## Exemplo - Login
Request:
```json
{
  "email": "admin@madu.local",
  "password": "123456"
}
```
Response:
```json
{
  "accessToken": "jwt",
  "refreshToken": "jwt"
}
```
