# Arquitetura

## Visao de Alto Nivel
Madu Gate e um ecossistema modular com tres dominios tecnicos:
- Aplicativo movel Flutter para operacao de usuarios finais.
- Backend Node.js + Express para regras de negocio, autenticacao e auditoria.
- Camada embarcada ESP32 para acionamento fisico de portoes e cancelas.

Arquitetura de referencia:
- iPhone / Android -> Flutter -> Node.js API -> PostgreSQL (Supabase) -> ESP32 -> Rele -> Central RCG.

## Componentes

### App (Flutter)
- Interface de login.
- Acionamento de portao/cancela.
- Visualizacao de historico de acessos.
- Recebimento de notificacoes.

### Backend (Node.js + Express)
- API REST versionada.
- Autenticacao via JWT.
- Camada de servicos com regras de negocio.
- Persistencia em PostgreSQL.
- Modulo administrativo para usuarios, acessos e configuracoes.

### Banco de Dados (PostgreSQL)
- Usuarios e perfis.
- Dispositivos/gates/cancelas.
- Veiculos e credenciais.
- Eventos de acesso (auditoria).

### ESP32
- Firmware para receber comandos autorizados.
- Acionamento de rele/porta.
- Telemetria basica de disponibilidade.
- Estrategia OTA para atualizacao futura.

## Diretrizes de Seguranca
- Senhas com hash robusto (bcrypt).
- Tokens JWT com expiracao e renovacao segura.
- Validacao de entrada em todas as rotas.
- Registro de eventos sensiveis para auditoria.
- Comunicacao HTTPS em ambientes externos.
- Mitigacao de forca bruta em rotas de autenticacao.
- Politica de expiracao e rotacao de tokens.

## Modelo de Dados Base
- Usuarios: id, nome, email, senha hash, perfil, ativo.
- Dispositivos: id, nome, esp32, local, status.
- Acessos: id, usuario, data_hora, tipo_origem, resultado.
- Veiculos (expansao): placa, modelo, cor, proprietario.

## Evolucao Planejada
- Fase IA: reconhecimento de placas e OCR.
- Fase cloud: conteinerizacao e escalabilidade com Docker.
- Fase integracoes: multiplas cancelas e dispositivos externos.
