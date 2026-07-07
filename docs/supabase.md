# Supabase - Guia de Setup

## 1. Criar projeto
- Crie um projeto no Supabase.
- Copie a string de conexao Postgres (Transaction Pooler recomendado para backend).

## 2. Configurar backend
- Copie `backend/.env.example` para `backend/.env`.
- Defina `DATABASE_URL` com a conexao do Supabase.
- Defina `DB_SSL=true`.

Opcao recomendada no Windows (interativa):
- Em `backend/`, execute `npm run env:setup` e preencha os campos.

Exemplo:

```env
DATABASE_URL=postgresql://postgres.xxxxx:[SENHA]@aws-0-us-east-1.pooler.supabase.com:6543/postgres
DB_SSL=true
```

## 3. Aplicar schema
- Rode em `backend/`:
  - `npm install`
  - `npm run db:bootstrap`

## 4. SQL Editor (alternativo)
- Tambem e possivel executar as migrations no SQL Editor do Supabase usando os arquivos em `supabase/migrations/`.

## 5. Seguranca
- Use senha forte para admin inicial.
- Nao compartilhe `DATABASE_URL`.
- Em producao, troque `JWT_SECRET`.
