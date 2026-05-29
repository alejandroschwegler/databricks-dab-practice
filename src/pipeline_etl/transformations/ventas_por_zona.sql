CREATE OR REFRESH MATERIALIZED VIEW ventas_por_zona
AS SELECT
    zip_code,                   
    SUM(amount) AS total_ventas,
    COUNT(*) as total_transacciones
FROM `${source_catalog}`.${source_schema}.ventas
GROUP BY zip_code;
