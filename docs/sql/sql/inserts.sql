-- Usuario y proveedor de ejemplo
SET @u := UUID_TO_BIN(UUID());
INSERT INTO usuario (id, email, pass_hash, rol, estado)
VALUES (@u, 'ventas@proveedor.com', 'hash...', 'PROVEEDOR', 'ACTIVO');

SET @p := UUID_TO_BIN(UUID());
INSERT INTO proveedor (id, usuario_id, cuit, razon_social, rubro, zonas, whatsapp, estado)
VALUES (@p, @u, '30-12345678-9', 'Mayorista SRL', 'Electrónica', 'Córdoba', '+549351000000', 'APROBADO');

INSERT INTO membresia (id, proveedor_id, plan, inicio, fin, estado)
VALUES (UUID_TO_BIN(UUID()), @p, 'STANDARD', '2025-08-01', '2025-10-31', 'VIGENTE');

INSERT INTO perfil (id, proveedor_id, descripcion, url_catalogo, url_sitio, destacado)
VALUES (UUID_TO_BIN(UUID()), @p, 'Distribuidor Apple/Accesorios', 'https://catalogo...', 'https://sitio...', TRUE);

-- Eventos (ejemplo)
INSERT INTO evento_analitica (proveedor_id, tipo, origen, ts) VALUES
(@p, 'IMPRESION', 'search', NOW()),
(@p, 'VISTA', 'listing', NOW()),
(@p, 'CLICK_CATALOGO', 'profile', NOW()),
(@p, 'CLICK_WHATSAPP', 'profile', NOW());

