# Tasks - Spec 001

## Fase 1 - Arquitetura e Organizacao
- [ ] Formalizar estrutura final do monorepo (app, backend, esp32, database, docs, assets, logo).
- [ ] Definir convencoes de nomes, pastas e ownership tecnico.
- [ ] Definir estrategia de ambiente (local, homologacao e producao).

## Fase 2 - Banco de Dados
- [ ] Validar entidades base: usuarios, dispositivos, acessos e veiculos.
- [ ] Definir constraints, indices e politica de integridade.
- [ ] Consolidar migrations e seeds base para ambientes.

## Fase 3 - API
- [x] Definir contrato inicial de endpoints por modulo.
- [x] Definir padrao de autenticacao, autorizacao e erros.
- [x] Definir politicas de seguranca de auth (rate limit e bloqueio progressivo).

## Fase 4 - App Mobile
- [ ] Definir mapa de telas v1.
- [ ] Definir fluxo de autenticacao e sessao.
- [ ] Definir fluxo principal de abertura e historico.

## Fase 5 - ESP32
- [ ] Definir protocolo de comunicacao inicial com a API.
- [ ] Definir estrategia de autenticacao do dispositivo.
- [ ] Definir payloads de comando e resposta.

## Fase 6 - Design System
- [ ] Definir tokens de cor, tipografia e espacamento da Madu Informatica.
- [ ] Definir componentes base e estados de interacao.
- [ ] Definir padroes de acessibilidade e responsividade.

## Fase 7 - Governanca e Release
- [ ] Estruturar board no GitHub Projects.
- [ ] Definir padrao de branches e PR templates.
- [ ] Definir trilha de versoes: v0.1 a v1.0.
