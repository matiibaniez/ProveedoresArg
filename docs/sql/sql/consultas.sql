-- Consolidado por período
SET @periodo := '2025-08';
SELECT p.razon_social,
       SUM(e.tipo='IMPRESION') AS apariciones,
       SUM(e.tipo='VISTA') AS vistas,
       SUM(e.tipo='CLICK_WHATSAPP') AS clicks_whatsapp,
       SUM(e.tipo='CLICK_CATALOGO') AS clicks_catalogo
FROM proveedor p
JOIN evento_analitica e ON e.proveedor_id = p.id
WHERE DATE_FORMAT(e.ts, '%Y-%m') = @periodo
GROUP BY p.id;

-- Generación de reporte mensual (consolidado a tabla)
INSERT INTO reporte_mensual
(proveedor_id, periodo, apariciones, vistas, clicks_whatsapp, clicks_catalogo, var_apariciones, var_clicks, url)
SELECT p.id, @periodo,
       SUM(e.tipo='IMPRESION'), SUM(e.tipo='VISTA'),
       SUM(e.tipo='CLICK_WHATSAPP'), SUM(e.tipo='CLICK_CATALOGO'),
       NULL, NULL,
       CONCAT('/reportes/', BIN_TO_UUID(p.id), '/', @periodo, '.pdf')
FROM proveedor p
LEFT JOIN evento_analitica e ON e.proveedor_id = p.id
  AND DATE_FORMAT(e.ts, '%Y-%m') = @periodo
GROUP BY p.id
ON DUPLICATE KEY UPDATE
  apariciones = VALUES(apariciones),
  vistas = VALUES(vistas),
  clicks_whatsapp = VALUES(clicks_whatsapp),
  clicks_catalogo = VALUES(clicks_catalogo),
  url = VALUES(url);

-- Variaciones respecto del mes anterior
SET @periodo_prev := '2025-07';
UPDATE reporte_mensual r
JOIN (
  SELECT cur.proveedor_id,
         100.0 * (cur.apariciones - COALESCE(prev.apariciones,0)) / NULLIF(prev.apariciones,0) AS var_apar,
         100.0 * ((cur.clicks_whatsapp + cur.clicks_catalogo) - COALESCE(prev.clicks_whatsapp + prev.clicks_catalogo,0))
               / NULLIF((prev.clicks_whatsapp + prev.clicks_catalogo),0) AS var_clicks
  FROM reporte_mensual cur
  LEFT JOIN reporte_mensual prev
    ON prev.proveedor_id = cur.proveedor_id AND prev.periodo = @periodo_prev
  WHERE cur.periodo = @periodo
) x ON x.proveedor_id = r.proveedor_id AND r.periodo=@periodo
SET r.var_apariciones = x.var_apar,
    r.var_clicks = x.var_clicks;

-- Borrados de ejemplo
-- DELETE FROM evento_analitica WHERE proveedor_id=@p AND ts BETWEEN '2025-08-01' AND '2025-08-31';
-- DELETE FROM reporte_mensual WHERE proveedor_id=@p AND periodo='2025-08';

