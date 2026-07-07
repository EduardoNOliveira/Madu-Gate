# Projeto: Madu Gate

## Nome Oficial
Madu Gate

## Slogan
Controle inteligente de acesso.

## Missao
Oferecer uma plataforma segura, moderna e intuitiva para controle de acesso de residencias, condominios, empresas e instituicoes.

## Objetivos de Produto
- Viabilizar abertura segura de portoes e cancelas por dispositivos moveis.
- Centralizar gestao de acessos (usuarios, visitantes, veiculos e eventos).
- Fornecer rastreabilidade por meio de historico e relatorios.
- Permitir evolucao gradual para IA de visao computacional e operacao em escala.

## Publico-Alvo
- Residencias e condominios.
- Empresas de pequeno, medio e grande porte.
- Estacionamentos.
- Instituicoes de ensino, com foco inicial em cenarios como UFBA.

## Escopo Inicial (V1)
- Autenticacao com e-mail e senha.
- Abertura de portao pelo app.
- Historico de acessos.
- Cadastro e administracao de usuarios.
- Configuracao basica de ESP32.
- Painel administrativo web.

## Escopo Futuro
- Controle remoto pela internet.
- Multiportao e multicondominio.
- Reconhecimento de placas (OpenCV + YOLO + EasyOCR).
- Integracoes com wearables e sistemas automotivos.

## Stack Padrao do Projeto
- Flutter (Android e iOS).
- Node.js + Express.
- PostgreSQL com Supabase.
- ESP32 para camada embarcada.
- JWT + bcrypt para autenticacao e credenciais.
- GitHub para versionamento e fluxo de entrega.
- Render (ou equivalente) para hospedagem futura da API.

## Principios de Evolucao
- Crescer sem trocar a base arquitetural.
- Reaproveitar o mesmo app para residencial, condominio, empresa e estacionamento.
- Manter compatibilidade com expansao para multiplos portoes, fechaduras, cameras e visao computacional.
- Priorizar seguranca e rastreabilidade desde a primeira versao.
