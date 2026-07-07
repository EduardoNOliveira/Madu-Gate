# Spec 000 - Foundation do Madu Gate

## Contexto
Madu Gate nasce como plataforma de controle inteligente de acesso para cenarios residenciais, empresariais, estacionamentos e instituicoes de ensino.

## Problema
Solucoes de acesso tradicionais costumam ser fragmentadas, com pouca rastreabilidade e baixa flexibilidade para multiplos contextos (portoes, cancelas, visitantes, veiculos e perfis distintos).

## Objetivo da Feature
Definir os fundamentos funcionais e tecnicos da versao inicial (1.0), estabelecendo identidade de produto, escopo e estrutura base de implementacao.

## Escopo
- Definir identidade oficial: nome, slogan, missao e pilares.
- Consolidar segmentos atendidos e seus casos de uso.
- Definir stack tecnologica oficial e roadmap evolutivo.
- Estruturar repositorio para desenvolvimento por modulos.
- Definir arquitetura de referencia ponta a ponta para escala futura.

## Requisitos Funcionais (V1)
- RF01: Login com e-mail e senha.
- RF02: Abertura de portao/cancela pelo celular.
- RF03: Historico de acessos por usuario/dispositivo.
- RF04: Cadastro e administracao de usuarios.
- RF05: Configuracao inicial de dispositivos ESP32.
- RF06: Painel administrativo web.

## Requisitos Nao Funcionais
- RNF01: Senhas com hash bcrypt.
- RNF02: Autenticacao e autorizacao com JWT e expiracao de tokens.
- RNF03: Comunicacao HTTPS em ambientes externos.
- RNF04: Validacao de entrada em todas as rotas e servicos criticos.
- RNF05: Registro de logs e auditoria de eventos sensiveis.
- RNF06: Mitigacao de forca bruta em autenticacao.
- RNF07: Persistencia confiavel com PostgreSQL (Supabase).
- RNF08: Arquitetura modular para evolucao sem troca de base.

## Fora de Escopo (Agora)
- Reconhecimento de placas em producao.
- Integracoes com Apple Watch, Android Auto e CarPlay.
- Operacao cloud completa com Docker em ambiente final.

## Impacto em Modulos
- app/: telas e fluxos mobile.
- backend/: API, regras de negocio e autenticacao.
- esp32/: firmware e comunicacao com atuadores.
- database/: migracoes e scripts de suporte.
- docs/: registros funcionais e tecnicos.

## Arquitetura de Referencia
- iPhone/Android -> Flutter -> Node.js API -> PostgreSQL (Supabase) -> ESP32 -> Rele -> Central RCG.

## Stack Oficial
- Flutter (Android e iPhone).
- Node.js + Express.
- Supabase (PostgreSQL).
- ESP32.
- JWT + bcrypt.
- GitHub para versionamento.
- Render (ou equivalente) para hospedagem futura da API.
