# dab-practice

Proyecto de practica con Databricks Asset Bundles.

El bundle despliega un flujo end-to-end:

1. Crea un schema por target.
2. Crea un volumen gestionado `inputs` como dropzone de CSVs.
3. Ejecuta un job con trigger de File Arrival sobre el volumen.
4. La primera task ejecuta `src/create_table.py` y crea la tabla Delta `ventas`.
5. La segunda task ejecuta el pipeline DLT `etl_pipeline`, que crea la vista materializada `ventas_por_zona`.

## Estructura

```text
.
|-- databricks.yml
|-- resources
|   |-- elt.pipeline.yml
|   |-- job.yml
|   |-- schema.yml
|   `-- volume.yml
|-- src
|   |-- create_table.py
|   `-- pipeline_etl
|       `-- transformations
|           `-- ventas_por_zona.sql
`-- data
    |-- data1.csv
    `-- data2.csv
```

## Validacion

```bash
databricks bundle validate -t dev
databricks bundle validate -t qa
databricks bundle validate -t prod
```

## Despliegue

```bash
databricks bundle deploy -t dev
```

Luego subir los CSVs del directorio `data` al volumen:

```text
/Volumes/data-growth/dab_practice_dev/inputs/
```

En `dev` y `qa` los triggers quedan pausados. En `prod` el trigger queda activo.
