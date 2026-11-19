# Atlas - Pruebas automatizadas (EP3 ISY1102)

Suite de automatizacion para el caso semestral **Atlas**. Cubre dos frentes:

- **API (Newman / Postman):** pruebas funcionales, de integracion y de seguridad contra la API (`http://localhost:5000`).
- **Interfaz (Cypress):** pruebas funcionales E2E sobre el frontend (`http://localhost:3000`).

Todo se ejecuta **en local**, contra los contenedores Docker del caso, con datos de prueba sinteticos (seed). **Nunca** usa datos reales de clientes.

Usuarios del seed: `admin@atlas.cl` y `editor@atlas.cl`, contrasena `Password123!`.

---

## 0. Requisitos (una sola vez)

- **Docker Desktop** instalado y corriendo.
- **Node.js 20** (incluye `npm` y `npx`).
- **Newman** (runner de Postman por consola):

```cmd
npm install -g newman
```

---

## 1. Levantar Atlas

En la carpeta del codigo del caso (donde esta `docker-compose.yml`):

```cmd
docker compose up -d --build
docker compose ps
```

Verifica que los 3 contenedores (db, backend, frontend) esten `running` / `healthy`.
Frontend: http://localhost:3000 - API: http://localhost:5000/api/health

---

## 2. Correr las pruebas de API (Newman)

Desde la carpeta `atlas-automation\api`:

```cmd
cd api
newman run atlas_api.postman_collection.json -e atlas_env.postman_environment.json --reporters cli,htmlextra --reporter-htmlextra-export reporte_api.html
```

Si no tienes el reporte HTML instalado:

```cmd
npm install -g newman-reporter-htmlextra
```

- La **captura** de la salida (verde/rojo) de la consola es la evidencia de **IE5**.
- El archivo `reporte_api.html` queda como evidencia para el **Anexo**.

> La coleccion usa variables encadenadas: el login guarda el token y los casos
> siguientes lo reutilizan. Corre la coleccion completa, no casos sueltos.

---

## 3. Correr las pruebas de interfaz (Cypress)

Desde la carpeta `atlas-automation\e2e` (la primera vez descarga Cypress):

```cmd
cd e2e
npm install
npx cypress run --spec "cypress/e2e/funcionales.cy.js"
```

- Cypress deja **video** en `e2e\cypress\videos\` y **capturas** de los fallos en
  `e2e\cypress\screenshots\`: esa es la evidencia E2E.
- Para verlo paso a paso en modo visual: `npx cypress open`.

---

## 4. Que casos cubre

| Caso | Herramienta | Que valida |
|------|-------------|-----------|
| CP-FUN-01 | Newman + Cypress | Login valido devuelve token / entra al panel |
| CP-FUN-02 | Newman + Cypress | Login invalido y campos vacios (401 / 400) |
| CP-FUN-03 | Cypress | Cerrar sesion vuelve al login |
| CP-FUN-11 | Newman + Cypress | Crear cliente (201 / aparece en la lista) |
| CP-FUN-12 | Newman | Listar clientes |
| CP-FUN-13 | Newman | Eliminar cliente (admin) -> 200 |
| CP-FUN-09 | Newman + Cypress | RBAC: el editor no puede eliminar -> 403 |
| CP-SEG-04 | Newman | Acceso sin token / token basura -> 401 |
| CP-SEG-05 | Newman | Inyeccion SQL en login -> 401 sin bypass |

---


## Evidencia automatica (sin capturas manuales)

Las pruebas de **Cypress** ahora generan la evidencia solas:

- Cada caso llama a `cy.evidencia(...)`, que **estampa en pantalla** el id del caso,
  el estado, la **URL** y la **fecha/hora**, y luego toma la captura.
- Las imagenes quedan en `e2e\cypress\screenshots\` con el nombre del caso
  (CP-FUN-01_login_valido.png, etc.) y el **video** completo en `e2e\cypress\videos\`.
- No hay que abrir la app ni sacar pantallazos a mano: se corre la suite y la
  carpeta de screenshots ya es el anexo de evidencia.

Para la **API**, la evidencia es el reporte `reporte_api.html` que genera Newman.

## 5. Para el informe (seccion de automatizacion)

1. Corre las dos suites y guarda las capturas + el `reporte_api.html` + el video de Cypress.
2. Anota el **tiempo total** de cada suite (Newman y Cypress lo muestran al final).
3. En la seccion de automatizacion del informe, compara ese tiempo con lo que
   tomaria ejecutar los mismos casos **a mano** (ese contraste es el corazon de IE6).
4. Regla de evidencia: **"si no hay foto, no paso"** - captura en el momento, nunca al final.
