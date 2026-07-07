# Changelog

Todas as mudancas relevantes deste projeto serao documentadas neste arquivo.

## [0.5.0] - 2026-07-07
### Alterado
- Stack oficial consolidada: Flutter, Node.js + Express, PostgreSQL (Supabase), ESP32, JWT e bcrypt.
- Arquitetura de referencia documentada do app ate acionamento fisico (rele e central).
- Diretrizes de seguranca expandidas com HTTPS, mitigacao de forca bruta e politica de expiracao de tokens.
- Principios de evolucao formalizados para crescimento sem troca de base.

## [0.1.0] - 2026-07-06
### Adicionado
- Definicao oficial da marca Madu Gate e slogan.
- Estrutura inicial de pastas do monorepo.
- Documentacao base: README, project, architecture e AGENTS.
- Especificacao inicial em specs/000-madu-gate-foundation.

## [0.2.0] - 2026-07-06
### Adicionado
- Backend base com Express, middleware de seguranca e tratamento de erros.
- Rotas de autenticacao (`/auth/login`, `/auth/refresh`).
- Rotas de usuarios (`/users`) com controle por papel.
- Rotas de acesso (`/access/open`, `/access/history`) com registro de eventos.
- Servicos com consultas parametrizadas e transacao no fluxo de abertura.
- Migration inicial PostgreSQL em `database/migrations/001_initial.sql`.
- Seed inicial de portoes em `database/scripts/seed.sql`.
- App Flutter base com login, acionamento e historico.

## [0.3.0] - 2026-07-06
### Adicionado
- Rotas e servicos de visitantes (`/visitors`) e veiculos (`/vehicles`).
- Migration `002_visitors_vehicles.sql` para expansao de dominio.
- Script `db:setup` para aplicar migrations 001 e 002 em sequencia.
- `docker-compose.yml` com PostgreSQL e backend para operacao local.
- Ambiente `backend/.env.docker` para execucao em containers.

### Alterado
- Dependencia `bcrypt` atualizada para 6.x para remocao de vulnerabilidades altas.

## [0.4.0] - 2026-07-06
### Adicionado
- Guia de setup Supabase em `docs/supabase.md`.
- Migrations espelhadas para `supabase/migrations/`.
- Script `db:seed:admin` para provisionar admin inicial.
- Script `db:bootstrap` para preparar banco completo em uma etapa.

### Alterado
- Conexao `pg` com suporte a SSL por variavel (`DB_SSL`).
- `.env.example` atualizado para padrao Supabase.
