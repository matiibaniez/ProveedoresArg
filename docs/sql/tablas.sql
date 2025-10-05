CREATE TABLE usuario (
  id BINARY(16) PRIMARY KEY,
  email VARCHAR(120) UNIQUE NOT NULL,
  pass_hash VARCHAR(255) NOT NULL,
  rol ENUM('ADMIN','PROVEEDOR') NOT NULL,
  estado ENUM('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO'
);

CREATE TABLE proveedor (
  id BINARY(16) PRIMARY KEY,
  usuario_id BINARY(16) NOT NULL UNIQUE,
  cuit VARCHAR(20) UNIQUE NOT NULL,
  razon_social VARCHAR(160) NOT NULL,
  rubro VARCHAR(120) NOT NULL,
  zonas VARCHAR(200),
  whatsapp VARCHAR(40),
  estado ENUM('PENDIENTE','APROBADO','SUSPENDIDO') NOT NULL DEFAULT 'PENDIENTE',
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE membresia (
  id BINARY(16) PRIMARY KEY,
  proveedor_id BINARY(16) NOT NULL UNIQUE,
  plan VARCHAR(40) NOT NULL,
  inicio DATE NOT NULL,
  fin DATE NOT NULL,
  estado ENUM('VIGENTE','VENCIDA','SUSPENDIDA') NOT NULL,
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id)
);

CREATE TABLE perfil (
  id BINARY(16) PRIMARY KEY,
  proveedor_id BINARY(16) NOT NULL UNIQUE,
  descripcion VARCHAR(500),
  url_catalogo VARCHAR(255),
  url_sitio VARCHAR(255),
  destacado BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id)
);

CREATE TABLE evento_analitica (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  proveedor_id BINARY(16) NOT NULL,
  tipo ENUM('IMPRESION','VISTA','CLICK_WHATSAPP','CLICK_CATALOGO') NOT NULL,
  origen VARCHAR(80),
  ts TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_ev_prov_ts (proveedor_id, ts),
  INDEX idx_ev_tipo_ts (tipo, ts),
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id)
);

CREATE TABLE reporte_mensual (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  proveedor_id BINARY(16) NOT NULL,
  periodo CHAR(7) NOT NULL, -- YYYY-MM
  apariciones INT NOT NULL,
  vistas INT NOT NULL,
  clicks_whatsapp INT NOT NULL,
  clicks_catalogo INT NOT NULL,
  var_apariciones DECIMAL(7,2),
  var_clicks DECIMAL(7,2),
  url VARCHAR(255),
  UNIQUE KEY uk_rep (proveedor_id, periodo),
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id)
);

