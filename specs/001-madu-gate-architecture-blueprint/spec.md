# Spec 001 - Blueprint de Arquitetura do Madu Gate

## Contexto
O projeto Madu Gate ja possui base inicial de app, backend, banco e firmware. Para evitar retrabalho e escalar com consistencia, esta spec formaliza a arquitetura alvo antes da evolucao de funcionalidades.

## Objetivo
Definir o blueprint oficial do Madu Gate com foco em escalabilidade, seguranca e organizacao profissional de engenharia.

## Escopo
- Definir estrutura oficial do repositorio monorepo MaduGate.
- Definir padrao de hospedagem por componente (codigo, banco, API, app, firmware).
- Definir padrao de versionamento e fluxo de releases.
- Definir governanca de desenvolvimento com Issues, Projects, Branches e Pull Requests.
- Definir roadmap tecnico inicial de arquitetura antes de novas implementacoes.

## Requisitos Funcionais do Blueprint
- RF01: Estrutura de diretorios oficial para app, backend, esp32, database e docs.
- RF02: Modelo de banco PostgreSQL formalizado para usuarios, dispositivos, acessos e veiculos.
- RF03: Contrato inicial de endpoints da API documentado.
- RF04: Mapeamento inicial de telas do aplicativo documentado.
- RF05: Fluxo de comunicacao API <-> ESP32 documentado.
- RF06: Design System inicial alinhado a identidade Madu Informatica.

## Requisitos Nao Funcionais
- RNF01: Codigo versionado no GitHub; dados persistidos em servico externo PostgreSQL.
- RNF02: Seguranca baseline: bcrypt, JWT, HTTPS, validacao, logs e mitigacao de forca bruta.
- RNF03: Evolucao sem troca de base arquitetural.
- RNF04: Preparacao para CI/CD e release management.

## Fora de Escopo (Nesta Spec)
- Implementacao completa de novas features de negocio.
- Mudanca imediata de infraestrutura de producao.
- Integracoes avancadas de IA e visao computacional.

## Estrutura Alvo do Repositorio
- app/
- backend/
- esp32/
- database/
- docs/
- assets/
- logo/

## Definicao de Hospedagem
- Codigo: GitHub
- Banco PostgreSQL: Supabase (padrao atual) ou Neon
- API: Render (inicial) ou equivalente
- App mobile: pipeline GitHub + distribuicao Android/iOS
- Firmware: versionado no monorepo

## Criterios de Pronto
- Arquitetura validada e documentada.
- Modelo de dados base validado.
- Contratos iniciais da API definidos.
- Fluxos de app e ESP32 especificados.
- Roadmap tecnico e tarefas priorizadas para implementacao.
