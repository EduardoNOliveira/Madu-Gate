# INSTALL - Madu Gate

## Requisitos
- Node.js 20+
- PostgreSQL/Supabase
- Flutter SDK (opcional para mobile)
- Git

## Backend
1. Entrar em backend/
2. Copiar .env.example para .env
3. Instalar dependencias: npm install
4. Rodar API: npm run dev (ou npm start)

## Banco
1. Aplicar migrations em database/migrations/
2. Opcional: aplicar database/schema.sql
3. Opcional: popular com database/seed.sql

## Mobile
1. Entrar em mobile/
2. flutter pub get
3. flutter run

## ESP32
1. Abrir esp32/firmware/
2. Configurar credenciais via variaveis seguras
3. Seguir plano OTA em esp32/firmware/OTA/README.md
