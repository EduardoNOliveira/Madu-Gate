INSERT INTO gates (name, location, is_active)
VALUES
  ('Portao Principal', 'Entrada principal', TRUE),
  ('Cancela Estacionamento', 'Acesso veicular', TRUE)
ON CONFLICT DO NOTHING;
