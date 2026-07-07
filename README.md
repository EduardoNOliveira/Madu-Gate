# Madu Gate

Controle inteligente de acesso.

## Visao Geral
Madu Gate e uma plataforma segura, moderna e intuitiva para controle de acesso em residencias, condominios, empresas, instituicoes e estacionamentos.

## Missao
Oferecer uma plataforma segura, moderna e intuitiva para controle de acesso de residencias, condominios, empresas e instituicoes.

## Segmentos Atendidos

### Residencial
- Abertura de portao via celular.
- Compartilhamento de acesso com familiares.
- Historico de aberturas.
- Notificacoes em tempo real.

### Empresarial
- Controle de funcionarios.
- Controle de visitantes.
- Relatorios gerenciais.

### Estacionamentos
- Reconhecimento de placas (fase futura).
- Cadastro de veiculos.
- Controle de vagas.
- Estatisticas de uso.

### Universidades (UFBA)
- Controle de acesso para alunos.
- Controle de acesso para professores.
- Controle de acesso para servidores.
- Controle de acesso para visitantes.
- Integracao com multiplas cancelas.

## Tecnologias
- Flutter.
- Node.js + Express.
- PostgreSQL (Supabase).
- ESP32.
- JWT.
- bcrypt.
- GitHub Actions (CI/CD).
- OpenCV + YOLO + EasyOCR (fase futura).
- Docker (fase futura).

## Stack Padrao Oficial
- Flutter (Android e iPhone).
- Node.js + Express.
- Supabase (PostgreSQL).
- ESP32.
- JWT + bcrypt.
- GitHub para versionamento.
- Render (ou equivalente) para hospedagem futura da API.

## Arquitetura de Referencia
- iPhone / Android -> Flutter -> Node.js API -> PostgreSQL (Supabase) -> ESP32 -> Rele -> Central RCG.

## Seguranca
- Senhas com bcrypt.
- Autenticacao com JWT.
- Comunicacao HTTPS.
- Validacao de dados na API.
- Registro de logs e auditoria.
- Mitigacao de forca bruta.
- Tokens com expiracao.

## Identidade Visual
- Azul Madu Primario: #44469B.
- Azul Madu Secundario: #1AA6DE.
- Branco: #FFFFFF (simplicidade).
- Referencia de marca: `docs/brand-guidelines.md`.

## Repositorio Oficial
- https://github.com/EduardoNOliveira/Madu-Gate

## Estrutura de Pastas
```text
Madu-Gate/
  app/
    android/
    ios/
    lib/
    assets/
  backend/
    api/
    controllers/
    middleware/
    routes/
    services/
  esp32/
    firmware/
    ota/
  database/
    migrations/
    scripts/
    schema.sql
    seed.sql
  assets/
    images/
    icons/
    logo/
  logo/
  .github/
    workflows/
  supabase/
    migrations/
  docs/
  specs/
    000-madu-gate-foundation/
      spec.md
      plan.md
      tasks.md
  AGENTS.md
  project.md
  architecture.md
  CHANGELOG.md
  LICENSE
  README.md
```

## Funcionalidades da Versao 1.0
- Login com e-mail e senha.
- Abertura do portao pelo celular.
- Historico de acessos.
- Cadastro de usuarios.
- Configuracao do ESP32.
- Painel administrativo web.

## Status Atual de Implementacao
- Backend inicial criado com Node.js + Express.
- Autenticacao JWT com login e refresh token.
- Rotas de usuarios e acessos com validacao de entrada.
- Rotas de visitantes e veiculos para operacao empresarial/estacionamento.
- Migration inicial PostgreSQL para usuarios, portoes, eventos e refresh tokens.
- Migration complementar para visitantes e veiculos.
- Conexao pronta para Supabase (Postgres com SSL).
- Bootstrap de banco e seed de admin disponiveis via script.
- Base do app Flutter com fluxo de login, abertura e historico.

## Como Rodar (Base Atual)

### Backend
1. Copie `backend/.env.example` para `backend/.env` e ajuste credenciais.
2. Execute `npm install` em `backend/`.
3. Configure `DATABASE_URL` do Supabase e `DB_SSL=true`.
4. Execute `npm run db:bootstrap` em `backend/`.
5. Execute `npm run dev` em `backend/`.

### Banco de Dados
- Migration principal: `database/migrations/001_initial.sql`.
- Migration complementar: `database/migrations/002_visitors_vehicles.sql`.
- Seed inicial opcional: `database/scripts/seed.sql`.
- Migrations para SQL Editor/CLI do Supabase: `supabase/migrations/`.

### Supabase
- Guia detalhado: `docs/supabase.md`.
- Variaveis de admin: `ADMIN_NAME`, `ADMIN_EMAIL`, `ADMIN_PASSWORD`.

### Docker Compose (opcional)
- Arquivo: `docker-compose.yml`.
- Ambiente de container: `backend/.env.docker`.
- Comando esperado: `docker compose up -d` (se Docker estiver instalado).

### App Flutter
1. Em `app/`, execute `puro flutter pub get`.
2. Inicie com `puro flutter run`.
3. O app usa `http://10.0.2.2:3000` como URL base para Android emulator.

## Endpoints Principais (V1)
- `POST /auth/login`
- `POST /auth/refresh`
- `GET /users` (admin)
- `POST /users` (admin)
- `POST /access/open`
- `GET /access/history` (admin/employee)
- `GET /visitors` (admin/employee)
- `POST /visitors` (admin/employee)
- `GET /vehicles` (admin/employee)
- `POST /vehicles` (admin/employee)

## Roadmap

### Madu Gate 1.0
- Controle do portao via aplicativo.

### Madu Gate 2.0
- Controle remoto pela internet.

### Madu Gate 3.0
- Suporte a multiplos portoes.

### Madu Gate 4.0
- Reconhecimento de placas.

### Madu Gate 5.0
- Integracao com Apple Watch, Android Auto e CarPlay.
