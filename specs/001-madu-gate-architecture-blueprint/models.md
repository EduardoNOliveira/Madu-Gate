# Models - Spec 001

## Modelo Conceitual Inicial

### users
- id
- name
- email
- password_hash
- role (admin, user, visitor)
- is_active
- created_at
- updated_at

### devices
- id
- name
- esp32_id
- location
- status
- created_at

### access_events
- id
- user_id
- device_id
- access_type (app, qr_code, plate)
- result (opened, denied, failed)
- created_at

### vehicles
- id
- plate
- model
- color
- owner_name
- is_active
- created_at

## Regras Iniciais
- email unico em users.
- plate unica em vehicles.
- acesso sempre vinculado a user e device.
- logs de acesso imutaveis para auditoria.

## Observacoes de Evolucao
- Preparar particionamento de access_events em alto volume.
- Prever multi-tenant futuro (condominio/empresa) sem reescrita total.
