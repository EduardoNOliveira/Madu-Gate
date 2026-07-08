# ESP32 - Madu Gate

## Objetivo
Controlar acionamento de portao com rastreabilidade e seguranca.

## Topicos
- Provisionamento Wi-Fi
- OTA (over-the-air)
- Acionamento de rele
- Heartbeat do dispositivo
- Seguranca de comunicacao (token/chave)

## Estrutura
- Firmware em esp32/firmware/
- OTA em esp32/firmware/OTA/

## Recomendacoes
- Nao hardcode de credenciais
- Assinatura de firmware para OTA
- Timeout e retry para rede instavel
