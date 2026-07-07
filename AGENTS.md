# AGENTS

## Objetivo
Definir papeis e responsabilidades de agentes no ecossistema Madu Gate para manter previsibilidade de entrega e qualidade tecnica.

## Papeis Iniciais
- Product Agent: detalha requisitos, regras e priorizacao.
- Backend Agent: implementa API, servicos, autenticacao e integracoes.
- Mobile Agent: implementa telas e fluxos no app Flutter.
- Firmware Agent: implementa comunicacao e acionamento no ESP32.
- Data Agent: modela dados, migracoes e estrategia de auditoria.
- QA Agent: define cenarios e valida requisitos funcionais e nao funcionais.

## Regras de Colaboracao
- Todo desenvolvimento deve estar vinculado a uma especificacao em specs/.
- Mudancas de escopo precisam atualizar spec.md, plan.md e tasks.md.
- Entregas devem priorizar seguranca, rastreabilidade e simplicidade operacional.
