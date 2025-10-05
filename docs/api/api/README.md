# API ProveedoresArg — Prototipo Java

## Objetivo
Exponer endpoints REST para:
- Alta/validación de proveedores
- Búsqueda y ficha
- Registro de eventos de analítica
- Generación de reportes mensuales

## Endpoints
Ver [`openapi.yaml`](openapi.yaml).

## Sugerencia de stack
- Java 17+, Gradle/Maven
- Web framework a elección (Spring Boot / Javalin / SparkJava)
- JDBC (MySQL Connector/J) + HikariCP
- Capa `service` para reglas de negocio, `repository` para acceso a datos

## Estructura sugerida
api/
├─ src/main/java/...
├─ src/main/resources/
├─ pom.xml (o build.gradle)
└─ README.md

> Este módulo se entrega como **prototipo operacional** (Kendall & Kendall, 2011). Puede incluir sólo algunos casos de uso priorizados.
