# Tasks - Spec 000

## Fase 1 - Fundacao
- [x] Definir nome oficial, slogan e missao.
- [x] Consolidar escopo funcional da versao 1.0.
- [x] Consolidar stack tecnologica.
- [x] Consolidar stack oficial com Supabase como padrao.
- [x] Definir arquitetura de referencia ponta a ponta.
- [x] Criar estrutura inicial de diretorios.
- [x] Criar documentacao base do projeto.
- [x] Alinhar spec, plan e docs com diretriz oficial de arquitetura e seguranca.

## Fase 2 - Backend (Proxima)
- [x] Inicializar projeto Node.js + Express.
- [x] Definir estrutura de rotas, controllers e services.
- [x] Implementar autenticacao JWT (login e refresh).
- [x] Implementar CRUD inicial de usuarios e perfis.
- [x] Implementar CRUD inicial de visitantes.
- [x] Implementar CRUD inicial de veiculos.
- [x] Implementar endpoint de comando de abertura.
- [x] Implementar endpoint de historico de acessos.
- [x] Configurar conexao PostgreSQL e migracoes.
- [x] Adaptar conexao para Supabase (SSL + DATABASE_URL).
- [x] Criar bootstrap com seed de admin.

## Fase 3 - App Mobile (Proxima)
- [x] Inicializar app Flutter (base manual do projeto).
- [x] Implementar tela de login.
- [x] Implementar botao de abertura de portao.
- [x] Implementar listagem de historico.
- [x] Integrar fluxo com API backend.

## Fase 4 - ESP32 (Proxima)
- [ ] Definir protocolo de comunicacao inicial.
- [ ] Implementar recepcao de comando autenticado.
- [ ] Implementar acionamento de rele.
- [ ] Implementar retorno de status para backend.

## Fase 5 - Qualidade e Release (Proxima)
- [ ] Definir testes de API e contratos.
- [ ] Definir testes basicos de interface no app.
- [x] Definir checklist de seguranca da V1 (dependencias auditadas e env padrao).
- [ ] Implementar rate limit e bloqueio progressivo para mitigacao de forca bruta.
- [ ] Garantir HTTPS fim a fim no ambiente publicado.
- [ ] Preparar release notes da versao 1.0.
