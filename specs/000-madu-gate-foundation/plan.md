# Plano - Spec 000

## Objetivo
Transformar a definicao de produto do Madu Gate em base executavel para desenvolvimento da V1.

## Estrategia
1. Estabelecer contratos iniciais entre app, backend e ESP32.
2. Implementar autenticacao e controle de acesso auditavel no backend.
3. Construir fluxo mobile para login, abertura e historico.
4. Definir padrao de persistencia e migracoes no PostgreSQL.
5. Garantir rastreabilidade por logs de eventos de acesso.
6. Preservar compatibilidade para expansao (multiplos portoes, fechaduras, cameras e placas) sem trocar arquitetura base.

## Tecnologias
- Flutter para aplicativo mobile.
- Node.js + Express para API e painel administrativo.
- Supabase (PostgreSQL) para persistencia relacional.
- JWT para autenticacao e autorizacao.
- bcrypt para hash de senhas.
- ESP32 para camada embarcada.
- GitHub para versionamento.
- Render (ou equivalente) para deploy futuro da API.

## Arquitetura de Referencia
- iPhone/Android -> Flutter -> Node.js API -> PostgreSQL (Supabase) -> ESP32 -> Rele -> Central RCG.

## Baseline de Seguranca (V1)
- Senhas com bcrypt.
- JWT com expiracao e refresh controlado.
- HTTPS em ambientes externos.
- Validacao de dados no backend.
- Logs e auditoria de eventos sensiveis.
- Mitigacao de forca bruta em login.

## Entregas Incrementais
- E1: Base do repositorio e documentacao.
- E2: Backend minimo (auth + acessos + usuarios).
- E3: App minimo (login + abrir portao + historico).
- E4: Firmware minimo (comando autenticado e acionamento).
- E5: Hardening, testes e preparacao de release 1.0.

## Criterios de Pronto
- Fluxo ponta a ponta funcional: login -> abrir portao -> registrar evento.
- Historico disponivel no app e no painel.
- Usuarios e perfis gerenciaveis via painel administrativo.
- Documentacao minima de execucao local para app, backend e firmware.
- Base pronta para escalabilidade sem reestruturacao arquitetural.
