# Plano - Spec 001

## Objetivo
Estabelecer a base arquitetural definitiva do Madu Gate antes da evolucao de funcionalidades.

## Estrategia
1. Consolidar arquitetura de referencia ponta a ponta.
2. Congelar estrutura do monorepo e convencoes de organizacao.
3. Definir modelo de dados base e contratos de API.
4. Definir mapa de telas e fluxo mobile principal.
5. Definir protocolo inicial de comunicacao com ESP32.
6. Definir Design System inicial da Madu Informatica.
7. Definir governanca de desenvolvimento no GitHub.

## Arquitetura de Referencia
- iPhone/Android -> Flutter -> Node.js API -> PostgreSQL (Supabase) -> ESP32 -> Rele -> Central RCG

## Padroes Tecnicos
- App: Flutter
- API: Node.js + Express
- Banco: PostgreSQL (Supabase/Neon)
- Firmware: ESP32
- Seguranca: JWT + bcrypt + validacao + logs
- Deploy inicial API: Render
- Versionamento: GitHub com workflow profissional

## Governanca GitHub
- Branches: main, develop, feature/*
- Fluxo: feature -> PR -> develop -> release -> main
- Gestao: Issues + Projects (Kanban)
- Releases: tags semanticas por marco de versao

## Entregas Incrementais
- E1: Documento de arquitetura e convencoes aprovado.
- E2: Modelo de dados e scripts SQL base aprovados.
- E3: Contrato de endpoints v1 aprovado.
- E4: Fluxos de telas v1 aprovados.
- E5: Protocolo API/ESP32 v1 aprovado.
- E6: Design System v1 aprovado.

## Riscos e Mitigacoes
- Risco: Definicoes muito amplas sem priorizacao.
- Mitigacao: roadmap por fases e escopo fechado por release.
- Risco: divergencia entre documentacao e codigo.
- Mitigacao: PRs obrigatorios atualizando docs tecnicos.
